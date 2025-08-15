#!/usr/bin/python3 
# -*-coding:utf8 -*

import shutil as sh
import os
import fnmatch
import os.path
from re import sub
from unidecode import unidecode
from pathlib import Path

# Répertoire où on a déplacé les fichiers pdfs téléchargés par ELEA
DirOrig = "./orig/"
DirGrille = "./grille/"
DirXournal = "./xopp/"

# Les fichiers pdf originaux sont dans orig
# Les fichiers pdf avec la grille (à annoter) sont dans grille
# Les fichiers xopp sont dans xopp

for i in [DirGrille,DirXournal]:
    if not os.path.exists(i):
        os.makedirs(i)

Grille_PDF="/home/wilk/enseignement/TP/grille-evaluation.pdf"

for fichier in Path(DirOrig).glob("*.pdf"):
    if os.path.isfile(fichier):
        fichier_nom_base = os.path.basename(fichier)
        fichier_grilledir = DirGrille+fichier_nom_base
        if not os.path.isfile(fichier_grilledir):
            print('on grille ' + fichier_nom_base)
            commande = "pdftk " + Grille_PDF + " " + "'" + str(fichier) + "'" + " cat output "  + "'" + DirGrille + str(fichier_nom_base) + "'"
            print(commande)
            os.system(commande)
        else:
            print(f'grille présente pour {fichier_nom_base}')
    else:
        print(f'problème avec {fichier}')

