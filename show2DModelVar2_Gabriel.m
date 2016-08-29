function show2DModelVar2_Gabriel(DisMtrx1,DisMtrx2,out,re1,re2)
% this function is used for 2D case

% show the variability of the two sets of realizations
% input: DisMtrx1 is the distance matrix for Dispat realizations
% input: DisMtrx2 is the distance matrix for CCSIM realizations

% input: out is the training image:     e.g. 101*101
% input: re1 is DISPAT realizations:    e.g. 101*101*50
% input: re2 is CCSIM realizations:     e.g. 101*101*50


%% with training image
%% MDS

JS_dispat=DisMtrx1;

JS_CCSIM=DisMtrx2;



n51 = size(DisMtrx1,3);



%% realizations
model_dispat=re1;
model_dispat(:,:,n51)=out;

model_CCSIM=re2;
model_CCSIM(:,:,n51)=out;





S=30*ones(1,n51); S(n51)=120;

% Pyramid is the maximum amount of resolutions that will be worked.
Pyramid = 1;

resolutions=[1,2,3,4,6];
for ii=1:Pyramid
    current_resolution=resolutions(ii);
    
	% Here they do a 3-D Scatter Plot. Let's decypher it:
	% First, start the 'figure' window, and plot the axis...
    figure;
    scatter3(0,0,0, S(n51), 'k','filled');					% Training image plotted!!!
    hold on;
    
	ddd=squeeze(JS_dispat(current_resolution,:,:));
    [Y1_dispat,e_dispat] = cmdscale(double(ddd));
    x_MR=Y1_dispat(:,1); 
    y_MR=Y1_dispat(:,2); 
    z_MR=Y1_dispat(:,3);
    %%
    x_MR=x_MR-x_MR(n51); y_MR=y_MR-y_MR(n51); z_MR=z_MR-z_MR(n51);
    [d1,IX1] = sort(ddd(n51,:));
    scatter3(x_MR,y_MR,z_MR, S, 'g','filled');				% DISPAT plotted!!!
    
    ddd=squeeze(JS_CCSIM(current_resolution,:,:));
    [Y1_CCSIM,e_CCSIM] = cmdscale(double(ddd));
    x_CCSIM=Y1_CCSIM(:,1); 
	y_CCSIM=Y1_CCSIM(:,2); 
    z_CCSIM=Y1_CCSIM(:,3);
    %%
    x_CCSIM=x_CCSIM-x_CCSIM(n51); y_CCSIM=y_CCSIM-y_CCSIM(n51); z_CCSIM=z_CCSIM-z_CCSIM(n51);
    [d2,IX2] = sort(ddd(n51,:));
    scatter3(x_CCSIM,y_CCSIM,z_CCSIM, S,'b','filled');		% CCSIM plotted!!!
    
%     ddd=squeeze(JS_sisim(current_resolution,:,:));
%     [Y1_sisim,e_sisim] = cmdscale(double(squeeze(JS_sisim(current_resolution,:,:))));
%     x_sisim=Y1_sisim(:,1); y_sisim=Y1_sisim(:,2); z_sisim=Y1_sisim(:,3);
%     %
%     x_sisim=x_sisim-x_sisim(n51); y_sisim=y_sisim-y_sisim(n51); z_sisim=z_sisim-z_sisim(n51);
%     [d3,IX3] = sort(ddd(n51,:));
%     %S(IX3(2))=60; S(IX3(21))=60; S(IX3(31))=60; S(IX3(41))=60; S(IX3(n51))=60;
%     scatter3(x_sisim,y_sisim,z_sisim,S,'r','filled');


    scatter3(0,0,0,S(n51),'k','filled');						% Training image re-plotted for visibility!
    legend('Training image','DISPAT','CCSIM');				% Legend...
    title(['Multi Resolution= ' int2str(current_resolution)]);				% etc...
    hold off;
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
    figure;
    S=20*ones(1,n51); S(n51)=100;
    %%%S(IX1(2))=30; S(IX1(21))=30; S(IX1(31))=30; S(IX1(41))=30; S(IX1(n51))=30;
    scatter(x_MR,y_MR,S,'g','filled');
