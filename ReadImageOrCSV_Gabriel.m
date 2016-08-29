function image = ReadImageOrCSV_Gabriel(filePath)
	isCSV = strcmpi(filePath(end-2:end), 'csv'); % Compare strings ignoring case.
	eend = filePath(end-4:end);
	isSGEMS = strcmpi(eend, 'sgems'); % Compare strings ignoring case.
	
	if(isCSV) % Verify that this file filePath corresponds to a CSV file
		image = csvread(filePath);
		return;
	elseif(isSGEMS)
		image = read_eas_sq(filePath);		% read the TI
		return;
		
	else % If this file filePath is an image file, read it. Else, throw error.
		imfinfo(filePath);
		image = im2double(imread(filePath));
	end