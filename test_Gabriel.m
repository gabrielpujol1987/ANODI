clear all;
% close all;

pathTI = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\strebelle 101x101 BW.bmp';
TI = imread(pathTI);
% [resolutionX_TI, resolutionY_TI] = size(TI);


path1 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A1';
path2 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A2';
path3 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A3';

NomAlg1 = ExtractNameFromPath(path1);
NomAlg2 = ExtractNameFromPath(path2);
NomAlg3 = ExtractNameFromPath(path3);

extension = '*.bmp';
realizations1 = load_folder_Gabriel(path1);%, extension);
realizations2 = load_folder_Gabriel(path2);%, extension);
realizations3 = load_folder_Gabriel(path3);%, extension);


tempSize = 20;  % Initially, 20 is what they say in the paper!

% AND HERE IT COMES!!!!!!
DistMtrx1 = calculateModelVar_CHP_Gabriel(realizations1, TI, tempSize);
DistMtrx2 = calculateModelVar_CHP_Gabriel(realizations2, TI, tempSize);
DistMtrx3 = calculateModelVar_CHP_Gabriel(realizations3, TI, tempSize);








% show2DModelVar2_Gabriel(DistMtrx1,DistMtrx2,TI,realizations1,realizations2);
% show2DModelVar3_Gabriel(DistMtrx1,DistMtrx2,DistMtrx3,TI,realizations1,realizations2,realizations3);
% show2DModelVar2_Gabriel_Separated(DistMtrx1,DistMtrx2,TI,realizations1,realizations2);
show2DModelVar3_Gabriel_Separated(DistMtrx1,DistMtrx2,DistMtrx3,TI,realizations1,realizations2,realizations3,NomAlg1,NomAlg2,NomAlg3);


return;










% Specify the folder where the files live.
fp1      = mfilename('fullpath');
dirName1 = fileparts(fp1);
slash1   = strfind(dirName1, '\');
dirName1 = dirName1(1:slash1(end)-1);

% myFolder = [dirName1 '\ComparingGSAlgorithms\Data'];
myFolder = [dirName1 '\ComparingGSAlgorithms\DataG'];
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

addpath(myFolder);


oldDir = cd(myFolder);

a = dir;
curdir = pwd;



for i_dir=1:size(a,1)
	if a(i_dir).isdir && ~strcmp(a(i_dir).name,'.') && ~strcmp(a(i_dir).name,'..') 
        cd([curdir '/' a(i_dir).name])

        % Get a list of all files in the folder with the desired file name pattern.
        filePattern = fullfile(pwd, '*.bmp'); % Change to whatever pattern you need.
        theFiles = dir(filePattern);
        
        for k = 1 : length(theFiles)
            baseFileName = theFiles(k).name;
            fullFileName = fullfile(pwd, baseFileName);
%             fprintf(1, 'Now reading %s\n', fullFileName);

            % Now do whatever you want with this file name,
            % such as reading it in as an image array with imread()
            imageArray = imread(fullFileName);
            
%             imshow(imageArray);  % Display image.
%             drawnow; % Force display to update immediately.
        end
       
       
       
	end
end


return;
















%% show 2D case 
clear all;

load full_cluster_DISPAT_new.mat;
DisMtrx1=JS_Pyramid2;
clear JS_Pyriamid2;

load full_cluster_CCSIM_new.mat;
DisMtrx2=JS_Pyramid2;
clear JS_Pyriamid2;

load full_cluster_SISIM_new.mat;
DisMtrx3=JS_Pyramid2;
clear JS_Pyriamid2;

load 'Ti_channel.mat';


% realizations
load 'realization_dispat.mat';
re1=realization1;
clear realization1;

load 'CCSIM_new.mat';
re2=reshape(Final,101,101,50);
clear Final;

load 'sisim_channel.mat';
re3=realization1;
clear realization1;

clear HHH_CCSIM;
clear HHH_DISPAT;
clear HHH_SISIM;
clear JS_Pyramid2;


% show2DModelVar2(DisMtrx1,DisMtrx2,out,re1,re2);
% show2DModelVar3(DisMtrx1,DisMtrx2,DisMtrx3,out,re1,re2,re3);