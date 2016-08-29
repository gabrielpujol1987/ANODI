function show2DModelVar2_Gabriel_Separated(DisMtrx1, DisMtrx2, TrainigImage, re1, re2, NomTI, NomAlg1, NomAlg2)
% this function is used for 2D case

% show the variability of the two sets of realizations
% input: DisMtrx1 is the distance matrix for Algorithm1 realizations
% input: DisMtrx2 is the distance matrix for Algorithm2 realizations

% input: TrainigImage is the training image:	e.g. 101*101
% input: re1 is Algorithm1 realizations: 		e.g. 101*101*50
% input: re2 is Algorithm2 realizations:		e.g. 101*101*50


% NomAlg1 = 'Algorithm1';
% NomAlg2 = 'Algorithm2';


% the amount of realizations from each algorithm.
num_re1 = size(DisMtrx1, 3);
num_re2 = size(DisMtrx2, 3);


% The scales of the points to be plotted for each algorithm.
standardScale = 20;	mediumScale = 30;	 bigScale = 100;
S1 = standardScale*ones(1, num_re1); S(num_re1) = bigScale;
S2 = standardScale*ones(1, num_re2); S(num_re2) = bigScale;

	
%% Including the Training Image into the collections of Realizations
% realizations1 = re1;
% realizations1(:, :, num_re1) = TrainigImage;
% realizations2 = re2;
% realizations2(:, :, num_re2) = TrainigImage;



%% Pyramid is the maximum amount of resolutions that will be worked.
Pyramid = 1;
resolutions = [1, 2, 3, 4, 6];

for ii = 1:Pyramid
	%% starting the plot, for each resolution:
	current_resolution=resolutions(ii);
	% Here they do a 3-D Scatter Plot. Let's decypher it:
	% First, start the 'figure' window, and then plot the axis...
	figure('Name', 'Tridimensional plot', 'NumberTitle', 'off');
	scatter3(0, 0, 0, S(num_re1), 'k', 'filled');
	hold on;
	
	%% WORKING WITH THE FIRST DISTANCE MATRIX!!!
	% set ddd to the DisMatrix corresponding to the current resolution
	ddd=squeeze(DisMtrx1(current_resolution, :, :));
		
	% get the new Coordinates for the n points in a new p-dimensional space
	% along with the EigenValues (first k are positive if matrix euclidean)
	[Y1_re1, ~] = cmdscale(double(ddd)); % e_re1
	
	% get the new coordinates for every point, for plotting reasons...
	x_re1 = Y1_re1(:, 1);
	y_re1 = Y1_re1(:, 2);
	z_re1 = Y1_re1(:, 3);
	% Centering the coordinates around the Training Image:
	x_re1 = x_re1 - x_re1(num_re1);
	y_re1 = y_re1 - y_re1(num_re1);
	z_re1 = z_re1 - z_re1(num_re1);
	
	% Positions of the 'sorted' list, according to the distances to the TI
	[~, IX1] = sort(ddd(num_re1, :));
	
	scatter3(x_re1, y_re1, z_re1, S1, 'g', 'filled');		% FIRST DATA PLOTTED!!!
	
	%% WORKING WITH THE SECOND DISTANCE MATRIX!!!
	% set ddd to the DisMatrix corresponding to the current resolution
	ddd=squeeze(DisMtrx2(current_resolution, :, :));
	% get the new Coordinates for the n points in a new p-dimensional space
	% along with the EigenValues (first k are positive if matrix euclidean)
	[Y1_re2, ~] = cmdscale(double(ddd)); % e_re2
	
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
	
	scatter3(x_re2, y_re2, z_re2, S2, 'b', 'filled');	% SECOND DATA PLOTTED!!!
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	%% PLOTTING THE LEGEND!!!
	scatter3(0, 0, 0, S(num_re1), 'k', 'filled');						% Training image re-plotted for visibility!
	legend(NomTI, NomAlg1, NomAlg2);				% Legend...
	title(['Multi Resolution= ' int2str(current_resolution)]);				% etc...
	hold off; % end of plotting the 3-D graphic.
	
	
	%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	% X-Y Plot!!!
	figure('Name', 'X-Y Plot', 'NumberTitle', 'off');
	scatter(x_re1, y_re1, S1, 'g', 'filled');
	hold on;
	scatter(x_re2, y_re2, S2, 'b', 'filled');
	
	% Code for the distinction for every i-th data plotted
	S1(IX1( 2)) = mediumScale;			% the closest
	S1(IX1( 4)) = mediumScale;			% the 3rd closest
% 	S1(IX1(11)) = mediumScale;			% the 10th closest
% 	S1(IX1(21)) = mediumScale;			% the 20th closest
	S1(IX1(num_re1)) = mediumScale;	% the farthest
	
	text(x_re1(IX1( 2)), y_re1(IX1( 2)), '\rightarrow  1', 'FontSize', 10, 'Color', 'b');
	text(x_re1(IX1( 4)), y_re1(IX1( 4)), '\rightarrow  3', 'FontSize', 10, 'Color', 'b');
% 	text(x_re1(IX1(11)), y_re1(IX1(11)), '\rightarrow 10', 'FontSize', 10, 'Color', 'b');
% 	text(x_re1(IX1(21)), y_re1(IX1(21)), '\rightarrow 20', 'FontSize', 10, 'Color', 'b');
	text(x_re1(IX1(num_re1)), y_re1(IX1(num_re1)), ['\rightarrow ' num2str(num_re1)], 'FontSize', 10, 'Color', 'b');
	
	
	scatter(0, 0, 100, 'k', 'filled');
	title(['x-y Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomTI);
	hold off;
	
	
	
	% X-Z Plot!!!
	figure('Name', 'X-Z Plot', 'NumberTitle', 'off');
	scatter(x_re1, z_re1, S1, 'g', 'filled');
	hold on;
	scatter(x_re2, z_re2, S2, 'b', 'filled');
	
	scatter(0, 0, 100, 'k', 'filled');
	title(['x-z Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomTI);
	hold off;
	
	
	
	% Y-Z Plot!!!
	figure('Name', 'Y-Z Plot', 'NumberTitle', 'off');
	scatter(y_re1, z_re1, S1, 'g', 'filled');
	hold on;
	scatter(y_re2, z_re2, S2, 'b', 'filled');
	
	scatter(0, 0, 100, 'k', 'filled');
	title(['y-z Plot & Multi Scale = ' int2str(current_resolution)]);
	legend(NomAlg1, NomAlg2, NomTI);
	hold off;
	
	
end	 % for ii=1:Pyramid

end