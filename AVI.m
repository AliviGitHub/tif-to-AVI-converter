% Start with a folder and get a list of all subfolders.
% Finds and prints names of all PNG, JPG, and TIF images in 
% that folder and all of its subfolders.
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
% Define a starting folder.
start_path = fullfile(matlabroot, 'gatan_raid_user','Michelle');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
  return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
  [singleSubFolder, remain] = strtok(remain, ';');
  if isempty(singleSubFolder)
    break;
  end
  listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);
% Process all image files in those folders.
  % Get TIFF files.
  folder=char(listOfFolderNames);
  baseFileNames = dir(folder);
  baseFileNames('*.dm4')=[];
  % Now we have a list of all files in this folder.
  % Sort files so they are in order
  cellBase=struct2cell(baseFileNames);
  cellBase=cellBase';
  cellBase(:,2:end)=[];
  cellBase=natsort(cellBase);
  cellBase(1:2,:)=[];
    % Go through all those image files.
  v=VideoWriter('AuTiO2_80nm_FeCl3_Tris2.avi');
  open(v);
    for f = 1 : length(cellBase)
      foldName = fullfile(folder, cellBase(f,:));
      foldName=char(foldName);
      imageData=imread(foldName);
      imageData8=im2uint8(imageData);
      writeVideo(v,imageData8);
    end
  close(v)