function show2DModelVar3_Gabriel_Separated(DisMtrx1, DisMtrx2, DisMtrx3, TrainingImage, realizations1, realizations2, realizations3, NomTI, NomAlg1, NomAlg2, NomAlg3)
% this function is used for 2D case

% show the variability of the three sets of realizations
% input: DisMtrx1 is the distance matrix for Algorithm1 realizations
% input: DisMtrx2 is the distance matrix for Algorithm2 realizations
% input: DisMtrx3 is the distance matrix for Algorithm3 realizations
% input: TrainigImage is the training image:			e.g. 101*101
% input: realizations1 is Algorithm1 realizations: 		e.g. 101*101*50
% input: realizations2 is Algorithm2 realizations:		e.g. 101*101*50
% input: realizations3 is Algorithm3 realizations:		e.g. 101*101*50


% the amount of realizations from each algorithm.
num_re1 = size(DisMtrx1, 3);
num_re2 = size(DisMtrx2, 3);
num_re3 = size(DisMtrx3, 3);

% The scales of the points to be plotted for each algorithm.
standardScale = 20;			bigScale = 100;
S1 = standardScale*ones(1, num_re1); S1(num_re1) = bigScale; % last is TI
S2 = standardScale*ones(1, num_re2); S2(num_re2) = bigScale; % last is TI
S3 = standardScale*ones(1, num_re3); S3(num_re3) = bigScale; % last is TI

resizedTI = imresize(TrainingImage, [size(realizations1, 1) size(realizations1, 2)]);

%% Including the Training Image into the collections of Realizations
realizations1(:, :, num_re1) = resizedTI;	% TrainigImage;
realizations2(:, :, num_re2) = resizedTI;	% TrainigImage;
realizations3(:, :, num_re3) = resizedTI;	% TrainigImage;

%% Set of resolutions that will be worked.
resolutions = [1, 2, 3, 4, 6];

