function runRecon(basePath,mainSavePath,coilInfo,setName,dataType,taskType,sampleStatusType,reconType,imgShow)
% 
% basePath: the path where the data is stored
%                  should be the superior path of the "MultiCoil" folder
% mainSavePath: the root storage path of the reconstructed data
% coilInfo: should be 'MultiCoil'
% setName: 'TrainingSet', 'ValidationSet', 'TestSet'
% dataType: 'Aorta', 'BlackBlood', 'Cine', 'Flow2d',   'Mapping', 'Tagging'
% taskType: 'Task1', 'Task2'

% sampleStatusType = 0 means full kspace data
% sampleStatusType = 1 means subsampled data

% reconType = 0: perform zero-filling recon
% reconType = 1: perform GRAPPA recon
% reconType = 2: perform SENSE recon
% reconType = 3: perform both GRAPPA and SENSE recon

% imgShow = 0: ignore image imshow
% imgShow = 1: image imshow


%% recon for different acc factors
if strcmpi(taskType, 'Task1')
    maskDirSuffix = 'Task1';
elseif strcmpi(taskType, 'Task2')
    maskDirSuffix = 'Task2';
else
    error('Wrong task type!')
end
if contains(setName, 'Train')
    kspaceDir = fullfile(basePath, coilInfo, dataType, setName, 'FullSample');
else
    kspaceDir = fullfile(basePath, coilInfo, dataType, setName, strcat('UnderSample_', taskType));
end
maskFolderName = strcat('Mask_',maskDirSuffix);
% traverse all subject folders
ksFileDirs = dir(kspaceDir);
for iPaths = 1:length(ksFileDirs)
    ksFileDirInfo = ksFileDirs(iPaths);
    % ignore '.' and '..', and '.DS_Store' for mac
    if ~strcmp(ksFileDirInfo.name, '.') && ~strcmp(ksFileDirInfo.name, '..') && ~strcmp(ksFileDirInfo.name, '.DS_Store')
        fullKsDirPath = fullfile(kspaceDir, ksFileDirInfo.name);

        % get mask folder path by string replacement
        fullMaskDirPath = replace(fullKsDirPath, 'FullSample', maskFolderName);
        if ksFileDirInfo.isdir
            % traverse all '.mat' files in a folder
            ksFiles = dir(fullKsDirPath);
            for iFilePaths = 1:length(ksFiles)
                ksFileInfo = ksFiles(iFilePaths);
                % ignore '.' and '..', and '.DS_Store' for mac
                if ~strcmp(ksFileInfo.name, '.') && ~strcmp(ksFileInfo.name, '..') && ~strcmp(ksFileInfo.name, '.DS_Store')
                    if ~ksFileInfo.isdir
                        disp(['Progress start for subject ', ksFileDirInfo.name, ', data ', ksFileInfo.name])
                        fullKsFilePath = fullfile(fullKsDirPath, ksFileInfo.name);
                        kspaceData = load(fullKsFilePath);
                        fields = fieldnames(kspaceData);
                        newName = 'kspace';
                        eval([newName ' = kspaceData.' fields{1} ';']);


                        % to reduce the computing burden and space, we only evaluate the central 2 slices
                        % For cine, flow2d, aorta, tagging: use the first 3 time frames for ranking!
                        % For mapping: we need all weighting for ranking!
                        % For blackblood, it does not have the fifth dimention!
                        isBlackBlood = 0;
                        if contains(ksFileInfo.name, 'blackblood')
                            [sx,sy,scc,sz] = size(kspace);
                            t = 1;
                            isBlackBlood = 1;
                        else
                            [sx,sy,scc,sz,t] = size(kspace);
                        end
                        isMapping =  contains(ksFileInfo.name, 'T1map') || contains(ksFileInfo.name, 'T2map.mat');
                        
                                                
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

               
                        if sampleStatusType == 1
                            %  running the code on the training set requires iterating over the undersampled template
                            if contains(setName, 'Train')
                                maskFiles = dir(fullfile(fullMaskDirPath, '*.mat'));
                                for iMaskPaths = 1:length(maskFiles)
                                    maskedKspace = zeros(sx, sy, scc, sz, t);
                                    isRadial = 0;
                                    maskFileInfo = maskFiles(iMaskPaths);
                                    if isempty(strfind(maskFileInfo.name, replace(ksFileInfo.name, '.mat', '')))
                                        continue;
                                    end
                                    fullMaskFilePath = fullfile(fullMaskDirPath, maskFileInfo.name);
                                    if ~isempty(strfind(maskFileInfo.name, 'Radial'))
                                        isRadial = 1;
                                    end
                                    load(fullMaskFilePath);  % 'mask' is the key of us mask
                                    if length(size(mask))>2
                                        for iFrame = 1:size(mask,3)
                                            maskedKspace(:,:,:,:,iFrame) = kspace(:,:,:,:,iFrame) .* mask(:,:,iFrame);
                                        end
                                    else
                                        maskedKspace = kspace .* mask;
                                    end
                                    selectedKspace = maskedKspace(:, : ,:, sliceToUse, timeFrameToUse);


                                    % recon
                                    reconImg = ChallengeRecon(selectedKspace, sampleStatusType, reconType, imgShow, isRadial);
                                    if length(timeFrameToUse) > 1
                                        img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse),length(timeFrameToUse)]));
                                    else
                                        img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse)]));
                                    end
                                end

                            % the data in the validationset and testset are undersampled
                            else
                                isRadial = 0;
                                if ~isempty(strfind(ksFileInfo.name, 'Radial'))
                                        isRadial = 1;
                                end
                                try
                                selectedKspace = kspace(:, :, :, sliceToUse, timeFrameToUse);
                                catch
                                    disp
                                end
                                reconImg = ChallengeRecon(selectedKspace, sampleStatusType, reconType, imgShow, isRadial);
                                if length(timeFrameToUse) > 1
                                    img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse),length(timeFrameToUse)]));
                                else
                                    img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse)]));
                                end
                            end

                            % mkdir and save
                            fullSaveDirPath = fullfile(mainSavePath, coilInfo, dataType, setName, taskType, ksFileDirInfo.name);
                            if contains(setName, 'Train')
                                fullSavePath = fullfile(fullSaveDirPath, replace(maskFileInfo.name, '_mask', ''));
                            else
                                fullSavePath = fullfile(fullSaveDirPath, ksFileInfo.name);
                            end

                            % create any missing folders in the save path
                            if ~exist(fullSaveDirPath, 'dir')
                                createRecursiveDir(fullSaveDirPath)
                            end

                            save(fullSavePath, 'img4ranking');

                        %  normally this branch will not be entered
                        else
                            selectedKspace = kspace(:, :, :, sliceToUse, timeFrameToUse);
                            reconImg = ChallengeRecon(selectedKspace, sampleStatusType, reconType, imgShow);
                            if length(timeFrameToUse) > 1
                                img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse),length(timeFrameToUse)]));
                            else
                                img4ranking = single(crop(abs(reconImg),[round(sx/3),round(sy/2),length(sliceToUse)]));
                            end
                            fullSaveDirPath = fullfile(mainSavePath, coilInfo, dataType, setName, taskType, 'FullSample', ksFileDirInfo.name);
                            fullSavePath = fullfile(fullSaveDirPath, ksFileInfo.name);
                              
                            if ~exist(fullSaveDirPath, 'dir')
                                createRecursiveDir(fullSaveDirPath)
                            end
                            save(fullSavePath, 'img4ranking');                            
                        end
                        disp("Reconstructed successfully!")
                    end
                end
            end
        end
    end
end