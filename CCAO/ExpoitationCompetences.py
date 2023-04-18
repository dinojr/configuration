# -*-coding:utf8 -*

#  Les imports
import csv  # Lecture fichier csv
# import xlrd # Lecture fichier excel
import numpy as np
import shutil as sh
import os
import fnmatch
import os.path
from re import sub
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('Gtk3Agg')
import sqlite3

import statistics as stat
 
# Repertoire de base dans lequel seront générés les fichiers
Repertoire = '/home/wilk/enseignement/2022-2023/CCAO/DS04/'
os.chdir(Repertoire)
os.environ['PATH'] = '/usr/local/texlive/current/bin/x86_64-linux:' + os.environ['PATH']
# blank_page = "/home/wilk/enseignement/2022-2023/CCAO/blank.pdf"

# attention aux caractères accentués, aux espaces on peut réduire les noms à 1 sous-chaîne commune aux fichiers de ProNote et ceux de CCAO
patronymes_fichier = "/home/wilk/enseignement/2022-2023/CCAO/patronymes.txt"

Repertoire_bilans = Repertoire
# Repertoire_corrections = "/media/wilk/torino/copies/DS/DS04/corr/"
Repertoire_corrections = "/home/wilk/enseignement/2022-2023/copies/DS05/corr/"

fmt_file = "/home/wilk/enseignement/2022-2023/CCAO/fiche_bilan_DS.fmt"
# produit par lualatex -ini --jobname="fiche_bilan_DS" "&lualatex" mylatexformat.ltx fiche_bilan_DS_exemple.tex

commande_compilation = "lualatex --interaction=batchmode --fmt=" + fmt_file + " "
commande_pagination = "pdfjam "

# On stocke dans chacune le fichier de corrections, le préfixe pour les fichiers, le coeff dans la note totale, le total max et le coeff seront calculés plus tard
dict_parties = dict()
Devoir = "DS05"
dict_parties['Pb1'] = ['/home/wilk/enseignement/2022-2023/CCAO/DS05/Pb1.cor.csv', 'DS05-Pb1', "12"]
dict_parties['Pb2'] = ['/home/wilk/enseignement/2022-2023/CCAO/DS05/Pb2.cor.csv', 'DS05-Pb2', "13"]


# ATTENTION le premier nom d'une liste importé par CCAO est préfixé par un caractère
# invisible qui met le bazar dans les noms de fichiers entre autres, et empêche leur
# compilation par lualatex. Une solution crade consiste à mettre un premier nom bidon
# LINCONNUANEPASENLEVER par exemple auquel on n'attribuera pas de notes
liste_noms = list() #sera peuplé par les fichiers en cor.csv
notes_globales_etudiants = dict()
notes_devoir_etudiants = dict()
RepertoireCommun = '/home/wilk/enseignement/2022-2023/CCAO/'
Devoir_Titre = 'DS05 du 11/02'

fichier_csv = Repertoire + Devoir + ".csv"

# Il faut modifier ligne 85 et suivantes l'identifiant de partie du DS et la première question
# Il faut modifier ligne 185 et suivantes l'identifiant du fichier de compétences

# Fonctions utilitaires pour rechercher un triplet dans la liste des notes des étudiants, ainsi que le rang d'un étudiant

def triplet_par_nom(nom, liste):
    # print("On entre dans triplet_par_nom")
    for i in range(len(liste)):
        if liste[i][2] == nom:
            return liste[i]
    return None


def rang(nom, liste):  # Fonction à améliorer pour gérer les ex-aquo !
    exaquo = 0
    for i in range(len(liste)):
        if liste[i][2] == nom:
            return i + 1

# MT Cette fonction à l'air d'avoir été reprise correctement ##
# Lecture du fichier des erreurs Il faut reprendre cette fonction. On
# ne lit plus un .csv. Tout est déjà dans la base de données.


# On crée un itérateur sur le fichier csv des compétences. Il faut
# préciser que le séparateur est le point-virgule. Il faut normalement
# à l'ouverture du fichier préciser le newline (c'est dans la doc)


