load 'drag_rate_allSUB_siENCENS_39sub_DSMvec_All_words.mat';
    labels={'LOW','MIDDLE','HIGH'};
    labels_all = {'Assiette','Pierre','Aluminium','Riz',...
    'Miel','Pêche','Gazon',...
    'Menthe','Lavande','Chlore','Encens'}';
meanCON_dsm=squareform(Mean_CON);
meanANO_dsm=squareform(Mean_ANO);

%%%To visualize the matrices
 clims=[0 1.4];
figure();
subplot(3,2,1); imagesc((meanCON_dsm),clims); colorbar;
% set(gca, 'YTick',(3.5:6:30),'YTickLabel',labels);
% set(gca, 'XTick',(3.5:6:30),'XTickLabel',labels);
set(gca, 'YTick',1:length(labels_all),'YTickLabel',labels_all);
set(gca, 'XTick',1:length(labels_all),'XTickLabel',labels_all);
 title 'CON'
subplot(3,2,2); imagesc((meanANO_dsm),clims); colorbar;
% set(gca, 'YTick',(3.5:6:30),'YTickLabel',labels);
% set(gca, 'XTick',(3.5:6:30),'XTickLabel',labels);
set(gca, 'YTick',1:length(labels_all),'YTickLabel',labels_all);
set(gca, 'XTick',1:length(labels_all),'XTickLabel',labels_all);
 title 'ANO'


%CMD visualization

% CON=cmdscale(CONmean);
CON=cmdscale(meanCON_dsm);
ANO=cmdscale(meanANO_dsm);


%CON
subplot(3,2,3);
title('CON');
text(CON((1:4),1),CON((1:4),3),labels_all(1:4),'Color',[0,0,1],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
text(CON((5:7),1),CON((5:7),3),labels_all(5:7),'Color',[0,0.8,1],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
text(CON((8:11),1),CON((8:11),3),labels_all(8:11),'Color',[1,0.4,0],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
% text(CON((19:24),1),CON((19:24),2),labels(4),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((25:30),1),CON((25:30),2),labels(5),'Color',[0,1,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');

mx=(max(abs(CON(:)))+0.1);
xlim([-mx mx]); ylim([-mx mx]);
%CAT
subplot(3,2,4);
title('ANO');
text(ANO((1:4),1),ANO((1:4),2),labels_all(1:4),'Color',[0,0,1],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
text(ANO((5:7),1),ANO((5:7),2),labels_all(5:7),'Color',[0,0.8,1],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
text(ANO((8:11),1),ANO((8:11),2),labels_all(8:11),'Color',[1,0.4,0],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
% text(ANO((19:24),1),ANO((19:24),2),labels(4),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(ANO((25:30),1),ANO((25:30),2),labels(5),'Color',[0,1,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');

mx=(max(abs(ANO(:)))+0.1);
xlim([-mx mx]); ylim([-mx mx]);


% %CON
% subplot(3,3,4);
% title('CON');
% text(CON((1:3),1),CON((1:3),2),labels(1),'Color',[0,0,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((4:6),1),CON((4:6),2),labels(2),'Color',[0,0,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((7:9),1),CON((7:9),2),labels(3),'Color',[0,0.8,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((10:12),1),CON((10:12),2),labels(4),'Color',[0,0.8,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((13:15),1),CON((13:15),2),labels(5),'Color',[1,0.4,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((16:18),1),CON((16:18),2),labels(6),'Color',[1,0.4,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((19:21),1),CON((19:21),2),labels(7),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CON((22:24),1),CON((22:24),2),labels(8),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% mx=(max(abs(CON(:)))+0.1);
% xlim([-mx mx]); ylim([-mx mx]);
% %CAT
% subplot(3,3,5);
% title('CAT');
% text(CAT((1:3),1),CAT((1:3),2),labels(1),'Color',[0,0,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((4:6),1),CAT((4:6),2),labels(2),'Color',[0,0,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((7:9),1),CAT((7:9),2),labels(3),'Color',[0,0.8,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((10:12),1),CAT((10:12),2),labels(4),'Color',[0,0.8,1],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((13:15),1),CAT((13:15),2),labels(5),'Color',[1,0.4,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((16:18),1),CAT((16:18),2),labels(6),'Color',[1,0.4,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((19:21),1),CAT((19:21),2),labels(7),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(CAT((22:24),1),CAT((22:24),2),labels(8),'Color',[1,0.8,0],'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% mx=(max(abs(CAT(:)))+0.1);
% xlim([-mx mx]); ylim([-mx mx]);


%%dendrogram visualization

ColorTreshold=0.7; %default is 0.7
Reorder=[];
%CON
CONdend=linkage(squareform(meanCON_dsm));%,'single','spearman');
subplot(3,2,5);
H=dendrogram(CONdend,'Reorder',Reorder,'labels',labels_all,'orientation','left','ColorThreshold',ColorTreshold * max(CONdend(:,3)));
title('CON');
set(H,'LineWidth',2)
%CAT
ANOdend=linkage(squareform(meanANO_dsm));
subplot(3,2,6);
H= dendrogram(ANOdend,'Reorder',Reorder,'labels',labels_all,'orientation','left','ColorThreshold',ColorTreshold * max(ANOdend(:,3)));
title('ANO');
set(H,'LineWidth',2)



