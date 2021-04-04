import os
from os import listdir
import zipfile

# définition des path
dataset = "easy"
path = os.path.dirname(os.path.realpath(__file__))
path_images = path + "\\"+dataset

# suppression du dossier easy si il existe
if os.path.exists(path_images):
    files1 = [f for f in listdir(path_images)]
    for f in files1:
        os.remove(path_images+"\\"+f)

# extraction de l'archive
with zipfile.ZipFile(path+"\\"+dataset+".zip", 'r') as zip_ref:
    zip_ref.extractall(path)

# suppression du fichier txt si déjà existant
if os.path.isfile('ListeClasses.txt'):
    os.remove('ListeClasses.txt')


# création et ouverture du fichier txt de stockage des classes
ListeClasses = open("ListeClasses.txt","a")

# initialisation du txt
ListeClasses.write("Nom_Image Classe\n")
files = [f for f in listdir(path_images)]
i=0

# parcourt de la liste des fichiers du dossier easy
for f in files:
    # on récupère le nom de la classe dans le nom du fichier
    words = f.split(" ")
    words.pop(len(words)-1)
    classname = ""
    for wrd in words:
        classname = classname+wrd+"_"
    
    # on renomme le fichier courant
    os.rename(path_images + "\\" + f,path_images + "\\" + str(i)+".png")

    # on écrit dans le txt le nouveau nom du fichier courant et sa classe
    ListeClasses.write(str(i)+".png "+classname+"\n")
    i=i+1

# fermeture du fichier
ListeClasses.close()