# Création du dictionnaire de compétences. La clé d'insertion est le
# numéro d'identification de l'erreur. La valeur est la description en
# français de l'erreur. La clé d'insertion est à fabriquer en
# concaténant la catégorie et l'identifiant de l'erreur Avant c'était
# I.1, maitenant 1.1, mais cela ne devrait rien changer.

dict_erreurs_labels = dict()
# Il est probable qu'il sera inutile de créer (et donc d'alimenter) ce
# dictionnaire plus tard, car on peut lire directement les labels dans
# la base de données...

# Il faudrait faire ici quelque part l'initialisation de la base de donnée
# pathname = os.path.dirname(sys.argv[0]) # On va l'écrire en dur pour le moment

dbPathName = '/home/wilk/enseignement/2018-2019/CCAO/EvaluationDevoirsSurveilles.sqlite'

# ==================================================================
# Initialisation de la liste des erreurs et des catégories d'erreurs
# Le tout est stocké dans un dictionnaire de listes d'erreurs, la clé
# d'insertion étant l'identifiant de la catégorie
# ==================================================================

try:
    conn = sqlite3.connect(dbPathName)
    cursor = conn.cursor()
    # print("Connexion ouverte sur ", dbPathName)
except sqlite3.Error as e:
    print("An error occurred:", e.args[0])

try:
    # print("Lecture des erreurs", "SELECT cat_id, err_id, label FROM
    # Erreurs WHERE cat_id = " + str(cat_id) + " ORDER BY err_id;")
    cursor.execute("SELECT cat_id, err_id, label FROM Erreurs;")
    for enregistrement in cursor:
        dict_erreurs_labels[str(enregistrement[0]) + '.' + str(enregistrement[1])] = enregistrement[2]
except sqlite3.Error as e:
    print("An error occurred:", e.args[0])

# Liste des parties


noms_parties = [i for i in dict_parties]

# Lecture des fichiers de correction générés par CCAO

# Création d'un dictionnaire de notations, la clé est le nom de la
# partie, la valeur est un dictionnaire de notations dont La clé
# d'insertion est le nom de l'élève et la valeur est un dictionnaire
# de notes dans lequel la clé est le numéro de la question et la
# valeur un couple note obtenue, note maximale de la question. La note
# peut être None auquel cas l'étudiant n'a pas répondu à la question.
dict_notation_parties = dict()
questions_devoir_parties = dict()
dict_notes_parties = dict()
liste_notes_etudiants_parties = dict()

for i in dict_parties:
    dict_notation_parties[i] = dict()

    # On stocke dans l'ordre les questions rencontrées dans une liste
    questions_devoir_parties[i] = []

    # On stocke également toutes les notes des élèves par question
    # dans un dictionnaire pour pouvoir faire des statistiques. La clé
    # est un numéro de question. La valeur est une liste de note
    # (float) qu'on étend au fur et à mesure
    dict_notes_parties[i] = dict()

    # Enfin on stocke dans une liste que l'on pourra trier, les totaux
    # des étudiants, ainsi que la somme des points tentés.

    liste_notes_etudiants_parties[i] = []  # On met des triplets (note brute, total tenté, nom)

