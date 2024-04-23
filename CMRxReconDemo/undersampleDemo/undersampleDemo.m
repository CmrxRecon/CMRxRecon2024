%% This is a demo explaining how to use mask for undersampling
% @ keevinzha

clear;clc
%% add path
addpath('./utils')

%% load data and undersample
% load kspace
load('cine_sax.mat') 
% load undersampling mask
load('cine_sax_mask_Uniform8.mat')

kspace_sub = kspace_full(:,:,1,1,1);% kspace data of first coil, first slice and first frame
% show kspace data and mask
figure
subplot(1, 3 ,1)
imshow(abs(imadjust(kspace_sub, [], [], 0.5)), []) 
title('kspace')

subplot(1 ,3, 2)
imshow(mask, [])
title('mask')

subplot(1, 3, 3)
imshow(abs(ifft2c(kspace_sub)), [])
title('image')


% undersampling
undersampled_kspace = kspace_sub .* mask;
figure
subplot(1, 2, 1)
imshow(abs(imadjust(undersampled_kspace, [], [], 0.5)), [])
title('undersampled kspace')

subplot(1, 2, 2)
imshow(abs(ifft2c(undersampled_kspace)), [])
title('undersampled image')
