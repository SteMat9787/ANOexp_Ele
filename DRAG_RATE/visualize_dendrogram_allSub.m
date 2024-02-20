load 'drag_rate_allSUB_siENCENS_39sub_DSMvec_All_words.mat';
    labels={'LOW','MIDDLE','HIGH'};
    labels_all = {'Assiette','Pierre','Aluminium','Riz',...
    'Miel','Pêche','Gazon',...
    'Menthe','Lavande','Chlore','Encens'}';
%define the number of subject in each group
nANO=19;
nCON=20;

meanCON_dsm=squareform(Mean_CON);
meanANO_dsm=squareform(Mean_ANO);

%% start the loop for each CON subject
figure();
set(gcf,'color','w');
for isub=1:nCON
    
    %extract the vector for this sub
    SUB_vec=All_vec_norm_CON(isub,:);
    %create the matrix DSM for this sub
    SUB_dsm=squareform(SUB_vec);
    
%%dendrogram visualization

ColorTreshold=0.8; %default is 0.7
Reorder=[];
%CON
CONdend=linkage(squareform(SUB_dsm));%,'single','spearman');
subplot(4,5,isub);
H=dendrogram(CONdend,'Reorder',Reorder,'labels',labels_all,'orientation','left','ColorThreshold',ColorTreshold * max(CONdend(:,3)));
title(strcat ('SUB-',num2str(isub)));
set(H,'LineWidth',2)
end
%set the main title of the figure
suptitle('CON');

%% start the loop for each ANO subject
 figure();
 set(gcf,'color','w');
for isub=1:nANO
   
    %extract the vector for this sub
    SUB_vec=All_vec_norm_ANO(isub,:);
    %create the matrix DSM for this sub
    SUB_dsm=squareform(SUB_vec);
    
%%dendrogram visualization

ColorTreshold=0.8; %default is 0.7
Reorder=[];
%CON
ANOdend=linkage(squareform(SUB_dsm));%,'single','spearman');
subplot(4,5,isub);
H=dendrogram(ANOdend,'Reorder',Reorder,'labels',labels_all,'orientation','left','ColorThreshold',ColorTreshold * max(ANOdend(:,3)));
title(strcat ('SUB-',num2str(isub)));
set(H,'LineWidth',2)
end
%set the main title of the figure
suptitle('ANO');

