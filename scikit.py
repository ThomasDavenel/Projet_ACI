import matplotlib.pyplot as plt

from skimage.io import imread, imshow
from skimage.transform import resize
from skimage.feature import hog
from skimage import data, exposure
from tensorflow.keras.preprocessing import image    
#importer le package Image de la bibliothèque Pillow
from PIL import Image
from numpy import zeros
import os
from os import listdir

# définition des path
dataset = "easy"
path = os.path.dirname(os.path.realpath(__file__))
path_images = path + "\\"+dataset

#hyper-param
nbOrientation = 8
pixPerCell = 40

# suppression du fichier txt si déjà existant
if os.path.isfile('hog.txt'):
    os.remove('hog.txt')


# création et ouverture du fichier txt de stockage des classes
ListeAttribut = open("hog.txt","a")

# initialisation du txt
for i in range(int((400/pixPerCell)*(400/pixPerCell)*nbOrientation)):
    ListeAttribut.write("A")
    ListeAttribut.write(str(i))
    ListeAttribut.write(" ")
    i=i+1

ListeAttribut.write("\n")

files = [f for f in listdir(path_images)]
cpt=0

# parcourt de la liste des fichiers du dossier easy
for f in files:
    print(cpt)
    img = imread(path_images + "\\" + str(cpt)+".png")
    resized_img = resize(img, (400,400)) 
    fd = hog(resized_img, orientations=nbOrientation, pixels_per_cell=(pixPerCell, pixPerCell),cells_per_block=(1, 1))
    for v in fd :
        ListeAttribut.write(str(v))
        ListeAttribut.write(" ")
    ListeAttribut.write("\n")
    cpt=cpt+1
    

# fermeture du fichier
ListeAttribut.close()