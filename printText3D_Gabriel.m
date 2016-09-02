function printText3D_Gabriel(xcoord, ycoord, zcoord, indices, labels, color)
	for i = 1:size(indices, 2)
		text(xcoord(indices(i)), ycoord(indices(i)), zcoord(indices(i)), ['\rightarrow ' num2str((labels(i)))], 'FontSize', 10, 'Color', color);
	end
end