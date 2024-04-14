%% The matlab script for varied mask generation for TrainingSet in Task 2 (CMRxRecon MICCAI2024)
% Author: Zi Wang (wangzi1023@stu.xmu.edu.cn; wangziblake@gmail.com)
% April 9, 2024

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., Deep Separable Spatiotemporal Learning for Fast Dynamic Cardiac MRI, arXiv:2402.15939, 2024.

clc
clear all
close all
warning off
%% Add path
currentFolder = pwd;
addpath(genpath(currentFolder));

%% Set path
TaskName = 'Task2';  % Task2
setName = 'TrainingSet';  % TrainingSet

% TrainingSet
basePath = '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil';

mainDataPath = strcat(basePath,'/');
FileList = dir(mainDataPath);  % Different modalities: Aorta, Cine, Mapping, Tagging
NumFile = length(FileList);

%% Running all modalities, datasets, samplings, and patient IDs
for ind0 = 1 : NumFile
    file_name = FileList(ind0).name;
    disp(['Running modality file:',file_name]);
    dataPath = strcat(mainDataPath,file_name,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/'
    fileNameSet = dir(dataPath);
    fileSetLen = length(fileNameSet);  % Example: if only have TrainingSet, fileSetLen = 1; if have three type of sets, fileSetLen = 3.
    for ind1 = 1 : fileSetLen
        file_nameSet = fileNameSet(ind1).name;
        disp(['Running dataset file:',file_nameSet]);
        dataPathSet = strcat(dataPath,file_nameSet,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/TrainingSet/'
        fileNameFS = dir(dataPathSet);
        fileFSLen = length(fileNameFS);  % Example: if only have FullSample, fileFSLen = 1; if have N type of sampling, fileFSLen = N.
        for ind2 = 1 : fileFSLen
            file_nameFS = fileNameFS(ind2).name;
            disp(['Running sampling file:',file_nameFS]);
            dataPathFS = strcat(dataPathSet,file_nameFS,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/TrainingSet/FullSample/'
            fileNameID = dir(dataPathFS);
            fileIDLen = length(fileNameID);  % Example: if only have P001, fileIDLen = 1; if have N different patient ID, fileIDLen = N.
            for ind3 = 1 : fileIDLen
                file_nameID = fileNameID(ind3).name;
                disp(['Running ID file:',file_nameID]);
                dataPathID = strcat(dataPathFS,file_nameID,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/TrainingSet/FullSample/P001/'
                fileNamemat = dir(dataPathID);
                filematLen = length(fileNamemat);  % Example: if only have aorta_tra.mat, filematLen = 1; if have N different .mat, filematLen = N.
                % Running all .mat
                for ind4 = 1 : filematLen
                    imgName = fileNamemat(ind4).name;
                    
                    %% Aorta_tra
                    if contains(imgName,'aorta_tra.mat')
                        dataName = 'aorta_tra';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/TrainingSet/Mask_Task2/P001/aorta_tra_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% Aorta_sag
                    if contains(imgName,'aorta_sag.mat')
                        dataName = 'aorta_sag';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Aorta/TrainingSet/Mask_Task2/P001/aorta_sag_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% Cine_sax
                    if contains(imgName,'cine_sax.mat')
                        dataName = 'cine_sax';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat     
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Cine/TrainingSet/Mask_Task2/P001/cine_sax_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% Cine_lax
                    if contains(imgName,'cine_lax.mat')
                        dataName = 'cine_lax';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Cine/TrainingSet/Mask_Task2/P001/cine_lax_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% Cine_lvot
                    if contains(imgName,'cine_lvot.mat')
                        dataName = 'cine_lvot';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat 
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Cine/TrainingSet/Mask_Task2/P001/cine_lvot_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% T1map
                    if contains(imgName,'T1map.mat')
                        dataName = 'T1map';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Mapping/TrainingSet/Mask_Task2/P001/T1map_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% T2map
                    if contains(imgName,'T2map.mat')
                        dataName = 'T2map';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat    
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Mapping/TrainingSet/Mask_Task2/P001/T2map_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                    
                    %% Tagging
                    if contains(imgName,'tagging.mat')
                        dataName = 'tagging';
                        data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                        mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                        % Parameters for mask generation
                        if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                            patterns = ["ktUniform", "ktGaussian", "ktRadial"]; % pattern type
                            for i = 1 : length(patterns)
                                pattern = patterns{i}; 
                                for R = [4,8,12,16,20,24]
                                    ChallengeMaskGen_Task2_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                    % Save example: '/home2/Raw_data/MICCAIChallenge2024/ChallengeData/MultiCoil/Tagging/TrainingSet/Mask_Task2/P001/tagging_mask_ktUniform4.mat'
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
