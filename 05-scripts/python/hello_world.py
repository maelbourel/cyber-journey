import random

nombre_mystere = random.randint(1, 100)
tentatives = 1

print (nombre_mystere) # pour par perde de temps pendant les tests
print("Bienvenue au jeu du nombre mystère !")
print ("Devinez le nombre mystère entre 1 et 100")

nombre_proposer = int(input("Entrez un nombre : "))

while nombre_proposer != nombre_mystere:

    tentatives += 1

    if nombre_proposer < nombre_mystere:
        print("Plus haut que ", nombre_proposer )
        nombre_proposer = int(input("Essayez encore : "))
    elif nombre_proposer > nombre_mystere:
        print("Plus bas que ", nombre_proposer )
        nombre_proposer = int(input("Essayez encore : "))


print("Félicitations ! Vous avez trouvé le nombre mystère", nombre_mystere ,"en", tentatives , "tentatives.")
print("Merci d'avoir joué !")
