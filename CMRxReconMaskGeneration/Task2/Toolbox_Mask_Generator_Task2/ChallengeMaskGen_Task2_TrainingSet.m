%% The matlab script for mask generation for TrainingSet in Task 2 (CMRxRecon MICCAI2024)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% April 9, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., Deep Separable Spatiotemporal Learning for Fast Dynamic Cardiac MRI, arXiv:2402.15939, 2024.

function ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,setName)

%% 5D kspace [nx, ny, sc, sz, t]
load(data_path);  % Loading raw kspace data
nx = size(kspace_full, 1);
ny = size(kspace_full, 2);
nt = size(kspace_full, 5);
ncalib = 16;

%% 2D+t Mask generation [nx, ny, nt]
mask = ktMaskGenerator_Task2(nx, ny, nt, ncalib, R, pattern);

%% Save mask and undersampled kspace
if strcmp(setName,'TrainingSet')
    savepath1 = strcat(mainSavePath,file_nameID);
    mkdir(savepath1);
    save(fullfile(savepath1,[dataName,'_mask_',pattern,num2str(R),'.mat']),'mask','-v7.3');
end

%% Mask display
% figure(R),imshow(mask,[]);
% figure(R+1),imshow(squeeze(mask(60,:,:)),[]);
end