for ii = 1:1		% size(resolutions, 2);
	%% starting the plot, for each resolution:
	current_resolution = resolutions(ii);
	
	% Here they do a 3-D Scatter Plot. Let's decypher it:
	% First, start the 'figure' window, and then plot the axis...
	figure('Name', 'Tridimensional plot', 'NumberTitle', 'off');
	scatter3(0, 0, 0, bigScale, 'k', 'filled');
	hold on;
	
	%% WORKING WITH THE FIRST DISTANCE MATRIX!!!
	% set ddd to the DisMatrix corresponding to the current resolution
	ddd = squeeze(DisMtrx1(current_resolution, :, :));
			
	% get the new Coordinates for the n points in a new p-dimensional space
	% along with the EigenValues (first k are positive if matrix euclidean)
	[Y1_re1, e_re1] = cmdscale(double(ddd));	% e_re1
	
	% get the new coordinates for every point, for plotting reasons...
	x_re1 = Y1_re1(:, 1);
	y_re1 = Y1_re1(:, 2);
	z_re1 = Y1_re1(:, 3);
	% Centering the coordinates around the Training Image:
	x_re1 = x_re1 - x_re1(num_re1);
	y_re1 = y_re1 - y_re1(num_re1);
	z_re1 = z_re1 - z_re1(num_re1);
	
	% Sorting
	[~, IX1] = sort(ddd(num_re1, :));
	% Plotting the set of points
	scatter3(x_re1, y_re1, z_re1, S1, 'g', 'filled');		% FIRST DATA PLOTTED!!!
	
	%% WORKING WITH THE SECOND DISTANCE MATRIX!!!
	% set ddd to the DisMatrix corresponding to the current resolution
	ddd = squeeze(DisMtrx2(current_resolution, :, :));
	% get the new Coordinates for the n points in a new p-dimensional space
	% along with the EigenValues (first k are positive if matrix euclidean)
	[Y1_re2, e_re2] = cmdscale(double(ddd));	% e_re2
	
	% get the new coordinates for every point, for plotting reasons...
	x_re2 = Y1_re2(:, 1);
	y_re2 = Y1_re2(:, 2);
	z_re2 = Y1_re2(:, 3);
	% Centering the coordinates around the Training Image:
	x_re2 = x_re2 - x_re2(num_re1);
	y_re2 = y_re2 - y_re2(num_re1);
	z_re2 = z_re2 - z_re2(num_re1);
	
	% Positions of the 'sorted' list, according to the distances to the TI
	[~, IX2] = sort(ddd(num_re2, :));
	% Plotting
	scatter3(x_re2, y_re2, z_re2, S2, 'b', 'filled');	% SECOND DATA PLOTTED!!!
	
	%% WORKING WITH THE THIRD DISTANCE MATRIX!!!
	% set ddd to the DisMatrix corresponding to the current resolution
	ddd = squeeze(DisMtrx3(current_resolution, :, :));
	% get the new Coordinates for the n points in a new p-dimensional space
	% along with the EigenValues (first k are positive if matrix euclidean)
	[Y1_re3, e_re3] = cmdscale(double(ddd));
	
	% get the new coordinates for every point, for plotting reasons...
	x_re3 = Y1_re3(:, 1);
	y_re3 = Y1_re3(:, 2);
	z_re3 = Y1_re3(:, 3);
	% Centering the coordinates around the Training Image:
	x_re3 = x_re3 - x_re3(num_re1);
	y_re3 = y_re3 - y_re3(num_re1);
	z_re3 = z_re3 - z_re3(num_re1);
	
	% Positions of the 'sorted' list, according to the distances to the TI
	[~, IX3] = sort(ddd(num_re3, :));
	% Plotting
	scatter3(x_re3, y_re3, z_re3, S3, 'r', 'filled');	% THIRD DATA PLOTTED!!!
	
	%% putting the labels to the special points
	text(x_re1(IX1( 2)),y_re1(IX1( 2)),z_re1(IX1( 2)),'\rightarrow  1','FontSize',10,'Color','g');
	text(x_re1(IX1(21)),y_re1(IX1(21)),z_re1(IX1(21)),'\rightarrow 20','FontSize',10,'Color','g');
	text(x_re1(IX1(31)),y_re1(IX1(31)),z_re1(IX1(31)),'\rightarrow 30','FontSize',10,'Color','g');
	text(x_re1(IX1(41)),y_re1(IX1(41)),z_re1(IX1(41)),'\rightarrow 40','FontSize',10,'Color','g');
	text(x_re1(IX1(51)),y_re1(IX1(51)),z_re1(IX1(51)),'\rightarrow 50','FontSize',10,'Color','g');
	
	text(x_re2(IX2( 2)),y_re2(IX2( 2)),z_re2(IX2( 2)),'\rightarrow  1','FontSize',10,'Color','b');
	text(x_re2(IX2(21)),y_re2(IX2(21)),z_re2(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
	text(x_re2(IX2(31)),y_re2(IX2(31)),z_re2(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
	text(x_re2(IX2(41)),y_re2(IX2(41)),z_re2(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
	text(x_re2(IX2(51)),y_re2(IX2(51)),z_re2(IX2(51)),'\rightarrow 50','FontSize',10,'Color','b');
	
	text(x_re3(IX3( 2)),y_re3(IX3( 2)),z_re3(IX3( 2)),'\rightarrow  1','FontSize',10,'Color','r');
	text(x_re3(IX3(21)),y_re3(IX3(21)),z_re3(IX3(21)),'\rightarrow 20','FontSize',10,'Color','r');
	text(x_re3(IX3(31)),y_re3(IX3(31)),z_re3(IX3(31)),'\rightarrow 30','FontSize',10,'Color','r');
	text(x_re3(IX3(41)),y_re3(IX3(41)),z_re3(IX3(41)),'\rightarrow 40','FontSize',10,'Color','r');
	text(x_re3(IX3(51)),y_re3(IX3(51)),z_re3(IX3(51)),'\rightarrow 50','FontSize',10,'Color','r');

	%% PLOTTING THE LEGEND!!!
	scatter3(0, 0, 0, bigScale, 'k', 'filled');						% Training image re-plotted for visibility!
	legend(NomTI, NomAlg1, NomAlg2, NomAlg3);				% Legend...
	title(['Multi Resolution = ' int2str(current_resolution)]);				% etc...
	hold off; % end of plotting the 3-D graphic.
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	%% X-Y Plot!!!
	figure('Name', 'X-Y Plot', 'NumberTitle', 'off');
	scatter(x_re1, y_re1, S1, 'g', 'filled');
	hold on;
	scatter(x_re2, y_re2, S2, 'b', 'filled');
	scatter(x_re3, y_re3, S3, 'r', 'filled');
	
	% putting the labels to the special points
	text(x_re1(IX1( 2)),y_re1(IX1( 2)),'\rightarrow  1','FontSize',10,'Color','g');
	text(x_re1(IX1(21)),y_re1(IX1(21)),'\rightarrow 20','FontSize',10,'Color','g');
	text(x_re1(IX1(31)),y_re1(IX1(31)),'\rightarrow 30','FontSize',10,'Color','g');
	text(x_re1(IX1(41)),y_re1(IX1(41)),'\rightarrow 40','FontSize',10,'Color','g');
	text(x_re1(IX1(51)),y_re1(IX1(51)),'\rightarrow 50','FontSize',10,'Color','g');
	
	text(x_re2(IX2( 2)),y_re2(IX2( 2)),'\rightarrow  1','FontSize',10,'Color','b');
	text(x_re2(IX2(21)),y_re2(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
	text(x_re2(IX2(31)),y_re2(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
	text(x_re2(IX2(41)),y_re2(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
	text(x_re2(IX2(51)),y_re2(IX2(51)),'\rightarrow 50','FontSize',10,'Color','b');
	
	text(x_re3(IX3( 2)),y_re3(IX3( 2)),'\rightarrow  1','FontSize',10,'Color','r');
	text(x_re3(IX3(21)),y_re3(IX3(21)),'\rightarrow 20','FontSize',10,'Color','r');
	text(x_re3(IX3(31)),y_re3(IX3(31)),'\rightarrow 30','FontSize',10,'Color','r');
	text(x_re3(IX3(41)),y_re3(IX3(41)),'\rightarrow 40','FontSize',10,'Color','r');
	text(x_re3(IX3(51)),y_re3(IX3(51)),'\rightarrow 50','FontSize',10,'Color','r');
		
	% ending of the plot
	scatter(0, 0, 100, 'k', 'filled');
	title(['x-y Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomAlg3, NomTI);
	hold off;
	
	
	%% X-Z Plot!!!
	figure('Name', 'X-Z Plot', 'NumberTitle', 'off');
	scatter(x_re1, z_re1, S1, 'g', 'filled');
	hold on;
	scatter(x_re2, z_re2, S2, 'b', 'filled');
	scatter(x_re3, z_re3, S3, 'r', 'filled');
	
	% putting the labels to the special points
	text(x_re1(IX1( 2)),z_re1(IX1( 2)),'\rightarrow 1','FontSize',10,'Color','g');
	text(x_re1(IX1(21)),z_re1(IX1(21)),'\rightarrow 20','FontSize',10,'Color','g');
	text(x_re1(IX1(31)),z_re1(IX1(31)),'\rightarrow 30','FontSize',10,'Color','g');
	text(x_re1(IX1(41)),z_re1(IX1(41)),'\rightarrow 40','FontSize',10,'Color','g');
	text(x_re1(IX1(51)),z_re1(IX1(51)),'\rightarrow 50','FontSize',10,'Color','g');
	
	text(x_re2(IX2( 2)),z_re2(IX2( 2)),'\rightarrow 1','FontSize',10,'Color','b');
	text(x_re2(IX2(21)),z_re2(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
	text(x_re2(IX2(31)),z_re2(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
	text(x_re2(IX2(41)),z_re2(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
	text(x_re2(IX2(51)),z_re2(IX2(51)),'\rightarrow 50','FontSize',10,'Color','b');
	
	text(x_re3(IX3( 2)),z_re3(IX3( 2)),'\rightarrow 1','FontSize',10,'Color','r');
	text(x_re3(IX3(21)),z_re3(IX3(21)),'\rightarrow 20','FontSize',10,'Color','r');
	text(x_re3(IX3(31)),z_re3(IX3(31)),'\rightarrow 30','FontSize',10,'Color','r');
	text(x_re3(IX3(41)),z_re3(IX3(41)),'\rightarrow 40','FontSize',10,'Color','r');
	text(x_re3(IX3(51)),z_re3(IX3(51)),'\rightarrow 50','FontSize',10,'Color','r');
	
	% ending of the plot
	scatter(0, 0, 100, 'k', 'filled');
	title(['x-z Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomAlg3, NomTI);
	hold off;
	
	
	%% Y-Z Plot!!!
	figure('Name', 'Y-Z Plot', 'NumberTitle', 'off');
	scatter(y_re1, z_re1, S1, 'g', 'filled');
	hold on;
	scatter(y_re2, z_re2, S2, 'b', 'filled');
	scatter(y_re3, z_re3, S3, 'r', 'filled');
	
	% putting the labels to the special points
	text(y_re1(IX1( 2)),z_re1(IX1( 2)),'\rightarrow 1','FontSize',10,'Color','g');
	text(y_re1(IX1(21)),z_re1(IX1(21)),'\rightarrow 20','FontSize',10,'Color','g');
	text(y_re1(IX1(31)),z_re1(IX1(31)),'\rightarrow 30','FontSize',10,'Color','g');
	text(y_re1(IX1(41)),z_re1(IX1(41)),'\rightarrow 40','FontSize',10,'Color','g');
	text(y_re1(IX1(51)),z_re1(IX1(51)),'\rightarrow 50','FontSize',10,'Color','g');
	
	text(y_re2(IX2( 2)),z_re2(IX2( 2)),'\rightarrow 1','FontSize',10,'Color','b');
	text(y_re2(IX2(21)),z_re2(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
	text(y_re2(IX2(31)),z_re2(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
	text(y_re2(IX2(41)),z_re2(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
	text(y_re2(IX2(51)),z_re2(IX2(51)),'\rightarrow 50','FontSize',10,'Color','b');
	
	text(y_re3(IX3( 2)),z_re3(IX3( 2)),'\rightarrow 1','FontSize',10,'Color','r');
	text(y_re3(IX3(21)),z_re3(IX3(21)),'\rightarrow 20','FontSize',10,'Color','r');
	text(y_re3(IX3(31)),z_re3(IX3(31)),'\rightarrow 30','FontSize',10,'Color','r');
	text(y_re3(IX3(41)),z_re3(IX3(41)),'\rightarrow 40','FontSize',10,'Color','r');
	text(y_re3(IX3(51)),z_re3(IX3(51)),'\rightarrow 50','FontSize',10,'Color','r');
	
	% ending of the plot
	scatter(0, 0, 100, 'k', 'filled');
	title(['y-z Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomAlg3, NomTI);
	hold off;
	
	
	%% the closest guys, of the first set of points.
	figure;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,1);
	out_c = realizations1(:,:,IX1(1));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['TI: ' NomTI ]);%', MR = ' int2str(current_resolution)]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,2);
	out_c = realizations1(:,:,IX1(2));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title('closest to TI');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for kk = 1:4
		subplot(2,3,kk+2);
		out_c = realizations1(:,:,IX1(11+10*kk));
		out1 = imresize(out_c,1/current_resolution); 
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(11+10*kk-1) 'th closest to TI'] );
	end


	%% the closest guys, of the second set of points.
	figure;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,1);
	out_c = realizations2(:,:,IX2(1));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['TI: ' NomTI ]);%', MR = ' int2str(current_resolution)]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,2);
	out_c = realizations2(:,:,IX2(2));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title('closest to TI');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for kk = 1:4
		subplot(2,3,kk+2);
		out_c = realizations2(:,:,IX2(11+10*kk));
		out1 = imresize(out_c,1/current_resolution);
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(11+10*kk-1) 'th closest to TI'] );
	end


	%% the closest guys, of the third set of points.
	figure;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,1);
	out_c = realizations3(:,:,IX3(1));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['Ti, SISIM, MR = ' int2str(current_resolution)]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,2);
	out_c = realizations3(:,:,IX3(2));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title('closest to Ti');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for kk = 1:4
		subplot(2,3,kk+2);
		out_c = realizations3(:,:,IX3(11+10*kk));
		out1 = imresize(out_c,1/current_resolution);
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(11+10*kk-1) 'th closest to Ti'] );
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
end		% end of for

end		% end of function