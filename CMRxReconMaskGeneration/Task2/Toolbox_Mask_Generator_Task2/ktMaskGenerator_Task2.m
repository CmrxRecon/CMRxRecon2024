%% The generator for undersampling mask in Task 2
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., Deep Separable Spatiotemporal Learning for Fast Dynamic Cardiac MRI, arXiv:2402.15939, 2024.

function mask = ktMaskGenerator_Task2(nx,ny,nt,ncalib,R,pattern)

switch pattern
    case 'ktUniform'
        mask = ktUniformSampling(nx, ny, nt, ncalib, R);
        % realAF = numel(mask)/sum(mask(:));
        % disp(realAF);
    case 'ktGaussian'
        alpha = 0.2;  % default: 0.28, 0<alpha<1 controls sampling density; 0: uniform density, 1: maximally non-uniform density
                      % the larger the better (stronger incoherence)
        seed = randi([1 1000]);  % default: 10, randi([1 1000]), seed to generate random numbers; a fixed seed for reproduction
        mask = ktGaussianSampling(nx, ny, nt, ncalib, R, alpha, seed);
        % realAF = numel(mask)/sum(mask(:));
        % disp(realAF);
    case 'ktRadial'
        angle4next = 137.5;  % default: 0, rotate a golden-angle for generating different mask in different time frame
        cropcorner = true;  % true or false
        R = R * 0.6;
        mask = ktRadialSampling(nx, ny, nt, ncalib, R, angle4next, cropcorner);
        % realAF = numel(mask)/sum(mask(:));
        % disp(realAF);
    otherwise
        disp('No selected undersampling pattern. Please choose the proper one.')
end