for partie in dict_parties:
    # On crée un itérateur sur le fichier csv de correction. Il faut
    # préciser que le séparateur est le point-virgule. Il faut
    # normalement à l'ouverture du fichier préciser le newline (c'est
    # dans la doc)
    chemin_partie = dict_parties[partie][0]
    print("Boucle sur les parties. Fichier :", chemin_partie)
    fichier_correction_partie = csv.reader(open(chemin_partie, "r", newline='', encoding='UTF-8'), delimiter=';')  # Attention le fichier généré par CCAO est en ISO-8859-1...

    row = next(fichier_correction_partie)  # Lecture de la première ligne. Si n est le nombre de colonnes, il y a n - 4 questions s'étendant des indices 1 à n - 4.
    ncols = len(row)
    nb_questions = ncols - 4
    questions = row[1: nb_questions + 1]  # On extrait les numéros de questions
    # print("Partie: ", partie, "Questions récupérées :", questions)
    questions_devoir_parties[partie].extend(questions)  # Et on les stocke

    # On crée les listes vides dans le dictionnaire dict_notes pour chaque question
    for question in questions:
        dict_notes_parties[partie][question] = []

    row = next(fichier_correction_partie)  # Lecture de la deuxième ligne, celle du barème.
    dict_parties[partie].append(float(str.replace(row[nb_questions+3], ',', '.')))  # Stockage du total du barême
    dict_parties[partie].append(float(dict_parties[partie][2])/dict_parties[partie][3])  # Stockage du coeff dans la note totale

    bareme = row[1:nb_questions + 1]
    # Là on récupère le total de
    # point de la question mais
    # également le découpage... On
    # supprime ce découpage

    print("Partie:", partie, " Bareme récupéré :", bareme)
    for i in range(len(bareme)):
        bareme[i] = str.split(bareme[i], "|")[0]

    # Maintenant on peut boucler sur la suite du fichier pour
    # récupérer les notes des élèves
    continuer = True
    print("Boucle sur les élèves")
    while continuer:
        try:
            # print("On passe dans le try")
            row = next(fichier_correction_partie)
            # Les notes
            # s'étendent des
            # indices 1 à
            # nb_questions

            # print("Dans le try row : ", row, row[0])
            nom = sub("[ \t]","_",row[0])
            print(nom)
            total = 0
            total_tenté = 0
            total_partie = 0
            # print("Juste avant triplet1 nom =, liste_nom_etudiants= ", nom, liste_notes_etudiants_parties[partie])

            triplet = triplet_par_nom(nom, liste_notes_etudiants_parties[partie])

            # print("Triplet 1", triplet)
            if triplet is not None:
                total = triplet[0]
                total_tenté = triplet[1]
            if nom not in dict_notation_parties[partie]:  # On regarde si on a déjà des notes pour cet étudiant
                print("on rajoute le nom", nom)
                dict_etudiant = dict()
                # print(dict_notation_parties)
                # dict_notation_parties[partie] = dict()
                dict_notation_parties[partie][nom] = dict_etudiant
                # print(dict_notation_parties[partie])
            else:
                print("on a déjà le nom", nom)
            # print(" on définit les notes")
            if nom not in notes_globales_etudiants:
                print("on rajoute le nom au fichier de notes", nom)
                notes_globales_etudiants[nom] = dict()
                notes_devoir_etudiants[nom] = 0
            notes = row[1: nb_questions + 1]
            for i in range(nb_questions):
                if not notes[i] == ' ':
                    dict_etudiant[questions[i]] = (notes[i], bareme[i])
                    # print("TOto", questions[i], notes[i],float(notes[i].replace(',','.')))
                    dict_notes_parties[partie][questions[i]].append(float(notes[i].replace(',', '.')))

                    # Gestion de la mémorisation des totaux et totaux_tenté
                    total = total + float(notes[i].replace(',', '.'))
                    total_tenté = total_tenté + float(bareme[i].replace(',', '.'))
                else:
                    dict_etudiant[questions[i]] = (None, bareme[i])
                    dict_notes_parties[partie][questions[i]].append(float(0))
                total_partie = total_partie + float(bareme[i].replace(',', '.'))
            triplet = triplet_par_nom(nom, liste_notes_etudiants_parties[partie])
            # print("Triplet 2", triplet)
            if triplet is not None:
                liste_notes_etudiants_parties[partie].remove(triplet)
                liste_notes_etudiants_parties[partie].append((total, total_tenté, nom))
            else:
                liste_notes_etudiants_parties[partie].append((total, total_tenté, nom))
            print(nom, partie, total)
            notes_globales_etudiants[nom][partie] = total
            notes_devoir_etudiants[nom] = notes_devoir_etudiants[nom] + notes_globales_etudiants[nom][partie]*dict_parties[partie][4]
            print(nom, partie, total, notes_devoir_etudiants[nom])
        except:
            print("On passe dans le except")
            continuer = False

    # Et maintenant on peut remplacer les listes de notes par leur
    # moyenne dans le dictionnaire dict_notes On ne le fait pas pour
    # les questions qui n'ont pas été traitées (forcément...), et on
    # met None à la place
    for key in dict_notes_parties[partie].keys():
        if dict_notes_parties[partie][key] != []:
            dict_notes_parties[partie][key] = np.average(dict_notes_parties[partie][key])
        else:
            dict_notes_parties[partie][key] = 0
    # On trie la liste des notes des étudiant pour avoir le rang des étudiant
    liste_notes_etudiants_parties[partie].sort(reverse=True)

