from tensorflow.keras.preprocessing import image

import numpy as np
import os, sys

fichier = open("test.txt", "a")
fichier.write("0 1 2")
fichier.write("\n")
fichier.write("3 4 5")
fichier.close()

img_path = 'dataset/2357 brick corner 1x2x2 000L.png'
img = image.load_img(img_path, target_size=(224, 224))
img_data = image.img_to_array(img)