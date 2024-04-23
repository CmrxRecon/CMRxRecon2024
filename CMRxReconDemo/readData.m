clear;clc;
%%
BB_mask = '/Users/kevinguo/DataSets/ChallengeData/MultiCoil/Tagging/TrainingSet/Mask_Task2/P002/tagging_mask_ktRadial24.mat';
load(BB_mask);



%% cal calib
columnsAllOnes = all(mask == 1, 1);


midPoint = ceil(length(columnsAllOnes) / 2);


left = midPoint;
right = midPoint;


while left > 1 && columnsAllOnes(left-1)
    left = left - 1;
end

while right < length(columnsAllOnes) && columnsAllOnes(right+1)
    right = right + 1;
end


if columnsAllOnes(midPoint)
    n = right - left + 1;
else
    n = 0;
end
if n > 1
    disp(n)
else
    
end


for i = 1:12
    imshow(squeeze(mask(:,:,i)), []);
end
%%

%  check if it is special data
isBlackBlood = 0;
if length(size(kspace_full)) == 4
    [sx,sy,scc,sz] = size(kspace_full);
    t = 1;
    isBlackBlood = 1;
else
    [sx,sy,scc,sz,t] = size(kspace_full);
end

%  clipping layers and timeframes

sliceToUse = (round(sz/2));
img = ifft2c(kspace_full);
imgPhase = angle(img);
imgPhase = squeeze(mean(imgPhase, 3));
sosImg_all = squeeze(sos(img, 3));

for i=-5:6
figure
sosImg = imadjust(sosImg_all(:,:,sliceToUse+1, round(t/2)+i), [], [], 0.5);
imshow(abs(squeeze(sosImg)), [])
end
% 
% for i = 1:10
% figure
% imshow(squeeze(imgPhase(:,:,sliceToUse+1,round(t/2))));
% end


%%
figure
imshow(img4ranking(:,:,1,1), []);