# Pour le DS5 aucune compétence. On doit donc pouvoir créer un fichier bidon A VOIR
# Lecture du fichier description des compétences
# On crée un itérateur sur le fichier csv des compétences. Il faut préciser que le séparateur est le point-virgule. Il faut normalement à l'ouverture du fichier préciser le newline (c'est dans la doc)
# fichier_description_competences = csv.reader(open('/home/wilk/enseignement/2018-2019/CCAO/CompétencesDS01.csv',"r",newline=''),delimiter=';')

# Créaction du dictionnaire de description des compétences. La clé d'insertion est le numéro de question. La valeur est la liste des compétences (pour le moment avec le descriptif complet sous forme de chaîne de caractères)
# dict_description_competences = dict()

# On itère à la main pour fabriquer ce dictionnaire de compétences
# continuer = True
# liste_competences = []

# while continuer:
#     try:
#         row = next(fichier_description_competences)
#         #print(row)
#         if row[0] == "%%COMPNQ": # On commence une nouvelle question
#             if not liste_competences == []: # S'il y a une question courante, on fait les transferts et initialisations
#                 dict_description_competences[question_courante] = liste_competences
#                 liste_competences = []
#             question_courante = row[1]
#         else: # C'est une description de compétence pour la question courante. On l'ajoute à la liste
#             liste_competences.append(row[1])
#     except:
#         dict_description_competences[question_courante] = liste_competences # Ne pas oublier le dernier transfert !
#         continuer = False

# dict_description_competences = dict() # MT Verrue car ici il n'y a pas de compétences pour le DS3

# Là il y a du boulot car les infos sont dans la base de données, plus dans un fichier xls...
# Remplissage des structures de données à partir du fichier de correction .xls. C'est manuel pour le moment mais ensuite ce sera informatisé
# classeur_competences = xlrd.open_workbook('/home/papa/Documents/17-18/DS/DS02/Compétences_DS02.xls')

# feuilles = classeur_competences.sheets()

# Attention ncols rend le nombre de colonnes de la totalité la feuille, i.e. le max des colonnes remplies !, pas celui de la ligne courante...

# dict_erreurs = dict() # Là aussi on stocke dans un dictionnaire avec comme clé le nom de l'étudiant un dictionnaire de questions par erreur pour utilisation ultérieure

# dict_competences_etudiant = dict() # On stocke enfin dans un dictionnaire avec comme clé le nom de l'étudiant un dictionnaire de compétence (couple (intitulé compétence, satisfaction de la compétence))

# On remplace le parcours par feuille du fichier excel par un parcours de la base de données avec des JOIN pour récupérer toutes les informations avec la requête SQL suivante : SELECT nom, prénom, ques_id, Notation.cat_id, Notation.err_id, label FROM Notation JOIN Elèves ON Notation.ele_id = Elèves.id JOIN Erreurs ON Notation.cat_id = Erreurs.cat_id AND Notation.err_id = Erreurs.err_id ORDER BY Elèves.id

# try:
#     conn = sqlite3.connect(dbPathName)
#     cursor = conn.cursor()
#     #print("Connexion ouverte sur ", dbPathName)
# except sqlite3.Error as e:
#     print ("An error occurred:", e.args[0])

# try:
#     #print("Lecture des erreurs", "SELECT cat_id, err_id, label FROM Erreurs WHERE cat_id = " + str(cat_id) + " ORDER BY err_id;")
#     cursor.execute("SELECT nom, prénom, ques_id, Notation.cat_id, Notation.err_id, label FROM Notation JOIN Elèves ON Notation.ele_id = Elèves.id JOIN Erreurs ON Notation.cat_id = Erreurs.cat_id AND Notation.err_id = Erreurs.err_id WHERE ds_id = 'DS1' ORDER BY Elèves.id;")
#     for enregistrement in cursor:
#         Nom = enregistrement[0] + " " + enregistrement[1]
#         #print(Nom)
#         if not Nom in dict_erreurs:
#             dict_questions_par_erreur = dict()
#             dict_erreurs[Nom] = dict_questions_par_erreur
#         else:
#             dict_questions_par_erreur = dict_erreurs[Nom]

