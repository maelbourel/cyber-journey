#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from proxmoxer import ProxmoxAPI
import os
import time
import re
import paramiko

# ================= PROXMOX API =================
PVE_HOST = "51.178.23.21"
PVE_PORT = 8006
VERIFY_SSL = False

PVE_USER = "user1@pve"
PVE_PASSWORD = os.environ.get("PVE_PASSWORD")
NODE = "ns31186284"

# ================= SSH =================
SSH_HOST = PVE_HOST
SSH_PORT = 22
SSH_USER = "user"
SSH_PASSWORD = os.environ.get("PVE_SSH_PASSWORD")

QM = "/usr/sbin/qm"
QM_SUDO = f"sudo -n {QM}"

# ================= VM =================
VM_NAME = "debian12-Mael"
RAM_MB = 4096
SOCKETS = 2
CORES = 2

STORAGE = "local"
BRIDGE = "vmbr2"

CLOUD_IMAGE_PATH = "/var/lib/vz/template/iso/debian-12-genericcloud-amd64.qcow2"
CI_SNIPPET = "local:snippets/debian-users.yaml"
RESIZE_DELTA = "+48G"


def wait_task(proxmox, node, upid, timeout=900):
    start = time.time()
    while True:
        task = proxmox.nodes(node).tasks(upid).status.get()
        if task.get("status") == "stopped":
            if task.get("exitstatus") != "OK":
                raise RuntimeError(f"Tâche échouée: {task.get('exitstatus')} (UPID={upid})")
            return
        if time.time() - start > timeout:
            raise TimeoutError(f"Timeout tâche Proxmox ({timeout}s) UPID={upid}")
        time.sleep(2)


def ssh_run(cmd: str) -> str:
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(
        hostname=SSH_HOST,
        port=SSH_PORT,
        username=SSH_USER,
        password=SSH_PASSWORD,
        look_for_keys=False,
        allow_agent=False,
        timeout=20,
    )
    try:
        _, stdout, stderr = client.exec_command(cmd)
        out = stdout.read().decode("utf-8", errors="replace")
        err = stderr.read().decode("utf-8", errors="replace")
        rc = stdout.channel.recv_exit_status()
        if rc != 0:
            raise RuntimeError(f"SSH cmd failed (rc={rc}): {cmd}\n{out}\n{err}")
        return out + err
    finally:
        client.close()


def get_imported_volid_from_qm_config(vmid: int) -> str:
    """
    Après qm importdisk, Proxmox met souvent le disque en 'unused0: <VOLID>'.
    On lit qm config et on extrait unused0.
    """
    cfg = ssh_run(f"{QM_SUDO} config {vmid}")
    m = re.search(r"^unused0:\s*(\S+)\s*$", cfg, flags=re.MULTILINE)
    if not m:
        # parfois unused1 etc.
        m = re.search(r"^unused\d+:\s*(\S+)\s*$", cfg, flags=re.MULTILINE)
    if not m:
        raise RuntimeError(
            "Impossible de trouver le disque importé (unused0) dans 'qm config'.\n"
            f"Sortie qm config:\n{cfg}"
        )
    return m.group(1)


def main():
    if not PVE_PASSWORD:
        raise SystemExit('❌ PVE_PASSWORD absent. PowerShell:  $env:PVE_PASSWORD="..."')
    if not SSH_PASSWORD:
        raise SystemExit('❌ PVE_SSH_PASSWORD absent. PowerShell:  $env:PVE_SSH_PASSWORD="..."')

    proxmox = ProxmoxAPI(
        PVE_HOST,
        user=PVE_USER,
        password=PVE_PASSWORD,
        port=PVE_PORT,
        verify_ssl=VERIFY_SSL,
    )

    vmid = int(proxmox.cluster.nextid.get())
    print(f"➡️ VMID attribué : {vmid}")

    net0 = f"virtio,bridge={BRIDGE}"

    # 1) Créer la VM
    print("🛠 Création de la VM…")
    upid = proxmox.nodes(NODE).qemu.create(
        vmid=vmid,
        name=VM_NAME,
        memory=RAM_MB,
        sockets=SOCKETS,
        cores=CORES,
        net0=net0,
        ostype="l26",
        scsihw="virtio-scsi-pci",
        agent=1,
        bios="seabios",
        onboot=1,
        boot="order=scsi0;ide2;net0",
    )
    wait_task(proxmox, NODE, upid)

    # 2) Import cloud image via SSH
    print("📦 Import de l’image cloud via SSH (sudo qm)…")
    try:
        ssh_run(f"{QM_SUDO} disk import {vmid} {CLOUD_IMAGE_PATH} {STORAGE}")
    except RuntimeError:
        ssh_run(f"{QM_SUDO} importdisk {vmid} {CLOUD_IMAGE_PATH} {STORAGE}")

    # 3) Trouver le volid réellement créé (unused0) et l'attacher en scsi0
    print("🔎 Détection du disque importé (unused0)…")
    volid = get_imported_volid_from_qm_config(vmid)
    print(f"   -> volid importé: {volid}")

    print("💾 Attachement du disque en scsi0…")
    # On attache via qm set (plus robuste) plutôt que via API
    ssh_run(f"{QM_SUDO} set {vmid} --scsihw virtio-scsi-pci --scsi0 {volid},ssd=1,discard=on")

    # 4) Resize
    print("📐 Resize du disque…")
    ssh_run(f"{QM_SUDO} resize {vmid} scsi0 {RESIZE_DELTA}")

    # 5) Cloud-init drive (via API)
    print("☁️ Ajout du disque cloud-init…")
    upid = proxmox.nodes(NODE).qemu(vmid).config.post(ide2=f"{STORAGE}:cloudinit")
    wait_task(proxmox, NODE, upid)

    # 6) YAML + DHCP
    print("📄 Application du YAML cloud-init…")
    upid = proxmox.nodes(NODE).qemu(vmid).config.post(
        cicustom=f"user={CI_SNIPPET}",
        ipconfig0="ip=dhcp",
    )
    wait_task(proxmox, NODE, upid)

    # 7) Start
    print("▶️ Démarrage de la VM…")
    upid = proxmox.nodes(NODE).qemu(vmid).status.start.post()
    wait_task(proxmox, NODE, upid)

    print("\n✅ VM créée et démarrée")
    print(f"➡️ VMID : {vmid}")
    print("➡️ SSH ensuite : ssh mael@IP_DE_LA_VM  (ou jordan@IP_DE_LA_VM)")


if __name__ == "__main__":
    main()
