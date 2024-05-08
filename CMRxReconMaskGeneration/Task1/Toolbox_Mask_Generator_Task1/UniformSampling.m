%% Generate the sampling index from Uniform distribution with autocalibration signals (ACS)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% June 24, 2021

function mask = UniformSampling(nx,ny,ncalib,R)
mask = zpad(ones(nx,ncalib),[nx,ny]);
mask(:, 1:R:end) = 1;
end