#         Erreur = str(enregistrement[3]) + "." + str(enregistrement[4])
#         if not Erreur in dict_questions_par_erreur:
#             dict_questions_par_erreur[Erreur] = []
#         dict_questions_par_erreur[Erreur].append(enregistrement[2])

# except sqlite3.Error as e:
#     print ("An error occurred:", e.args[0])

# =========================== FIN de la nouvelle fonction

# On prépare un petit histogramme pour la route...
    liste_notes = []
    for (note, _, _) in liste_notes_etudiants_parties[partie]:
        if note > 0.01:
            liste_notes.append(note)
            note_max = int(max(liste_notes)) + 2

    histogramme_notes = plt.figure(figsize=[6, 2.5])
    histogramme_notes.add_axes([0.15, 0.25, 0.85, 0.7])
    histogramme_frequences = plt.hist(liste_notes, bins=list(range(0, note_max, 1)))
    plt.xlim([0, note_max])
    plt.xticks(list(range(0, note_max, 2)))
    plt.yticks(list(range(0, int(max(histogramme_frequences[0]))+1, 1)))
    plt.xlabel(r'notes', fontname='serif', fontsize=11)
    plt.ylabel('nombre de copies', fontname='serif', fontsize=11)
    histogramme_nom_partie = str('distrib_notes_' + partie + '.pdf')
    histogramme_notes.savefig(histogramme_nom_partie, transparent=True)
    # for ticklabel in plt.gca().get_xaxis().get_ticklabels():
    # ticklabel.set_fontsize(4)
    # print(plt.gca())
    xa = plt.gca().get_xaxis()
    # print(plt.gca().get_xaxis(),type(plt.gca().get_xaxis()))
    # print(plt.gca().xaxis,type(plt.gca().xaxis))
    # print(xa,type(xa))
    xa.set_tick_params()
    xa.set_tick_params(labelsize=4)

    # plt.show()
    # plt.close()

    # Enfin on génère les fichiers à inclure dans un .tex pour avoir
    # un joli résultat. Il faudra ensuite le compiler avec pdflatex
    # par exemple

    Prefixe = dict_parties[partie][1] + "-"

    # On récupère la liste des noms des étudiants
    liste_noms_partie = dict_notation_parties[partie].keys()
    for nom in liste_noms_partie:
        if nom not in liste_noms:
            liste_noms.append(nom)

    for nom in liste_noms_partie:
        base_nom_fichier_partie = Prefixe + nom.replace(' ', "")
        nom_fichier_partie = base_nom_fichier_partie + ".tex"
        # print("nom_fichier_partie", nom_fichier_partie)
        debut = RepertoireCommun + 'fiche_partie_debut.tex'
        fin = RepertoireCommun + 'fiche_partie_fin.tex'
        fichier_base = open(debut, "rt")
        data = fichier_base.read()
        data = data.replace("RemplacerPartie", partie)
        data = data.replace("RemplacerBaremePartie", dict_parties[partie][2]
                            )
        data = data.replace("RemplacerTotalBareme", str(total_partie)
                            )
        fichier_base.close()
        # debut = RepertoireCommun + 'fiche_bilan_DS_1.tex'
        # print("debut", debut)
        triplet = triplet_par_nom(nom, liste_notes_etudiants_parties[partie])
        fichier_bilan = open(nom_fichier_partie, 'tw')
        fichier_bilan.write(data)
        fichier_bilan.close()
        fichier_bilan = open(nom_fichier_partie, 'a')
        # On écrit les notes de l'étudiant aux questions auxquelles il a répondu
        # On boucle sur les questions
        for question in questions_devoir_parties[partie]:
            if question in dict_notation_parties[partie][nom]:
                dict_etudiant = dict_notation_parties[partie][nom]
                note = dict_etudiant[question][0]
                moyenne_question = str('{0:.2f}'.format(dict_notes_parties[partie][question]))
                if note is None:
                    note = "nt"
                fichier_bilan.write(question + " & " + note + " & " + dict_etudiant[question][1].replace('.', ',') + " & " + "{0:.0f}".format(round(100*dict_notes_parties[partie][question]/float(dict_etudiant[question][1]))) + "\\% \\\\ \n")
                # On écrit le bilan
                triplet = triplet_par_nom(nom, liste_notes_etudiants_parties[partie])
                # print("Triplet",triplet)
        # fichier_bilan.write("\\midrule Bilan" + " & " + "obtenus" + " & " + "tentés" + " & " + "efficacité" + "\\\\\n")
        if triplet[1] == 0:
            pourcentage_reussite = "nan"
        else:
            pourcentage_reussite = "{0:.0f}".format(round(100 * triplet[0] / triplet[1]), 0)
        sh.copyfileobj(open(fin, 'r'), fichier_bilan)
        fichier_bilan = open(nom_fichier_partie, 'tr')
        data = fichier_bilan.read()
        data = data.replace("RemplacerPoints", str(triplet[0])
                            )
        data = data.replace("RemplacerTentes", str(triplet[1])
                            )
        data = data.replace("RemplacerEfficacite", pourcentage_reussite)
        data = data.replace("RemplacerNomHistogrammePartie", histogramme_nom_partie)
        fichier_bilan.close()
        fichier_bilan = open(nom_fichier_partie, 'tw')
        fichier_bilan.write(data)
        fichier_bilan.close()
        # fichier_bilan.write("Total" + " & " + str(triplet[0]) + " & " + str(triplet[1]) + " & " + pourcentage_reussite + "\\%" + "\\\\ \\bottomrule\n")

        # suite2 = RepertoireCommun + 'fiche_bilan_DS_3.tex'
        # sh.copyfileobj(open(suite2, 'r'), fichier_bilan)

        # # On passe aux compétences évaluées dans le sujet     # VERRUE LE CODE EST ENLEVE POUR LE DS3 QUI EST SANS EVALUATION DE COMPETENCES
        # for triplet_satisfaction in dict_competences_etudiant[nom]:
        #     fichier_bilan.write(triplet_satisfaction[0] + " & " + triplet_satisfaction[1] + " & " + triplet_satisfaction[2] + "\\\\ \hline\n")

        # suite3 = RepertoireCommun + 'fiche_bilan_DS_4.tex'
        # sh.copyfileobj(open(suite3,'r'), fichier_bilan)

        # # On finit par le bilan des erreurs
        # erreurs = dict_erreurs[nom] # erreur est un dictionnaire
        # for erreur_label in erreurs.keys(): # erreur_label est une string identifiant une erreur
        #     liste_questions_erreur = erreurs[erreur_label]
        #     str_liste_questions_erreur = ""
        # for i in range(len(liste_questions_erreur)):
        #     if i > 0:
    #         str_liste_questions_erreur = str_liste_questions_erreur + " ; "
    #         str_liste_questions_erreur = str_liste_questions_erreur + liste_questions_erreur[i]
