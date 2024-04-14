%% The matlab script for mask generation in Task 1 (CMRxRecon MICCAI2024)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., One-dimensional Deep Low-rank and Sparse Network for Accelerated MRI, IEEE Transactions on Medical Imaging, 42:79-90, 2023.

clc
clear all
close all
warning off
%% Add path
currentFolder = pwd;
addpath(genpath(currentFolder));
%% Mask generation
for R = [4, 8, 10]
    % 5D kspace [kx, ky, sc, sz, t] or 4D kspace [kx, ky, sc, sz]
    kspace = ones(400, 200, 10, 10, 12);
    nx = size(kspace, 1);
    ny = size(kspace, 2);
    ncalib = 16;
    pattern = 'Uniform';
    
    % Mask generation [kx, ky]
    mask = MaskGenerator_Task1(nx, ny, ncalib, R, pattern);
    save(fullfile([pattern,'_R',num2str(R),'.mat']),'mask','-v7.3');
    
    % Mask display
    figure(R),imshow(mask,[]);
end
