
# This script shows some functions for the multi-coil recon.
# if you have any questions, please contact me.
# email: fanwen.wang@imperial.ac.uk
# github: Mobbyjj

import h5py
import numpy as np
from matplotlib import pyplot as plt
import hdf5storage

import fastmri
from fastmri.data import transforms as T
from run4ranking import run4Ranking

# load the file
def readfile2numpy(file_name):
    '''
    read the data from mat and convert to numpy array
    '''
    hf = h5py.File(file_name)
    keys = list(hf.keys())
    assert len(keys) == 1, f"Expected only one key in file, got {len(keys)} instead"
    new_value = hf[keys[0]][()]
    data = new_value["real"] + 1j*new_value["imag"]
    return data


def show_coils(data, slice_nums, cmap=None, vmax = 0.0005):
    '''
    plot the figures along the first dims.
    '''
    fig = plt.figure()
    for i, num in enumerate(slice_nums):
        plt.subplot(1, len(slice_nums), i + 1)
        plt.imshow(data[num], cmap=cmap,vmax=vmax)

def savenumpy2mat(data, np_var, filepath):
    ''' 
    np_var: str, the name of the variable in the mat file.
    data: numpy, array to save.
    filepath: str, the path to save the mat file.
    # attention! hdftstorage save the array in a mat file that both h5py and scipy.io.loadmat can read.
    # but it will transpose the data array.
    # If you want to save the file in the same way as the original mat file, please first apply np.transpose(data) 
    '''
    savedict= {}
    savedict[np_var] = data
    hdf5storage.savemat(filepath, savedict)
    
# here show the filepath of the multi-coil data
file_name = '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Cine/TrainingSet/P001/cine_sax.mat'

# read files from mat to numpy
fullmulti = readfile2numpy(file_name)

# choose one slice
slice_kspace = fullmulti[0,5] 

# Convert from numpy array to pytorch tensor
slice_kspace2 = T.to_tensor(slice_kspace)       
# Apply Inverse Fourier Transform to get the complex image       
slice_image = fastmri.ifft2c(slice_kspace2)     
# Compute absolute value to get a real image      
slice_image_abs = fastmri.complex_abs(slice_image)   


show_coils(slice_image_abs, [0, 3, 6], cmap='gray', vmax = 0.0005)
# combine the coil images to a coil-combined ones.
slice_image_rss = fastmri.rss(slice_image_abs, dim=0)

# plot the final images.
plt.imshow(np.abs(slice_image_rss.numpy()), cmap='gray', vmax = 0.0015)
# save the image to mat file.
savenumpy2mat(slice_image_rss, 'slice_image_rss', 'slice_image_rss.mat')


# run4ranking
# 
file = 'cine_sax.mat'  # or just the modality cine_sax
slice_full_kspace = T.to_tensor(fullmulti)              # Convert from numpy array to pytorch tensor
slice_full_image = fastmri.ifft2c(slice_full_kspace) 

# attention: the data in matlab is tranpose to the one in python.
all_img = (slice_full_image.T).numpy() # nx, ny, nz, nt

img4ranking = run4Ranking(all_img, file)

# save the file into the mat with the same variable name.