#         # print(str_liste_questions_erreur)
#         # print("387",dict_erreurs_labels[erreur_label])
#         # print("387", str(len(erreurs[erreur_label])))
#         # print("387", str_liste_questions_erreur )

# fichier_bilan.write(dict_erreurs_labels[erreur_label] + " & " + str(len(erreurs[erreur_label])) + " & " + str_liste_questions_erreur + "\\\\ \hline\n")

        # fin = RepertoireCommun + 'fiche_bilan_DS_5-wilk.tex'
        # sh.copyfileobj(open(fin, 'r'), fichier_bilan)

        # fichier_bilan.close()

        # Il ne reste plus qu'à compiler
        # on compile et on nettoye.

moyenne_generale = str("%.1f" % stat.mean(notes_devoir_etudiants.values()))
mediane_generale = str("%.1f" % stat.median(notes_devoir_etudiants.values()))
ecarttype_general = str("%.1f" % stat.pstdev(notes_devoir_etudiants.values()))

# Histogramme global
liste_notes_devoir = notes_devoir_etudiants.values()

note_max_devoir = int(max(liste_notes_devoir)) + 2
histogramme_notes = plt.figure(figsize=[6, 2.5])
histogramme_notes.add_axes([0.15, 0.25, 0.85, 0.7])
histogramme_frequences = plt.hist(liste_notes_devoir, bins=list(range(0, note_max_devoir, 1)))
plt.xlim([0, note_max_devoir])
plt.xticks(list(range(0, note_max_devoir, 2)))
plt.yticks(list(range(0, int(max(histogramme_frequences[0]))+1, 1)))
plt.xlabel(r'notes', fontname='serif', fontsize=11)
plt.ylabel('nombre de copies', fontname='serif', fontsize=11)
histogramme_nom_devoir_pdf = str('distrib_notes_devoir-' + Devoir + '.pdf')
histogramme_nom_devoir_png = str('distrib_notes_devoir-' + Devoir + '.png')
histogramme_notes.savefig(histogramme_nom_devoir_pdf, transparent=True)
histogramme_notes.savefig(histogramme_nom_devoir_png, transparent=True)
# for ticklabel in plt.gca().get_xaxis().get_ticklabels():
# ticklabel.set_fontsize(4)
# print(plt.gca())
xa = plt.gca().get_xaxis()
# print(plt.gca().get_xaxis(),type(plt.gca().get_xaxis()))
# print(plt.gca().xaxis,type(plt.gca().xaxis))
# print(xa,type(xa))
xa.set_tick_params()
xa.set_tick_params(labelsize=4)

