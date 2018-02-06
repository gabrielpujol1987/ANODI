function realizations1 = load_folder_Gabriel(path1)

	%% For the current folder, filter the files:
    theFiles = dir(fullfile(path1));
	theFiles = theFiles(~([theFiles.isdir] == 1));
    numFiles = size(theFiles,1);
    
    %% Getting the resolution for the first image in the set.
	tempImg = ReadImageOrCSV_Gabriel(fullfile(path1, theFiles(1).name));
	[resolutionX, resolutionY, ~] = size(tempImg);
	    
    %% Creating the data structure for the images, and setting the first:
    realizations1 = zeros (resolutionX, resolutionY, numFiles);
    realizations1(:,:,1) = tempImg(:,:,1);
    
    %% Loading the image files into the data structure:
    for i=2:numFiles
        tempImg = ReadImageOrCSV_Gabriel(fullfile(path1, theFiles(i).name));
        realizations1(:,:,i) = tempImg(:,:,1);
    end

end

