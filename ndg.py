# -*- coding: utf-8 -*-
"""
Created on Mon Mar 29 22:23:06 2021

@author: Thomas
"""
#importer le package Image de la bibliothèque Pillow
from PIL import Image
from numpy import zeros
import os
from os import listdir

# définition des path
dataset = "easy"
path = os.path.dirname(os.path.realpath(__file__))
path_images = path + "\\"+dataset


# suppression du fichier txt si déjà existant
if os.path.isfile('ndg.txt'):
    os.remove('ndg.txt')


# création et ouverture du fichier txt de stockage des classes
ListeAttribut = open("ndg.txt","a")

# initialisation du txt
for i in range(256):
    ListeAttribut.write("A")
    ListeAttribut.write(str(i))
    ListeAttribut.write(" ")

ListeAttribut.write("\n")

files = [f for f in listdir(path_images)]
cpt=0

# parcourt de la liste des fichiers du dossier easy
for f in files:
    print(cpt)
    imageLue = Image.open(path_images + "\\" + str(cpt)+".png")
    #Convertir l'image au niveau de gris
    imageGris = imageLue.convert("L")
    ndg = zeros(256,int)
    for i in imageGris.getdata():
        ndg[i]+=1
    for j in ndg:
        ListeAttribut.write(str(j))
        ListeAttribut.write(" ")
    ListeAttribut.write("\n")
    cpt=cpt+1
    

# fermeture du fichier
ListeAttribut.close()
    
        
        