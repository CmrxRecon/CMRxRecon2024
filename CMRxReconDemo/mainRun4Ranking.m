%% This is a demo to generate validation results into the submission folder (this step is required only during validation phase!!!)
% MICCAI "CMRxRecon" challenge 2023 
% 2023.05.06 @ fudan university
% Email: wangcy@fudan.edu.cn

% to reduce the computing burden and space, we only evaluate the central 2 slices
% For cine: use the first 3 time frames for ranking!
% For mapping: we need all weighting for ranking!
% crop the middle 1/6 of the original image for ranking
clc
clear

%% add path
addpath('./utils')
% put your data directory here
basePath = '/path/to/ChallengeData'; % the superior directory of 'MultiCoil/'
mainSavePath = '/Path/to/your/save/dir'; % output path
taskType = 'Task1';  % options: ['Task1', 'Task2'], Case Sensitive!!!!
%% do not make changes
dataTypeList = {'Aorta', 'BlackBlood', 'Cine', 'Flow2d',   'Mapping', 'Tagging'};
setName = 'ValidationSet/'; % options: 'ValidationSet/', 'TestSet/'
%% Generate folder for submission

coilInfo = 'MultiCoil/'; 
for iDataType = 1:length(dataTypeList)
    % 'FullSample' needs to be changed to the actual path name
    taskDir = fullfile(basePath, coilInfo, dataTypeList{iDataType}, setName, taskType);
    ksFileDirs = dir(taskDir);
    for iPaths = 1:length(ksFileDirs)
        ksFileDirInfo = ksFileDirs(iPaths);
        % ignore '.' and '..', and '.DS_Store' for mac
        if ~strcmp(ksFileDirInfo.name, '.') && ~strcmp(ksFileDirInfo.name, '..') && ~strcmp(ksFileDirInfo.name, '.DS_Store')
            fullKsDirPath = fullfile(taskDir, ksFileDirInfo.name);
            if ksFileDirInfo.isdir
                % traverse all '.mat' files in a folder
                ksFiles = dir(fullKsDirPath);
                for iFilePaths = 1:length(ksFiles)
                    ksFileInfo = ksFiles(iFilePaths);
                    % ignore '.' and '..', and '.DS_Store' for mac
                    if ~strcmp(ksFileInfo.name, '.') && ~strcmp(ksFileInfo.name, '..') && ~strcmp(ksFileInfo.name, '.DS_Store')
                        if ~ksFileInfo.isdir
                            fullKsFilePath = fullfile(fullKsDirPath, ksFileInfo.name);
                            kspaceData =  load(fullKsFilePath);
                            fields = fieldnames(kspaceData);
                            newName = 'kspace';
                            eval([newName ' = kspaceData.' fields{1} ';']);
                            img = ifft2c(kspace);
                            img4ranking = run4Ranking(img, ksFileInfo.name);

                            fullSaveDirPath = fullfile(mainSavePath, coilInfo, dataTypeList{iDataType}, setName, taskType, ksFileDirInfo.name);
                            fullSavePath = fullfile(fullSaveDirPath, ksFileInfo.name);
                            if ~exist(fullSaveDirPath, 'dir')
                                createRecursiveDir(fullSaveDirPath)
                            end
                            save(fullSavePath, 'img4ranking');
                        end
                    end
                end
            end
            disp(strcat(ksFileDirInfo.name, " multicoil data generation successful!"));
        end        
    end
end