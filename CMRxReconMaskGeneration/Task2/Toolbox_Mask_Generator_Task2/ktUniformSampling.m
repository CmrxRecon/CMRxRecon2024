%% Generate the kt sampling index from Uniform distribution with autocalibration signals (ACS)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% April 9, 2024

function mask = ktUniformSampling(nx,ny,nt,ncalib,R)
ptmp = zeros(ny,1); ptmp(round(1:R:ny))=1;
ttmp = zeros(nt,1); ttmp(round(1:R:nt))=1;
Top = toeplitz(ptmp,ttmp);
ind = find(Top);
ph = rem(ind-1, ny)-(floor(ny/2));
ti = floor((ind-1)/ny)-(floor(nt)/2);

[ph, ti] = ktdup(ph,ti,ny,nt);
samp = zeros(ny, nt);
ind  = round(ny*(ti + floor(nt/2)) + (ph + floor(ny/2)+1));
ind(ind<=0) = 1;  % Changed
samp(ind) = 1;

acs = zpad(ones(nx,ncalib,nt),[nx,ny,nt]);
ktus = permute(repmat(samp, [1,1,nx]), [3,1,2]);
mask_temp = ktus + acs;
mask = double(mask_temp > 0);
end