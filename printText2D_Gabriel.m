function printText2D_Gabriel(xcoord, ycoord, indices, labels, color)
	for i = 1:size(indices,2)
		text(xcoord(indices(i)),ycoord(indices(i)),['\rightarrow ' num2str((labels(i)))],'FontSize',10,'Color',color);
	end
end