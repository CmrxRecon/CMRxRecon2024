%% Generate the kt sampling index from Pseudo-Radial distribution with autocalibration signals (ACS)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

function mask = ktRadialSampling(nx,ny,nt,ncalib,R,angle4next,cropcorner)
rate = 1/R;
beams = floor(rate*180); % beams is the number of angles

if cropcorner
    a = max(nx,ny);
else
    a = ceil(sqrt(2) * max(nx,ny));
end
aux = zeros(a,a);
aux(round(a/2),:) = 1;
angle = 180/beams;

ktus = zeros(nx,ny,nt);
for i = 1:nt
    angles = (0+angle4next*(i-1):angle:180+angle4next*(i-1));
    image = zeros(nx,ny);
    for a = 1:length(angles)
        ang = angles(a);
        temp = crop(imrotate(aux,ang,'crop'), nx, ny);
        image = image + temp;
    end
    ktus(:,:,i) = image;
end

acs = zpad(ones(ncalib,ncalib,nt),[nx,ny,nt]);
mask_temp = ktus + acs;
mask = double(mask_temp > 0);
end