#!/bin/bash

password=$(openssl rand -base64 4)

sudo useradd -m "$1" 
echo "$1:$password" | sudo chpasswd

echo "L'utilisateur $1 a était crée avec le mdp : $password "