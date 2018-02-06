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
S1 = standardScale*ones(1, num_re1); %S1(num_re1) = bigScale; % last is TI
S2 = standardScale*ones(1, num_re2); %S2(num_re2) = bigScale; % last is TI
S3 = standardScale*ones(1, num_re3); %S3(num_re3) = bigScale; % last is TI

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
	x_re2 = x_re2 - x_re2(num_re2);
	y_re2 = y_re2 - y_re2(num_re2);
	z_re2 = z_re2 - z_re2(num_re2);

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
	

	%% Preparing the label-text-writing variables:
	labels1 = 0:10:num_re1;
	labels1(1) = 1;
	labels1(size(labels1,2)+1) = num_re1-1;
	indices1 = IX1(labels1 + 1);
	
	labels2 = 0:10:num_re2;
	labels2(1) = 1;
	labels2(size(labels2,2)+1) = num_re2-1;
	indices2 = IX2(labels2 + 1);
	
	labels3 = 0:10:num_re3;
	labels3(1) = 1;
	labels3(size(labels3,2)+1) = num_re3-1;
	indices3 = IX3(labels3 + 1);


	%% putting the labels to the special points
	printText3D_Gabriel(x_re1, y_re1, z_re1, indices1, labels1, 'g');
	printText3D_Gabriel(x_re2, y_re2, z_re2, indices2, labels2, 'b');
	printText3D_Gabriel(x_re3, y_re3, z_re3, indices3, labels3, 'r');


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
	printText2D_Gabriel(x_re1, y_re1, indices1, labels1, 'g');
	printText2D_Gabriel(x_re2, y_re2, indices2, labels2, 'b');
	printText2D_Gabriel(x_re3, y_re3, indices3, labels3, 'r');

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
	printText2D_Gabriel(x_re1, z_re1, indices1, labels1, 'g');
	printText2D_Gabriel(x_re2, z_re2, indices2, labels2, 'b');
	printText2D_Gabriel(x_re3, z_re3, indices3, labels3, 'r');
	
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
	printText2D_Gabriel(y_re1, z_re1, indices1, labels1, 'g');
	printText2D_Gabriel(y_re2, z_re2, indices2, labels2, 'b');
	printText2D_Gabriel(y_re3, z_re3, indices3, labels3, 'r');
	
	% ending of the plot
	scatter(0, 0, 100, 'k', 'filled');
	title(['y-z Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomAlg3, NomTI);
	hold off;
	
	
	%% the closest guys, of the first set of points.
	figure('Name', ['Closest to ' NomAlg1], 'NumberTitle', 'off');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,1);
	out_c = realizations1(:,:,IX1(1));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['TI: ' NomTI ]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,2);
	out_c = realizations1(:,:,IX1(2));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title('closest to TI');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for kk = 1:min(3,fix(num_re1/10))
		subplot(2,3,kk+2);
		out_c = realizations1(:,:,IX1(1+10*kk));
		out1 = imresize(out_c,1/current_resolution); 
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(1+10*kk-1) 'th closest to TI'] );
	end
	% the farthest one...
	subplot(2,3,6);
	out_c = realizations1(:,:,IX1(end));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['Farthest to TI, ' num2str(num_re1-1) '-th']);
	

	%% the closest guys, of the second set of points.
	figure('Name', ['Closest to ' NomAlg2], 'NumberTitle', 'off');
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
	for kk = 1:min(3,fix(num_re2/10))
		subplot(2,3,kk+2);
		out_c = realizations2(:,:,IX2(1+10*kk));
		out1 = imresize(out_c,1/current_resolution);
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(1+10*kk-1) 'th closest to TI'] );
	end
	% the farthest one...
	subplot(2,3,6);
	out_c = realizations1(:,:,IX2(end));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['Farthest to TI, ' num2str(num_re2-1) '-th']);


	%% the closest guys, of the third set of points.
	figure('Name', ['Closest to ' NomAlg3], 'NumberTitle', 'off');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,1);
	out_c = realizations3(:,:,IX3(1));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['TI: ' NomTI ]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	subplot(2,3,2);
	out_c = realizations3(:,:,IX3(2));
	out1 = imresize(out_c,1/current_resolution);
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title('closest to Ti');
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for kk = 1:min(3,fix(num_re3/10))
		subplot(2,3,kk+2);
		out_c = realizations3(:,:,IX3(1+10*kk));
		out1 = imresize(out_c,1/current_resolution);
		level = graythresh(out1);
		out1 = im2bw(out1, level);
		imshow(out1);
		title([int2str(1+10*kk-1) 'th closest to Ti'] );
	end
	% the farthest one...
	subplot(2,3,6);
	out_c = realizations1(:,:,IX3(end));
	out1 = imresize(out_c,1/current_resolution); 
	level = graythresh(out1);
	out1 = im2bw(out1, level);
	imshow(out1);
	title(['Farthest to TI, ' num2str(num_re3-1) '-th']);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
end		% end of for

end		% end of function