# plt.show()
# plt.close()

for nom in liste_noms:
    note = str("%.1f" % round(notes_devoir_etudiants[nom], 1))
    base_fichier = Devoir + "-" + nom.replace(' ', "")
    nom_fichier_pdf = base_fichier + ".pdf"
    nom_fichier_TeX = base_fichier + ".tex"
    commande_TeX = commande_compilation + nom_fichier_TeX + " "
    nom_fichier_debut_bilan = RepertoireCommun + 'fiche_bilan_DS_debut.tex'
    nom_fichier_fin_bilan = RepertoireCommun + 'fiche_bilan_DS_fin.tex'
    fichier_debut = open(nom_fichier_debut_bilan, 'rt')
    # On rentre la note à la place de REMPLACER_NOTE dans les fichiers .tex
    data = fichier_debut.read()
    data = data.replace("RemplacerTitreDevoir", Devoir_Titre)
    data = data.replace("RemplacerNom", sub("_"," ",nom))
    data = data.replace("RemplacerNote", note)
    data = data.replace("RemplacerMoyenneDevoir", moyenne_generale)
    data = data.replace("RemplacerMedianeDevoir", mediane_generale)
    data = data.replace("RemplacerStdevDevoir", ecarttype_general)
    data = data.replace("RemplacerDistribDevoir", histogramme_nom_devoir_pdf)
    fichier_debut.close()
    print(nom_fichier_TeX)
    fichier_TeX = open(nom_fichier_TeX, 'tw')
    fichier_TeX.write(data)
    fichier_TeX.close()
    for partie in dict_parties:
        Prefixe = dict_parties[partie][1] + "-"
        base_nom_fichier_partie = Prefixe + nom.replace(' ', "")
        nom_fichier_partie_nom_pdf = base_nom_fichier_partie + ".pdf"
        nom_fichier_partie_nom_tex = base_nom_fichier_partie + ".tex"

        if os.path.isfile(nom_fichier_partie_nom_tex):
            fichier_partie_TeX = open(nom_fichier_partie_nom_tex, 'rt')
            data = fichier_partie_TeX.read()
            fichier_TeX = open(nom_fichier_TeX, 'ta')
            fichier_TeX.write(data)
            fichier_TeX.close()
            fichier_partie_TeX.close()
            os.system('rm ' + nom_fichier_partie_nom_tex)
            # fin = open(nom_fichier_partie_nom_tex, 'wt')
            # fin.write(data)
            # fin.close()
            # os.system(commande_compilation + nom_fichier_partie_nom_tex)  # + " > " + base_nom_fichier + ".std" + " >2 " + base_nom_fichier + ".std2" )
            # if os.path.isfile(nom_fichier_partie_nom_pdf):
            #     commande_pdf = commande_pdf + " " + nom_fichier_partie_nom_pdf + " - "
            # else:
            #     commande_pdf = commande_pdf + " " + blank_page + " - "
    fin = open(nom_fichier_fin_bilan, 'rt')
    data = fin.read()
    fichier_TeX = open(nom_fichier_TeX, 'ta')
    fichier_TeX.write(data)
    fin.close
    fichier_TeX.close()
    print("compilation par élève " + commande_TeX)
    os.system(commande_TeX)
    os.system('rm ' + base_fichier + ".aux")
    os.system('rm ' + base_fichier + ".log")
    os.system('rm ' + base_fichier + ".tex")
    
    # for partie in dict_parties:
    #     Prefixe = dict_parties[partie][1] + "-"
    #     nom_fichier_partie_nom_pdf = Prefixe + nom.replace(' ', "") + ".pdf"
    #     if os.path.isfile(nom_fichier_partie_nom_pdf):
    #         os.system('rm ' + nom_fichier_partie_nom_pdf)

