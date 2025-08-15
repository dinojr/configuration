#!/usr/bin/python3 
# -*-coding:utf8 -*

import os
import os.path
from pathlib import Path
from numpy import array_split as split

suffix = input("Suffixe des fichiers à zipper (sans *): ")
nbre_fichiers = int(input("Nombre de zip à produire: "))

liste_fichiers = ["\'" + os.path.basename(i) + "\'" for i in Path("./").glob("*"+suffix)]
liste_fichiers_split = split(liste_fichiers,nbre_fichiers)

compteur = 0
for sublist in liste_fichiers_split:
    compteur +=1
    nom_fichier_zip = "final"+ str(compteur) +".zip"
    commande = "zip "+ nom_fichier_zip + " " + " ".join(sublist)
    # print(commande)
    os.system(commande)
