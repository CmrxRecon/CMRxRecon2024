# This script works the same as the run4Ranking.m in CMRxReconDemo dir
# we crop the images to 1/6 of the images for most modalities, but keep the temporal dimension of mapping the same. 
# This is written by Haoyu Zhang and Fanwen Wang.

# if you have any questions, please contact: fanwen.wang@imperial.ac.uk
# github: Mobbyjj

import numpy as np
import math
import h5py
import torch
import os
import pandas as pd

def crop(image, crop_size):
    sx, sy, sz, t = image.shape
    cx, cy, cz, ct = crop_size
    start_x = math.floor(sx / 2)
    start_y = math.floor(sy / 2)
    start_z = math.floor(sz / 2)
    start_t = math.floor(t / 2)
    return image[start_x+math.ceil(-cx/2):start_x + math.ceil(cx/2), 
                 start_y+math.ceil(-cy/2):start_y + math.ceil(cy/2), 
                 start_z+math.ceil(-cz/2):start_z + math.ceil(cz/2), 
                 start_t+math.ceil(-ct/2):start_t + math.ceil(ct/2)]

def crop_map(image, crop_size):
    # attention: when it comes to the mapping, index changes (weired but checked.)
    sx, sy, sz, t = image.shape
    cx, cy, cz = crop_size
    start_x = math.floor(sx / 2)
    start_y = math.floor(sy / 2)
    if sz %2 == 0:
        start_z = math.floor(sz / 2) - 1
    else:
        start_z = math.floor(sz / 2)
    
    return image[start_x+math.ceil(-cx/2):start_x + math.ceil(cx/2), 
                 start_y+math.ceil(-cy/2):start_y + math.ceil(cy/2), 
                 start_z+math.ceil(-cz/2):start_z + math.ceil(cz/2)]

def run4Ranking(img, filetype):
    # check whether this is 'blackblood'(should be four dim)
    if 'blackblood' in filetype:
        sx, sy, sz = img.shape
        st = 1
    else:
        sx, sy, sz, st = img.shape

    img = np.reshape(img, (sx, sy, sz, st))

    if 'map' in filetype:
        # nocropping for mapping data]
        reconImg = img[:,:,:,:]
        crop_size = (round(sx / 3), round(sy / 2 + 0.00001), 2)
        img4ranking = crop_map(np.abs(reconImg), crop_size).astype(np.float32)
    else:
        if sz < 3 and st > 3:
            # take the first 3 frames
            reconImg = img[...,:3]
            img4ranking = crop(np.abs(reconImg), (round(sx / 3), round(sy / 2 + 0.00001), sz, 3)).astype(np.float32)
        else:
            reconImg = img[:, :, round(sz / 2+ 0.00001) - 2:round(sz / 2+ 0.00001), :3]
            img4ranking = crop(np.abs(reconImg), (round(sx / 3), round(sy / 2 + 0.00001), 2, 3)).astype(np.float32)
    # return blackblood to 3 dim
    if 'blackblood' in filetype:
        img4ranking = np.squeeze(img4ranking, axis=3)
    return img4ranking