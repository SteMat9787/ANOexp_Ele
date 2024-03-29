
%load the original DSM in vector shape
load 'DSM_Gr_mean.mat';

labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','ChouxBru','Cigarette','Ammoniac','Fumier','Vin','Poivre','Vanille','Cannelle','Stylo','Assiette','Ville'};

%% Anosmic group
Z = linkage(DSM_AC_mean);
leafOrder = optimalleaforder(Z, DSM_AC_mean);
DSM=squareform(DSM_AC_mean);
DSM_reordered = DSM(leafOrder, leafOrder); % Reorder DSM

% Reorder labels based on leaf order
labels_reordered = labels(leafOrder);

figure();
set(gcf,'color','w');
imagesc(DSM_reordered);
set(colorbar,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
title ('Anosmic Subjects Mean - Neutral Task');
set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels_reordered);
set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels_reordered);
xtickangle(90);
ax=gca;
set(ax,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);
axis square; % Set equal aspect ratio
%% Control group
Z = linkage(DSM_SC_mean);
leafOrder = optimalleaforder(Z, DSM_SC_mean);
DSM=squareform(DSM_SC_mean);
DSM_reordered = DSM(leafOrder, leafOrder); % Reorder DSM

% Reorder labels based on leaf order
labels_reordered = labels(leafOrder);

figure();
set(gcf,'color','w');
imagesc(DSM_reordered);
set(colorbar,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
title ('Control Subjects Mean - Neutral Task');
set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels_reordered);
set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels_reordered);
xtickangle(90);
ax=gca;
set(ax,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);

axis square; % Set equal aspect ratio