import random

nombre_mystere = random.randint(1, 100)
tentatives = 0


print("Bienvenue au jeu du nombre mystère !")
print (nombre_mystere)
print ("Devinez le nombre mystère entre 1 et 100")

essai = int(input("Entrez votre essai : "))

while True:

    tentatives += 1

    if essai < nombre_mystere:
        print("Plus haut que ", essai )
        essai = int(input("Essayez encore : "))
    elif essai > nombre_mystere:
        print("Plus bas que ", essai )
        essai = int(input("Essayez encore : "))
    elif essai == nombre_mystere:
        print(f"Félicitations ! Vous avez trouvé le nombre mystère {nombre_mystere} en {tentatives} tentatives.")
        break

print("Merci d'avoir joué !")


      #  essai = int(input("Plus haut que ! Essayez encore : "))