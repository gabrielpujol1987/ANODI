function Process_Paths_Gabriel(path_TI, pattern_size, path_A1, path_A2, path_A3)

clearvars -except path_TI path_A1 path_A2 path_A3 pattern_size

% Case we have only two algorithms specified:
if nargin == 4  % before it was 3
    thereIsA3 = false;
% Case we have all three algorithms specified:
elseif nargin == 5  % before it was 4
    if path_A3 ~= 0
        thereIsA3 = true;
    else 
    thereIsA3 = false;
%     error('The third path is not valid!');
    end
    
% Any other case is invalid:
else
    return;
end



% First, get the Training Image:
TI = ReadImageOrCSV_Gabriel(path_TI);
NomTI = ExtractNameFromPath(path_TI);

% Second, get the first sets of simulation images:
% Calculate the Distance Matrices between the Simulations and the TI.
% The Template Size is set to 20 as said in the paper:
tempSize = pattern_size;% 20;  

% The first set:
realizations1 = load_folder_Gabriel(path_A1);%, extension);
DistMtrx1 = calculateModelVar_CHP_Gabriel2(realizations1, TI, tempSize);
NomAlg1 = ExtractNameFromPath(path_A1);

% The second set:
realizations2 = load_folder_Gabriel(path_A2);%, extension);
DistMtrx2 = calculateModelVar_CHP_Gabriel2(realizations2, TI, tempSize);
NomAlg2 = ExtractNameFromPath(path_A2);

% The third set, only if its Path is specified
if thereIsA3
    realizations3 = load_folder_Gabriel(path_A3);%, extension);
    DistMtrx3 = calculateModelVar_CHP_Gabriel2(realizations3, TI, tempSize);
	NomAlg3 = ExtractNameFromPath(path_A3);
	
	
    show2DModelVar3_Gabriel_Separated(DistMtrx1,DistMtrx2,DistMtrx3,TI,realizations1,realizations2,realizations3,NomTI,NomAlg1,NomAlg2,NomAlg3);
else
    show2DModelVar2_Gabriel_Separated(DistMtrx1,DistMtrx2,TI,realizations1,realizations2,NomTI,NomAlg1,NomAlg2);
% 	show2DModelVar2(DistMtrx1,DistMtrx2,TI,realizations1,realizations2);%,NomTI,NomAlg1,NomAlg2);
end



% show2DModelVar2_Gabriel(DistMtrx1,DistMtrx2,TI,realizations1,realizations2);
% show2DModelVar3_Gabriel(DistMtrx1,DistMtrx2,DistMtrx3,TI,realizations1,realizations2,realizations3);



