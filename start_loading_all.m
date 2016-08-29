function [TI, realizations1, realizations2, realizations3, DistMtrx1, DistMtrx2, DistMtrx3] = start_loading_all()

extension = '*.bmp';
templateSize = 20;  % Initially, 20 is what they say in the paper!

pathTI = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\strebelle 101x101 BW.bmp';
TI = imread(pathTI);

path1 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A1';
path2 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A2';
path3 = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\!ANODI!\ComparingGSAlgorithms\DataG\A3';

realizations1 = load_folder_Gabriel(path1, extension);
realizations2 = load_folder_Gabriel(path2, extension);
realizations3 = load_folder_Gabriel(path3, extension);

% AND HERE IT COMES!!!!!!
DistMtrx1 = calculateModelVar_CHP_Gabriel(realizations1, TI, templateSize);
DistMtrx2 = calculateModelVar_CHP_Gabriel(realizations2, TI, templateSize);
DistMtrx3 = calculateModelVar_CHP_Gabriel(realizations3, TI, templateSize);

end