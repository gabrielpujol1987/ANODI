function DistMtrx = calculateModelVar_CHP_Gabriel2(realizations,training_image_original, tempSize)
% input:  realizations is all the realizations needed: e.g.101*101*50
% input:  training_image_original is the training image
% input:  tempSize is the optimal size of template for training image
% output: DistMtrx: e.g. 10*51*51 (10 is the level of Pyramid)

num_realizations = size(realizations,3);
myResolution = 1;
DistMtrx = zeros(myResolution, num_realizations+1, num_realizations+1);

% Visualize data
nxS = size(training_image_original,1);
nyS = size(training_image_original,2);
nzS = 1;
reaS = realizations;% reshape(realizations,[nxS,nyS,nzS,num_realizations]);


% Dimensions
parS.multipleGrid = 1;
parS.m1 = 1;
parS.MDS = tempSize; %20;
parS.MDistMtrx = tempSize; %20;
parS.clus = 50;		% WTF IS THIS???
parS.Patx = tempSize;
parS.Paty = tempSize;
parS.Patz = 1;
parS.mx = 4;
parS.my = 4;
parS.mz = 1;
parS.Dimx = nxS;
parS.Dimy = nyS;
parS.Dimz = nzS;

% Classify patterns
[XS, YS, eS, ~, idxS, prototypeS, MDistMtrxS] = MYclassifyPatterns(training_image_original, parS);
parS.clus = size(prototypeS,1);

% Bulid the histogram of training image
hh = zeros(parS.clus,1);
for i = 1:size(idxS,1)
	hh(idxS(i)) = hh(idxS(i))+1;
end


% Build the clustered histograms
HS = zeros(parS.clus,num_realizations+1);

parS.mx = 1;
parS.my = 1;
parS.mz = 1;
% Included the Dimension of the Realizations (crashed in CompHistRea)
parS.Dimx = size(realizations,1);
parS.Dimy = size(realizations,2);
parS.Dimz = 1;%size(realizations,3);


for i = 1:num_realizations
	[HS(:,i), npatS] = CompHistRea(reaS(:,:,i), prototypeS, parS);
end

HS(:,num_realizations+1) = hh;
NClust = size(HS,1);

% Compute distances between clustered histograms of models
for i = 1:num_realizations+1
	for j = i+1:num_realizations+1 
		DistMtrx(myResolution,i,j) = JSDist(HS(:,i), HS(:,j));
		DistMtrx(myResolution,j,i) = DistMtrx(myResolution,i,j);
	end
end 