function result = BlackAndWhite_Gabriel(imageMatrix, tolerance)

	if(nargin == 1)
		tolerance = 0.8;
	end

	result = zeros(size(imageMatrix, 1), size(imageMatrix, 2));
	
	red = imageMatrix(:,:,1);
	green = imageMatrix(:,:,2);
	blue = imageMatrix(:,:,3);

	for i = 1:size(result, 1)
		for j = 1:size(result, 2)
			result(i,j) = Filter_BW(red(i,j), green(i,j), blue(i,j), tolerance);
		end
	end
	
	
end

function outputt = Filter_BW (red, green, blue, tolerance)

	if(red > tolerance || green > tolerance || blue > tolerance) 
		outputt = 1;
	else
		outputt = 0;
	end

end