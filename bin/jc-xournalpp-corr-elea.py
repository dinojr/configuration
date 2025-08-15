#!/usr/bin/python3 
# -*-coding:utf8 -*

import shutil as sh
import os
import fnmatch
import os.path
from re import sub
from unidecode import unidecode
from pathlib import Path

DirOrig = "./orig/"
DirCorr = "./corr/"
DirXournal = "./xopp/"

# Les fichiers pdf à annoter sont dans orig
# Les fichiers xopp sont dans xopp
# Les fichiers pdf annotés sont dans corr

for i in [DirXournal,DirCorr]:
    if not os.path.exists(i):
        os.makedirs(i)

Xopp_suffix=".xopp"
Acorriger="Reste à corriger: "

Total=0

for fichier in Path(DirOrig).glob("*.pdf"):
    # print(fichier)
    if os.path.isfile(fichier):
        fichier_base_pdf = os.path.basename(fichier)
        # print(fichier_base_pdf)
        # fichier_xopp = fichier.with_suffix(Xopp_suffix)
        # print(fichier_xopp)
        fichier_xopp =  DirXournal + str.replace(fichier_base_pdf,'.pdf', '.xopp')
        print(fichier_xopp)
        fichier_corr = DirCorr + str.replace(fichier_base_pdf,'.pdf', '-corr.pdf')
        print(fichier_corr)
        
        commande = "xournalpp -p " + "'" + fichier_corr + "'" + " '" + fichier_xopp + "'"
        if os.path.isfile(fichier_xopp):
            if not os.path.isfile(fichier_corr) or os.path.getmtime(fichier_corr) < os.path.getmtime(fichier_xopp):
                print(f"on pdfise {fichier_base_pdf}")
                print(commande)
                os.system(commande)
            else:
                print(f'déjà corrigé {fichier_base_pdf}')
        else:
            print(f'pas corrigé {fichier_base_pdf}')
            Total += 1
    else:
        print(f'problème avec {fichier_base}')

print(f'{Acorriger}' + f'{Total}')
