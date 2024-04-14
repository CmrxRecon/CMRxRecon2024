%% The matlab script for mask generation for TrainingSet in Task 1 (CMRxRecon MICCAI2024)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% April 9, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., One-dimensional Deep Low-rank and Sparse Network for Accelerated MRI, IEEE Transactions on Medical Imaging, 42:79-90, 2023.

function ChallengeMaskGen_Task1_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,setName)

%% 5D kspace [nx, ny, sc, sz, t] or 4D kspace [nx, ny, sc, sz]
load(data_path);  % Loading raw kspace data
nx = size(kspace_full, 1);
ny = size(kspace_full, 2);
ncalib = 16;

%% 2D Mask generation [nx, ny]
mask = MaskGenerator_Task1(nx, ny, ncalib, R, pattern);

%% Save mask and undersampled kspace
if strcmp(setName,'TrainingSet')
    savepath1 = strcat(mainSavePath,file_nameID);
    mkdir(savepath1);
    save(fullfile(savepath1,[dataName,'_mask_',pattern,num2str(R),'.mat']),'mask','-v7.3');
end

%% Mask display
% figure(R),imshow(mask,[]);

end

