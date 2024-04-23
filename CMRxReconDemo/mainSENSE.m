%% This is a demo to generate SENSE recon results into the submission folder
% The folder name should be changed to "Subimission" before submission
% MICCAI "CMRxRecon" challenge 2023 
% 2023.03.06 @ fudan university
% Email: wangcy@fudan.edu.cn

clc
clear

%% add path
addpath(genpath('./GRAPPA'))
addpath(genpath('./ESPIRiT'))
addpath('./utils')

%% set info
coilInfo = 'MultiCoil/';  % singleCoil is not avalaible for PI recon
setName = 'TrainingSet/'; % options: 'ValidationSet/', 'TestSet/'
taskType = {'Task1', 'Task2'};
dataTypeList = {'Aorta', 'BlackBlood', 'Cine', 'Flow2d',   'Mapping', 'Tagging'};
% input and output folder paths
basePath = '/path/to/ChallengeData';
mainSavePath = '/Path/to/your/save/dir';


%% parameter meaning
% sampleStatusType = 0 means full kspace data
% sampleStatusType = 1 means subsampled data

% reconType = 0: perform zero-filling recon
% reconType = 1: perform GRAPPA recon
% reconType = 2: perform SENSE recon
% reconType = 3: perform both GRAPPA and SENSE recon

% imgShow = 0: ignore image imshow
% imgShow = 1: image imshow

%% SENSE recon
sampleStatusType = 1; 
reconType = 2;
imgShow = 0;
% Aorta
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{1},taskType{1},sampleStatusType,reconType,imgShow);
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{1},taskType{2},sampleStatusType,reconType,imgShow);
% Black Blood
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{2},taskType{1},sampleStatusType,reconType,imgShow); 
% Cine
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{3},taskType{1},sampleStatusType,reconType,imgShow);
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{3},taskType{2},sampleStatusType,reconType,imgShow); 
% Flow2d
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{4},taskType{1},sampleStatusType,reconType,imgShow);
% Mapping
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{5},taskType{1},sampleStatusType,reconType,imgShow);
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{5},taskType{2},sampleStatusType,reconType,imgShow);
% Tagging
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{6},taskType{1},sampleStatusType,reconType,imgShow);
runRecon(basePath,mainSavePath,coilInfo,setName,dataTypeList{6},taskType{2},sampleStatusType,reconType,imgShow);