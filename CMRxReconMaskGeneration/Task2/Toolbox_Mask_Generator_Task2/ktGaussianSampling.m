%% Generate the kt sampling index from Gaussian distribution with autocalibration signals (ACS)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% March 31, 2024

function mask = ktGaussianSampling(nx,ny,nt,ncalib,R,alpha,seed)
p1=(-floor(ny/2):ceil(ny/2)-1)';
t1=[];
ind=0;
tr = round(ny/R); % Number of readout lines per frame (temporal resolution)
ti = zeros(tr*nt,1);
ph = zeros(tr*nt,1);
alph = alpha;  % default: 0.28, 0<alpha<1 controls sampling density; 0: uniform density, 1: maximally non-uniform density
               % the larger the better (stronger incoherence)
sig = ny/5;  % Std of the Gaussian envelope for sampling density
prob = (0.1 + alph/(1-alph+1e-10)*exp(-(p1).^2./(1*sig.^2)));
sd = seed;  % default: 10, randi([1 1000]), seed to generate random numbers; a fixed seed for reproduction
rng(sd);
tmpSd = round(1e6*rand(nt,1)); % Seeds for random numbers
for i = -floor(nt/2):ceil(nt/2)-1
    a = find(t1==i);
    n_tmp = tr-numel(a);
    prob_tmp = prob;
    prob_tmp(a) = 0;
    p_tmp = randp(prob_tmp, tmpSd(i+floor(nt/2)+1), n_tmp, 1) - floor(ny/2)-1;
    ti(ind+1:ind+n_tmp) = i;
    ph(ind+1:ind+n_tmp) = p_tmp;
    ind = ind+n_tmp;
end

[ph, ti] = ktdup(ph,ti,ny,nt);
samp = zeros(ny, nt);
ind  = round(ny*(ti + floor(nt/2)) + (ph + floor(ny/2)+1));
samp(ind) = 1;

acs = zpad(ones(nx,ncalib,nt),[nx,ny,nt]);
ktus = permute(repmat(samp, [1,1,nx]), [3,1,2]);
mask_temp = ktus + acs;
mask = double(mask_temp > 0);
end