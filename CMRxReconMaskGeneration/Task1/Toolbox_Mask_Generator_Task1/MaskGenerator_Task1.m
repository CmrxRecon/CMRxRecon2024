%% The generator for undersampling mask in Task 1
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., One-dimensional Deep Low-rank and Sparse Network for Accelerated MRI, IEEE Transactions on Medical Imaging, 42:79-90, 2023.

function mask = MaskGenerator_Task1(nx,ny,ncalib,R,pattern)

switch pattern
    case 'Uniform'
        mask = UniformSampling(nx, ny, ncalib, R);
        % realAF = numel(mask)/sum(mask(:));
        % disp(realAF);
    otherwise
        disp('No selected undersampling pattern. Please choose the proper one.')
end