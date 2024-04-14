%% The matlab script for mask generation in Task 2 (CMRxRecon MICCAI2024)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., Deep Separable Spatiotemporal Learning for Fast Dynamic Cardiac MRI, arXiv:2402.15939, 2024.

clc
clear all
close all
warning off
%% Add path
currentFolder = pwd;
addpath(genpath(currentFolder));
%% Mask generation
for R = [4, 8, 12, 16, 20, 24]
    % 5D kspace [kx, ky, sc, sz, t]
    kspace = ones(400, 246, 10, 10, 12);
    nx = size(kspace, 1);
    ny = size(kspace, 2);
    nt = size(kspace, 5);
    ncalib = 16;
    pattern = 'ktRadial';  % ktUniform, ktGaussian, ktRadial
    
    % Mask generation [kx, ky, t]
    mask = ktMaskGenerator_Task2(nx, ny, nt, ncalib, R, pattern);
    save(fullfile([pattern,'_R',num2str(R),'.mat']),'mask','-v7.3');
    
    % Mask display
    figure(R),imshow(mask(:,:,1),[]);
    figure(R+1),imshow(squeeze(mask(60,:,:)),[]);
end