nom_fichier_classe_pdf = Devoir + "-bilan.pdf"
# commande_finale = commande_pagination + " --nup 2x1 --landscape --twoside -o " + nom_fichier_classe_pdf + " "
liste_fichiers_pdf = ""
for nom in liste_noms:
    nom_fichier_bilan_nom_pdf = Devoir + "-" + nom.replace(' ', "") + ".pdf"
    if os.path.isfile(nom_fichier_bilan_nom_pdf):
        liste_fichiers_pdf = liste_fichiers_pdf + " " + nom_fichier_bilan_nom_pdf

commande_finale = commande_pagination + " --landscape -o " + nom_fichier_classe_pdf + " " + liste_fichiers_pdf
print("bilan pour la classe " + commande_finale)
os.system(commande_finale)

# Création d'un fichier csv pour intégration dans un tableur

with open(fichier_csv, 'w', newline='') as csvfile:
    notes_csv = csv.writer(csvfile, delimiter=';')
    notes_csv.writerow(['Noms'] + [partie for partie in noms_parties])
    for nom in liste_noms:
        row = [nom]
        for partie in noms_parties:
            if partie in notes_globales_etudiants[nom]:
                row += [str(notes_globales_etudiants[nom][partie]).replace('.', ',')]
            else:
                row += [""]
        notes_csv.writerow(row)

def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(str.lower(name), pattern):
                result.append(os.path.join(root, name))
    return result


with open(patronymes_fichier, 'r', newline='', encoding='utf-8-sig') as patronymes:
    liste_patronymes = csv.reader(patronymes)
    for row in liste_patronymes:
        
        pattern_bilan = "*"+str.lower(sub("[ \t]","_",row[0]))+"*.pdf"
        nom_bilan = find(pattern_bilan, Repertoire_bilans)
        pattern_correction = "*"+str.lower(row[0])+"*-corr.pdf"
        nom_correction = find(pattern_correction, Repertoire_corrections)
        
        if nom_bilan and nom_correction:
            if os.path.isfile(nom_bilan[0]) and os.path.isfile(nom_correction[0]):
                print("fichiers pdf présents pour " + nom_bilan[0])
                nom_final = str.replace(nom_correction[0], '-corr.pdf', '-final.pdf')
                commande_correction = "pdftk " + nom_bilan[0] + " " + nom_correction[0] + " cat output " + nom_final + " "
                print("nom final",nom_final)
                # print(commande_correction)
                os.system(commande_correction)
                os.system('rm ' + nom_correction[0])
        else:
            print(f'problème avec {row[0]}')
            print(pattern_bilan)
            print("nom bilan",nom_bilan[0])
            print(pattern_correction)
            print("nom correction",nom_correction[0])

for nom in liste_noms:
    nom_fichier_bilan_nom_pdf = Devoir + "-" + nom.replace(' ', "") + ".pdf"
    if os.path.isfile(nom_fichier_bilan_nom_pdf):
        os.system('rm ' + nom_fichier_bilan_nom_pdf)

print("moyenne générale = "+moyenne_generale)
print("médiane générale = "+mediane_generale)
print("stdev générale = "+ecarttype_general)
