
sourcePath = '';
destinationPath = '';

images = ReadImageOrCSV_Gabriel(sourcePath);
numFiles = size(images,3);

for i=1:numFiles
    imwrite(images(:,:,i), [destinationPath 'Image_' num2str(i) '.jpg']);
end