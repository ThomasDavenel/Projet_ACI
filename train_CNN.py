# -*- coding: utf-8 -*-
"""
Created on Mon Mar 29 22:06:09 2021

@author: Thomas
"""

# coding=utf-8

#########################################
### Extract features from pretrained cnn
#########################################
from tensorflow.keras.applications.vgg16 import VGG16
from tensorflow.keras.applications.vgg16 import preprocess_input
from tensorflow.keras.preprocessing import image

from timeit import default_timer as timer
import os, sys
import numpy as np


base_dir = "C:/Users/Thomas/Desktop/ESIR_2/Semestre8/ACI/projet/easyPropre/"
output_dir="./"
train_dir = os.path.join(base_dir, 'train')
valid_dir = os.path.join(base_dir, 'valid')
test_dir = os.path.join(base_dir, 'test')

train_C1_dir = os.path.join(train_dir, 'C1')
train_C2_dir = os.path.join(train_dir, 'C2')
train_C3_dir = os.path.join(train_dir, 'C3')
train_C4_dir = os.path.join(train_dir, 'C4')
train_C5_dir = os.path.join(train_dir, 'C5')

valid_C1_dir = os.path.join(valid_dir, 'C1')
valid_C2_dir = os.path.join(valid_dir, 'C2')
valid_C3_dir = os.path.join(valid_dir, 'C3')
valid_C4_dir = os.path.join(valid_dir, 'C4')
valid_C5_dir = os.path.join(valid_dir, 'C5')

test_C1_dir = os.path.join(test_dir, 'C1')
test_C2_dir = os.path.join(test_dir, 'C2')
test_C3_dir = os.path.join(test_dir, 'C3')
test_C4_dir = os.path.join(test_dir, 'C4')
test_C5_dir = os.path.join(test_dir, 'C5')


local_weights_file = 'C:/Users/Thomas/Desktop/ESIR_2/Semestre8/ACI/TP_ACI/Python/vgg16_weights_tf_dim_ordering_tf_kernels_notop.h5'
model_vgg16 = VGG16(include_top=False, weights=local_weights_file, pooling='max')


# QUESTION : (a) Quelle est la dimension des descripteurs extraits ici ? 
# (b) A quelle couche du reseau correspondent-ils ?
# (c) Decrivez sous quelle forme sont retournees les donnees d'apprentissage (attributs + classe) ?


def extract_features(class_input_dir, class_id):

    class_vgg16_feature_list = []
    im_nb=0

    for fname in os.listdir(class_input_dir):
        print (str(im_nb+1) + " Compute descriptors for " + fname)
        img = image.load_img(os.path.join(class_input_dir, fname), target_size=(400, 400))
        img_data = image.img_to_array(img)
        img_data = np.expand_dims(img_data, axis=0)
        img_data = preprocess_input(img_data)

        vgg16_feature = model_vgg16.predict(img_data)
        vgg16_feature_np = np.array(vgg16_feature)
        class_vgg16_feature_list.append(vgg16_feature_np.flatten())

        im_nb=im_nb+1


    class_vgg16_feature_list_np = np.array(class_vgg16_feature_list)
    y_train=np.full(im_nb,class_id)

    return class_vgg16_feature_list_np, y_train



if __name__ == "__main__":
    model_vgg16.summary()
    
    start1 = timer()
    
    c1_vgg16_feature_list_np, c1_y_train = extract_features(train_C1_dir,0)
    c2_vgg16_feature_list_np, c2_y_train = extract_features(train_C2_dir,1)
    c3_vgg16_feature_list_np, c3_y_train = extract_features(train_C3_dir,2)
    c4_vgg16_feature_list_np, c4_y_train = extract_features(train_C4_dir,3)
    c5_vgg16_feature_list_np, c5_y_train = extract_features(train_C5_dir,4)

    vgg16_feature_list_np=np.concatenate((c1_vgg16_feature_list_np, c2_vgg16_feature_list_np, c3_vgg16_feature_list_np, c4_vgg16_feature_list_np,c5_vgg16_feature_list_np))
    y_train=np.concatenate((c1_y_train,c2_y_train,c3_y_train,c4_y_train,c5_y_train))

    np.save(output_dir + "vgg16_train_descriptors.npy", vgg16_feature_list_np)
    np.save(output_dir + "vgg16_train_target.npy", y_train)
    
    
    
    c1_vgg16_feature_list_np, c1_y_test = extract_features(test_C1_dir,0)
    c2_vgg16_feature_list_np, c2_y_test = extract_features(test_C2_dir,1)
    c3_vgg16_feature_list_np, c3_y_test = extract_features(test_C3_dir,2)
    c4_vgg16_feature_list_np, c4_y_test = extract_features(test_C4_dir,3)
    c5_vgg16_feature_list_np, c5_y_test = extract_features(test_C5_dir,4)

    vgg16_feature_list_np=np.concatenate((c1_vgg16_feature_list_np, c2_vgg16_feature_list_np, c3_vgg16_feature_list_np, c4_vgg16_feature_list_np, c5_vgg16_feature_list_np))
    y_test=np.concatenate((c1_y_test,c2_y_test,c3_y_test,c4_y_test,c5_y_test))

    np.save(output_dir + "vgg16_test_descriptors.npy", vgg16_feature_list_np)
    np.save(output_dir + "vgg16_test_target.npy", y_test)
    
    end1 = timer()

    print("Train extraction Time: " + str(end1 - start1))
 
    sys.exit(0)

