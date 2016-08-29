function DistMtrx = calculateModelVar_CHP_Gabriel(realization1,out, tempSize)
    % input: realization1 is all the realizations needed: e.g.101*101*50
    % input: out is the training image
    % input: tempSize is the optimal size of template for training image
    % output: DistMtrx: e.g. 10*51*51 (10 is the level of Pyramid)

	training_image_original=out;
    realizations = realization1;
    num_realizations = size(realizations,3);

    parS.clus = 50;

	% Gabriel: I'm only trying a single resolution, the original one.
    Pyramid = 1;% 3;	

    DS = zeros(Pyramid, num_realizations+1, num_realizations+1);



HHH_SGSIM=zeros(Pyramid,parS.clus,num_realizations+1);
% pts=zeros(Pyramid,parS.clus,23*23);

for myResolution=1:Pyramid
    
    
    
    training_image_resized = imresize(training_image_original,1/myResolution);
    
    % Visualize data
    nxS = size(training_image_resized,1);
    nyS = size(training_image_resized,2);
    nzS = 1;
    
    % Dimensions
    parS.multipleGrid = 1;
    parS.m1 = 1;
    parS.MDS = 20;
    
	% scaling every one of the realizations into the current resolution.
    for ii=1:num_realizations
        scaled_realizations(:,:,ii)=imresize(realizations(:,:,ii),1/myResolution);
    end

    %reaS = reshape(realizations,[nxS,nyS,nzS,num_realizations]);
    reaS = reshape(scaled_realizations,[nxS,nyS,nzS,num_realizations]);
    
    %
    clear scaled_realizations;
    %
    parS.Patx = tempSize;
    parS.Paty = tempSize;
    parS.Patz = 1;
    %parS.mx = parS.Patx;
    %parS.my = parS.Paty;
    %parS.mz = parS.Patz;
    parS.mx=4;
    parS.my=4;
    parS.mz=1;
    parS.Dimx = nxS;
    parS.Dimy = nyS;
    parS.Dimz = nzS;
    
    
    % Classify patterns
    [XS, YS, eS, ~, idxS, prototypeS, MDSS] = MYclassifyPatterns(training_image_resized, parS);
    parS.clus = size(prototypeS,1);
    
    % Bulid the histogram of training image
    hh=zeros(parS.clus,1);
    for iii = 1:size(idxS,1)
        hh(idxS(iii))=hh(idxS(iii))+1;
    end
    
    % Dispaly the prototypes and its counts
%     figure;
%     for mm=1:parS.clus
%         
%         subplot(7,7,mm)
%         pt=reshape(prototypeS(mm,:),[parS.Patx,parS.Paty]);
%         imshow(pt);
%         colormap('jet');
% %         title(['Ti, myResolution=' int2str(myResolution), ' Count=', int2str(hh(mm))]);
%         title(int2str(hh(mm)));
%     end
    
    % Build the clustered histograms
    HS = zeros(parS.clus,num_realizations+1);

    parS.mx = 1;
    parS.my = 1;
    parS.mz = 1;

    for i = 1:num_realizations
        [HS(:,i), npatS] = CompHistRea(reaS(:,:,i), prototypeS, parS);
%         figure;
%         for mm=1:parS.clus
%         
%             subplot(7,7,mm)
%             pt=reshape(prototypeS(mm,:),[parS.Patx,parS.Paty]);
%             imshow(pt);
%             colormap('jet');
%      title(['re', int2str(i), 'myResolution=' int2str(myResolution), ' Count=', int2str(HS(mm,i))]);
%         end
    end
    HS(:,num_realizations+1) = hh;
    NClust=size(HS,1);
    HHH_SGSIM(myResolution,1:NClust,:)=HS;
    % Store prototypeS
%     pts(myResolution,1:NClust,:)=prototypeS;
    
    % Compute distances between clustered histograms of models
    
    %for myResolutionT=1:Pyramid
        for i = 1:num_realizations+1
            for j = i+1:num_realizations+1     
                %DS(i,j) = ChiDist(HS(:,i), HS(:,j), npatS, npatS);
                DS(myResolution,i,j) = JSDist(HS(:,i), HS(:,j));
                DS(myResolution,j,i) = DS(myResolution,i,j);
            end
        end 
    %end
    
    
end


JS_Pyramid2=DS;
%save('JS_sisim_myResolution.mat', 'JS1_sisim','JS2_sisim','JS3_sisim');
% save('JS_SGSIM260MV_cont.mat', 'JS_Pyramid2','HHH_SGSIM');
DistMtrx=JS_Pyramid2;
end