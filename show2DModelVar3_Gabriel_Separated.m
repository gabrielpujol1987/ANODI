function show2DModelVar3_Gabriel_Separated(DisMtrx1,DisMtrx2,DisMtrx3,TrainigImage,re1,re2,re3, NomTI, NomAlg1,NomAlg2,NomAlg3)
% this function is used for 2D case

% show the variability of the three sets of realizations
% input: DisMtrx1 is the distance matrix for Algorithm1 realizations
% input: DisMtrx2 is the distance matrix for Algorithm2 realizations
% input: DisMtrx3 is the distance matrix for Algorithm3 realizations
% input: TrainigImage is the training image:	e.g. 101*101
% input: re1 is Algorithm1 realizations: 		e.g. 101*101*50
% input: re2 is Algorithm2 realizations:		e.g. 101*101*50
% input: re3 is Algorithm3 realizations:		e.g. 101*101*50

% NomAlg1 = 'Algorithm1';
% NomAlg2 = 'Algorithm2';
% NomAlg3 = 'Algorithm3';

% the amount of realizations from each algorithm.
num_re1 = size(DisMtrx1,3);
num_re2 = size(DisMtrx2,3);
num_re3 = size(DisMtrx3,3);

% The scales of the points to be plotted for each algorithm.
standardScale = 30;		bigScale = 100;
S1 = standardScale*ones(1,num_re1); S(num_re1)=bigScale;
S2 = standardScale*ones(1,num_re2); S(num_re2)=bigScale;
S3 = standardScale*ones(1,num_re3); S(num_re3)=bigScale;

%% Including the Training Image into the collections of Realizations
% realizations1 = re1;
% realizations1(:,:,num_re1) = TrainigImage;
% realizations2 = re2;
% realizations2(:,:,num_re2) = TrainigImage;
% realizations3 = re3;
% realizations3(:,:,num_re3) = TrainigImage;

%% Pyramid is the maximum amount of resolutions that will be worked.
Pyramid = 1;
resolutions = [1,2,3,4,6];

for ii = 1:Pyramid
    %% starting the plot, for each resolution:
    current_resolution=resolutions(ii);
    % Here they do a 3-D Scatter Plot. Let's decypher it:
    % First, start the 'figure' window, and then plot the axis...
    figure('Name','Tridimensional plot','NumberTitle','off');
    scatter3(0,0,0, S(num_re1), 'k','filled');
    hold on;
    
    %% WORKING WITH THE FIRST DISTANCE MATRIX!!!
    % set ddd to the DisMatrix corresponding to the current resolution
    ddd=squeeze(DisMtrx1(current_resolution,:,:));
    
    [~,IX2] = sort(ddd(51,:));
    
    
    % get the new Coordinates for the n points in a new p-dimensional space
    % along with the EigenValues (first k are positive if matrix euclidean)
    [Y1_re1,e_re1] = cmdscale(double(ddd));
    
    % get the new coordinates for every point, for plotting reasons...
    x_re1 = Y1_re1(:,1);
    y_re1 = Y1_re1(:,2);
    z_re1 = Y1_re1(:,3);
    % Centering the coordinates around the Training Image:
    x_re1 = x_re1 - x_re1(num_re1);
    y_re1 = y_re1 - y_re1(num_re1);
    z_re1 = z_re1 - z_re1(num_re1);
    scatter3(x_re1,y_re1,z_re1, S1, 'g','filled');		% FIRST DATA PLOTTED!!!
    
    %% WORKING WITH THE SECOND DISTANCE MATRIX!!!
    % set ddd to the DisMatrix corresponding to the current resolution
    ddd=squeeze(DisMtrx2(current_resolution,:,:));
    % get the new Coordinates for the n points in a new p-dimensional space
    % along with the EigenValues (first k are positive if matrix euclidean)
    [Y1_re2,e_re2] = cmdscale(double(ddd));
    
    % get the new coordinates for every point, for plotting reasons...
    x_re2 = Y1_re2(:,1);
    y_re2 = Y1_re2(:,2);
    z_re2 = Y1_re2(:,3);
    % Centering the coordinates around the Training Image:
    x_re2 = x_re2 - x_re2(num_re1);
    y_re2 = y_re2 - y_re2(num_re1);
    z_re2 = z_re2 - z_re2(num_re1);
    scatter3(x_re2,y_re2,z_re2, S2,'b','filled');	% SECOND DATA PLOTTED!!!
    
    %% WORKING WITH THE THIRD DISTANCE MATRIX!!!
    % set ddd to the DisMatrix corresponding to the current resolution
    ddd=squeeze(DisMtrx3(current_resolution,:,:));
    % get the new Coordinates for the n points in a new p-dimensional space
    % along with the EigenValues (first k are positive if matrix euclidean)
    [Y1_re3,e_re3] = cmdscale(double(ddd));
    
    % get the new coordinates for every point, for plotting reasons...
    x_re3 = Y1_re3(:,1);
    y_re3 = Y1_re3(:,2);
    z_re3 = Y1_re3(:,3);
    % Centering the coordinates around the Training Image:
    x_re3 = x_re3 - x_re3(num_re1);
    y_re3 = y_re3 - y_re3(num_re1);
    z_re3 = z_re3 - z_re3(num_re1);
    scatter3(x_re3,y_re3,z_re3, S3,'r','filled');	% THIRD DATA PLOTTED!!!
    
   
    %% PLOTTING THE LEGEND!!!
    scatter3(0,0,0,S(num_re1),'k','filled');						% Training image re-plotted for visibility!
    legend(NomTI,NomAlg1,NomAlg2,NomAlg3);				% Legend...
    title(['Multi Resolution= ' int2str(current_resolution)]);				% etc...
    hold off; % end of plotting the 3-D graphic.
    
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure('Name','X-Y Plot','NumberTitle','off');
    scatter(x_re1,y_re1,S1,'g','filled');
    hold on;
    scatter(x_re2,y_re2,S2,'b','filled');
    scatter(x_re3,y_re3,S3,'r','filled');
    scatter(0,0,100,'k','filled');
    title(['x-y Plot & Multi Scale = ' int2str(current_resolution)]);
    legend(NomAlg1,NomAlg2,NomAlg3,NomTI);
    hold off;
    
    figure('Name','X-Z Plot','NumberTitle','off');
    scatter(x_re1,z_re1,S1,'g','filled');
    hold on;
    scatter(x_re2,z_re2,S2,'b','filled');
    scatter(x_re3,z_re3,S3,'r','filled');
    scatter(0,0,100,'k','filled');
    title(['x-z Plot & Multi Scale = ' int2str(current_resolution)]);
    legend(NomAlg1,NomAlg2,NomAlg3,NomTI);
    hold off;
    
    figure('Name','Y-Z Plot','NumberTitle','off');
    scatter(y_re1,z_re1,S1,'g','filled');
    hold on;
    scatter(y_re2,z_re2,S2,'b','filled');
    scatter(y_re3,z_re3,S3,'r','filled');
    scatter(0,0,100,'k','filled');
    title(['y-z Plot & Multi Scale = ' int2str(current_resolution)]);
    legend(NomAlg1,NomAlg2,NomAlg3,NomTI);
    hold off;
    
    
end	 % for ii=1:Pyramid

end