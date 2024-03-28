%get the subject info (name and group)
global sub
sub=pm_data; 
%excl_words=0 %include all the words
excl_words=1; %exclude words ammoniac and cannelle


load ('dataALL_40sub');

if excl_words==0
labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Ammoniac','Fumier','Vin','Poivre','Vanille','Cannelle','Stylo','Assiette','Ville'};
elseif excl_words==1
 labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Fumier','Vin','Poivre','Vanille','Stylo','Assiette','Ville'};
end
method=1; %using function cmdscale
% method=2; %using data position from output (these positions are something else, don't use it!) 
%Plot  DSM for anosmic
figure();
set(gcf,'color','w'); %to have white background
for isub=1:20
    DSM=dataALL.(sub(isub).name).rdm;
    if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
%     if method==1
    DSMcmd= cmdscale(squareform(DSM));
%     elseif method ==2
%     for n_item=1:length(labels)
%      a(n_item,1)=dataALL.(sub(isub).name).trials.positions(n_item).x;
%      b(n_item,1)=dataALL.(sub(isub).name).trials.positions(n_item).y;
%      DSMcmd=[a,b];
%     end
%     end %if 
    
    subplot(5,4,isub);
title (strcat('AC SUB n',num2str(isub)));
text(DSMcmd((1:length(DSMcmd)),1),DSMcmd((1:length(DSMcmd)),2),labels(1:length(DSMcmd)),'Color',[0 0 0],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
mx=(max(abs(DSMcmd(:)))+0.1);
xlim([-mx mx]); ylim([-mx mx]);
ax=gca;
         set(ax,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
end %for isub

%Plot  DSM for controls
figure();
set(gcf,'color','w'); %to have white background
for isub=21:40
    DSM=dataALL.(sub(isub).name).rdm;
    if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
    DSMcmd= cmdscale(squareform(DSM));
    subplot(5,4,isub-20);
title (strcat('CS SUB n',num2str(isub-20)));
text(DSMcmd((1:length(DSMcmd)),1),DSMcmd((1:length(DSMcmd)),2),labels(1:length(DSMcmd)),'Color',[0 0 0],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((1:3),1),DSMcmd((1:3),2),labels(1:3),'Color',[[237,153,15]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
mx=(max(abs(DSMcmd(:))));
xlim([-mx mx]); ylim([-mx mx]);
ax=gca;
         set(ax,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
end %for isub


%plot Gr mean
load ('DSM_Gr_mean.mat');

%Anosmic Group
figure();
set(gcf,'color','w'); %to have white background
DSM=DSM_AC_mean;
if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
DSMcmd= cmdscale(squareform(DSM));
title ('MDS Anosmic Group - OLFA TASK');
text(DSMcmd((1:length(DSMcmd)),1),DSMcmd((1:length(DSMcmd)),2),labels(1:length(DSMcmd)),'Color',[0 0 0],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
% text(DSMcmd((1:3),1),DSMcmd((1:3),2),labels(1:3),'Color',[[237,153,15]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% mx=(max(abs(DSMcmd(:))));
% xlim([-mx mx]); ylim([-mx mx]);
xlim ([-0.6 +0.6]); ylim([-0.6 +0.6]);
ax=gca;
         set(ax,'FontName','Avenir','FontSize',20, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
    
    %Control Group
    figure();
    set(gcf,'color','w'); %to have white background
DSM=DSM_SC_mean;
if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
DSMcmd= cmdscale(squareform(DSM));
title ('MDS Control Group - OLFA TASK');
text(DSMcmd((1:length(DSMcmd)),1),DSMcmd((1:length(DSMcmd)),2),labels(1:length(DSMcmd)),'Color',[0 0 0],'FontName','Avenir','FontSize',20,'FontWeight','Bold');
% text(DSMcmd((1:3),1),DSMcmd((1:3),2),labels(1:3),'Color',[[237,153,15]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% mx=(max(abs(DSMcmd(:))));
% xlim([-mx mx]); ylim([-mx mx]);
xlim ([-0.6 +0.6]); ylim([-0.6 +0.6]);
ax=gca;
         set(ax,'FontName','Avenir','FontSize',20, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);