%     text(x_MR(IX1(2)),y_MR(IX1(2)),'\leftarrow 1','FontSize',10);
%     text(x_MR(IX1(21)),y_MR(IX1(21)),'\leftarrow 20','FontSize',10);
%     text(x_MR(IX1(31)),y_MR(IX1(31)),'\leftarrow 30','FontSize',10);
%     text(x_MR(IX1(41)),y_MR(IX1(41)),'\leftarrow 40','FontSize',10);
%     text(x_MR(IX1(n51)),y_MR(IX1(n51)),'\leftarrow 50','FontSize',10);
    hold on;
    %%%S=20*ones(1,n51); S(n51)=100;
    %%%S(IX2(2))=30; S(IX2(21))=30; S(IX2(31))=30; S(IX2(41))=30; S(IX2(n51))=30;
    scatter(x_CCSIM,y_CCSIM,S,'b','filled');
%     text(x_CCSIM(IX2(2)),y_CCSIM(IX2(2)),'\rightarrow 1','FontSize',10,'Color','b');
    %text(x_CCSIM(IX2(21)),y_CCSIM(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
    %text(x_CCSIM(IX2(31)),y_CCSIM(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(41)),y_CCSIM(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(n51)),y_CCSIM(IX2(n51)),'\rightarrow 50','FontSize',10,'Color','b');
%     S=20*ones(1,n51); S(n51)=100;
%     S(IX3(2))=30; S(IX3(21))=30; S(IX3(31))=30; S(IX3(41))=30; S(IX3(n51))=30;
% scatter(x_sisim,y_sisim,S,'r','filled');
% text(x_sisim(IX3(2)),y_sisim(IX3(2)),'\leftarrow 1','FontSize',10,'Color','r');
%     text(x_sisim(IX3(21)),y_sisim(IX3(21)),'\leftarrow 20','FontSize',10,'Color','r');
%     text(x_sisim(IX3(31)),y_sisim(IX3(31)),'\leftarrow 30','FontSize',10,'Color','r');
%     text(x_sisim(IX3(41)),y_sisim(IX3(41)),'\leftarrow 40','FontSize',10,'Color','r');
%     text(x_sisim(IX3(n51)),y_sisim(IX3(n51)),'\leftarrow 50','FontSize',10,'Color','r');
    scatter(0,0,100,'k','filled');
title(['x-y Plot & Multi Scale = ' int2str(current_resolution)]);
legend('DISPAT','CCSIM','Training Image');
hold off;



figure;
S=20*ones(1,n51); S(n51)=100;
    %%%S(IX1(2))=30; S(IX1(21))=30; S(IX1(31))=30; S(IX1(41))=30; S(IX1(n51))=30;
scatter(x_MR,z_MR,S,'g','filled');
% text(x_MR(IX1(2)),z_MR(IX1(2)),'\leftarrow 1','FontSize',10);
% text(x_MR(IX1(21)),z_MR(IX1(21)),'\leftarrow 20','FontSize',10);
% text(x_MR(IX1(31)),z_MR(IX1(31)),'\leftarrow 30','FontSize',10);
% text(x_MR(IX1(41)),z_MR(IX1(41)),'\leftarrow 40','FontSize',10);
% text(x_MR(IX1(n51)),z_MR(IX1(n51)),'\leftarrow 50','FontSize',10);
hold on;
S=20*ones(1,n51); S(n51)=100;
    %%%S(IX2(2))=30; S(IX2(21))=30; S(IX2(31))=30; S(IX2(41))=30; S(IX2(n51))=30;
scatter(x_CCSIM,z_CCSIM,S,'b','filled');
% text(x_CCSIM(IX2(2)),z_CCSIM(IX2(2)),'\rightarrow 1','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(21)),z_CCSIM(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(31)),z_CCSIM(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(41)),z_CCSIM(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
%     text(x_CCSIM(IX2(n51)),z_CCSIM(IX2(n51)),'\rightarrow 50','FontSize',10,'Color','b');
% S=20*ones(1,n51); S(n51)=100;
% S(IX3(2))=30; S(IX3(21))=30; S(IX3(31))=30; S(IX3(41))=30; S(IX3(n51))=30;
% scatter(x_sisim,z_sisim,S,'r','filled');
% text(x_sisim(IX3(2)),z_sisim(IX3(2)),'\leftarrow 1','FontSize',10,'Color','r');
%     text(x_sisim(IX3(21)),z_sisim(IX3(21)),'\leftarrow 20','FontSize',10,'Color','r');
%     text(x_sisim(IX3(31)),z_sisim(IX3(31)),'\leftarrow 30','FontSize',10,'Color','r');
%     text(x_sisim(IX3(41)),z_sisim(IX3(41)),'\leftarrow 40','FontSize',10,'Color','r');
%     text(x_sisim(IX3(n51)),z_sisim(IX3(n51)),'\leftarrow 50','FontSize',10,'Color','r');
    scatter(0,0,100,'k','filled');
title(['x-z Plot & Multi Scale = ' int2str(current_resolution)]);
legend('DISPAT','CCSIM','Training Image');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
S=20*ones(1,n51); S(n51)=100;
% S(IX1(2))=30; S(IX1(21))=30; S(IX1(31))=30; S(IX1(41))=30; S(IX1(n51))=30;
scatter(y_MR,z_MR,S,'g','filled');
% text(y_MR(IX1(2)),z_MR(IX1(2)),'\leftarrow 1','FontSize',10);
%     text(y_MR(IX1(21)),z_MR(IX1(21)),'\leftarrow 20','FontSize',10);
%     text(y_MR(IX1(31)),z_MR(IX1(31)),'\leftarrow 30','FontSize',10);
%     text(y_MR(IX1(41)),z_MR(IX1(41)),'\leftarrow 40','FontSize',10);
%     text(y_MR(IX1(n51)),z_MR(IX1(n51)),'\leftarrow 50','FontSize',10);
hold on;
S=20*ones(1,n51); S(n51)=100;
%     S(IX2(2))=30; S(IX2(21))=30; S(IX2(31))=30; S(IX2(41))=30; S(IX2(n51))=30;
scatter(y_CCSIM,z_CCSIM,S,'b','filled');
% text(y_CCSIM(IX2(2)),z_CCSIM(IX2(2)),'\rightarrow 1','FontSize',10,'Color','b');
%     text(y_CCSIM(IX2(21)),z_CCSIM(IX2(21)),'\rightarrow 20','FontSize',10,'Color','b');
%     text(y_CCSIM(IX2(31)),z_CCSIM(IX2(31)),'\rightarrow 30','FontSize',10,'Color','b');
%     text(y_CCSIM(IX2(41)),z_CCSIM(IX2(41)),'\rightarrow 40','FontSize',10,'Color','b');
%     text(y_CCSIM(IX2(n51)),z_CCSIM(IX2(n51)),'\rightarrow 50','FontSize',10,'Color','b');
% S=20*ones(1,n51); S(n51)=100;
%     S(IX3(2))=30; S(IX3(21))=30; S(IX3(31))=30; S(IX3(41))=30; S(IX3(n51))=30;
% scatter(y_sisim,z_sisim,S,'r','filled');
% text(y_sisim(IX3(2)),z_sisim(IX3(2)),'\rightarrow 1','FontSize',10,'Color','b');
%     text(y_sisim(IX3(21)),z_sisim(IX3(21)),'\rightarrow 20','FontSize',10,'Color','b');
%     text(y_sisim(IX3(31)),z_sisim(IX3(31)),'\rightarrow 30','FontSize',10,'Color','b');
%     text(y_sisim(IX3(41)),z_sisim(IX3(41)),'\rightarrow 40','FontSize',10,'Color','b');
%     text(y_sisim(IX3(n51)),z_sisim(IX3(n51)),'\rightarrow 50','FontSize',10,'Color','b');
scatter(0,0,100,'k','filled');
title(['y-z Plot & Multi Scale = ' int2str(current_resolution)]);
legend('DISPAT','CCSIM','Training Image');
hold off; 


%% find the corresponding models in the scatter plots


out_c=model_dispat(:,:,IX1(1));
    out1 = imresize(out_c,1/current_resolution); 
    level = graythresh(out1);
    out1 = im2bw(out1, level);

	
%%%%%%%%%%%%%%%%%%%%%%  FIGURE [2,3,1]
% figure;
% subplot(2,3,1)
% imshow(out1);
% title(['Ti, DISPAT, MR=' int2str(current_resolution)]);
% subplot(2,3,2)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_dispat(:,:,IX1(2));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(out1);
% title('closest to Ti');
% for kk=1:4
%     subplot(2,3,kk+2)
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_dispat(:,:,IX1(11+10*kk));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     imshow(out1);
%     title([int2str(11+10*kk-1) 'th closest to Ti'] );
% end


%%
%%%%%%%%%%%%%%%%%%%%%%  FIGURE [2,3,1]
% figure;
% subplot(2,3,1)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_CCSIM(:,:,IX2(1));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(out1);
% title(['Ti, CCSIM, MR=' int2str(current_resolution)]);
% subplot(2,3,2)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_CCSIM(:,:,IX2(2));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(out1);
% title('closest to Ti');
% for kk=1:4
%     subplot(2,3,kk+2)
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_CCSIM(:,:,IX2(11+10*kk));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     imshow(out1);
%     title([int2str(11+10*kk-1) 'th closest to Ti'] );
% end



%%
% figure;
% subplot(2,3,1)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_sisim(:,:,IX3(1));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(out1);
% title(['Ti, SISIM, MR=' int2str(current_resolution)]);
% subplot(2,3,2)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_sisim(:,:,IX3(2));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(out1);
% title('closest to Ti');
% for kk=1:4
%     subplot(2,3,kk+2)
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% out_c=model_sisim(:,:,IX3(11+10*kk));
%     out1 = imresize(out_c,1/current_resolution); 
%     level = graythresh(out1);
%     out1 = im2bw(out1, level);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     imshow(out1);
%     title([int2str(11+10*kk-1) 'th closest to Ti'] );
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



size_dispatE=size(Y1_dispat,2);
size_CCSIME=size(Y1_CCSIM,2);
% size_sisimE=size(Y1_sisim,2);
for k=1:size_dispatE
    e_dispat_new(k)=sum(e_dispat(1:k))/sum(e_dispat(1:size_dispatE)); 
end
for k=1:size_CCSIME
    e_CCSIM_new(k)=sum(e_CCSIM(1:k))/sum(e_CCSIM(1:size_CCSIME));
end
% for k=1:size_sisimE
%     e_sisim_new(k)=sum(e_sisim(1:k))/sum(e_sisim(1:size_sisimE));
% end


%%%%%%%%%%%%%%%%%%%%%%% 
figure;
plot(e_dispat_new,'k');
%text(3,e_dispat_new(3),num2str(e_dispat_new(3)));
hold on;
plot(e_CCSIM_new,'b');
%text(3,e_CCSIM_new(3),num2str(e_CCSIM_new(3)));
% plot(e_sisim_new,'r');
%text(3,e_sisim_new(3),num2str(e_sisim_new(3)));
xlabel('Dimension');
ylabel('Cumulative');
legend(['DISPAT ' num2str(e_dispat_new(3))],['CCSIM ' num2str(e_CCSIM_new(3))],'Location', 'SouthEast');
title(['Multi Resolution= ' int2str(current_resolution)]);
hold off;

end



end
