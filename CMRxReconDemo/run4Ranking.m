% to reduce the computing burden and space, we only evaluate the central 2 slices
% For cine: use the first 3 time frames for ranking!
% For mapping: we need all weighting for ranking!
% crop the middle 1/6 of the original image for ranking

%% this function helps you to convert your data for ranking
% img: complex images reconstructed with the dimensions (sx,sy,sz,t/w) in
% original size
% -sx: matrix size in x-axis
% -sy: matrix size in y-axis
% -sz: slice number (short axis view); slice group (long axis view)
% -t/w: time frame/weighting

% filetype: mat file name

% img4ranking: "single" format images with the dimensions (sx/3,sy/2,2,3)
% -sx/3: 1/3 of the matrix size in x-axis
% -sy/2: half of the matrix size in y-axis
% img4ranking is the data we used for ranking!!!

function img4ranking = run4Ranking(img,filetype)

%  check if it is special data
isBlackBlood = 0;
if contains(filetype, 'blackblood')
    [sx,sy,scc,sz] = size(img);
    t = 1;
    isBlackBlood = 1;
else
    [sx,sy,scc,sz,t] = size(img);
end

%  revise by Fanwen, this doesn't match the T1 
isMapping = contains(filetype, 'T1map') || contains(filetype, 'T2map');

%  clipping layers and timeframes
if sz < 3
    sliceToUse = 1:sz;
else
    sliceToUse = (round(sz/2) - 1):(round(sz/2));
end

if isBlackBlood
    timeFrameToUse = 1;
elseif isMapping
    timeFrameToUse = 1:t;
else
    timeFrameToUse = 1:3;
end

sosImg = squeeze(sos(img, 3));

% in case slice dimension is 1, keep the shape of data
if sz == 1
    sosImg = reshape(sosImg, [size(sosImg, 1), size(sosImg, 2), 1, size(sosImg, 3)]);
end


if isBlackBlood
    selectedImg = sosImg(:, :, sliceToUse);
    img4ranking = single(crop(abs(selectedImg), [round(sx/3), round(sy/2), length(sliceToUse)]));
else
    selectedImg = sosImg(:, :, sliceToUse, timeFrameToUse);
    img4ranking = single(crop(abs(selectedImg), [round(sx/3), round(sy/2), length(sliceToUse), length(timeFrameToUse)]));
end


return