%%exclude the word encens (because 2 sub. did not know
%%their meaning)
excl_words=0; %include all the words
%excl_words=1; %exclude word encens


%get the subject info (name and group)
global sub
sub=pm_data_no15;

load ('dataALL_39sub');
if excl_words==0
% labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','Pêche','Riz','Encens'};
labels={'8','9','10','1','3','7','2','5','6','4','11'};
elseif excl_words==1
%  labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','Pêche','Riz'};
labels={'8','9','10','1','3','7','2','5','6','4'};
end

%Encens==10
%Set the color for each group
    Col_A=[105 170 153]/256; %ANOS
    Col_B=[97 94 151]/256;%CONT

%normalized=0; %no
normalized=1; %yes

%Plot  MDS for anosmic
figure();
set(gcf,'color','w'); %to have white background

for isub=[1:19]
    
     for n_item=1:length(labels)
     a(n_item,1)=dataALL.(sub(isub).name).positions(n_item).x;
     b(n_item,1)=dataALL.(sub(isub).name).positions(n_item).y;
     end
     
     subplot(1,19,isub);
     DSMcmd_sub=[a,b];
text(DSMcmd_sub((1:length(DSMcmd_sub)),1),DSMcmd_sub((1:length(DSMcmd_sub)),2),labels(1:length(DSMcmd_sub)),'Color',Col_A,'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
mx=(max(abs(DSMcmd_sub(:)))+0.1);
xlim([-0.05 1]); ylim([0 1]);
ax=gca;
% if isub==1
     set(ax,'FontName','Avenir','FontSize',1, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
% else
%          set(ax,'XTickLabel','','YTickLabel','','FontName','Avenir','FontSize',1, 'FontWeight','bold',...
%         'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
% end

     a=zeros(length(labels),1);
     DSMcmd=[a,b];
      a_all(:,isub)=a;
      b_all(:,isub)=b;
 
end %for isub
     


% a_meanALL=mean(a_all,2);
% b_meanALL=mean(b_all,2);
% 
% DSMcmd_all=[a_meanALL,b_meanALL];
% text(DSMcmd_all((1:length(DSMcmd_all)),1),DSMcmd_all((1:length(DSMcmd_all)),2),labels(1:length(DSMcmd_all)),'Color',Col_A,'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% % text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% % text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% mx=(max(abs(DSMcmd_all(:)))+0.1);
% xlim([-0.05 2]); ylim([0 1]);
% ax=gca;
%          set(ax,'FontName','Avenir','FontSize',16, 'FontWeight','bold',...
%         'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
%           
% all_ANO=b_all;     
     
clear a_all;
clear b_all;
% hold on
    %Plot  MDS for controls
% figure();
% set(gcf,'color','w'); %to have white background
figure();
set(gcf,'color','w'); %to have white background
pecora=0;
for isub=[20:39]
    
     for n_item=1:length(labels)
     a(n_item,1)=dataALL.(sub(isub).name).positions(n_item).x;
     b(n_item,1)=dataALL.(sub(isub).name).positions(n_item).y;
     end
     
        subplot(1,20,isub-19);
     DSMcmd_sub=[a,b];
text(DSMcmd_sub((1:length(DSMcmd_sub)),1),DSMcmd_sub((1:length(DSMcmd_sub)),2),labels(1:length(DSMcmd_sub)),'Color',Col_B,'FontName','Avenir','FontSize',26,'FontWeight','Bold');
% text(DSMcmd((4:6),1),DSMcmd((4:6),2),labels(4:6),'Color',[[153,115,222]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
% text(DSMcmd((7:9),1),DSMcmd((7:9),2),labels(7:9),'Color',[[90,166,128]/256],'FontName','Avenir','FontSize',10,'FontWeight','Bold');
mx=(max(abs(DSMcmd_sub(:)))+0.1);
xlim([-0.05 1]); ylim([0 1]);
ax=gca;
         if isub==20
     set(ax,'FontName','Avenir','FontSize',1, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
else
         set(ax,'XTickLabel','','YTickLabel','','FontName','Avenir','FontSize',1, 'FontWeight','bold',...
        'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);
end
     
       a=ones(length(labels),1);
     DSMcmd=[a,b];
     pecora=pecora+1;
      a_all(:,pecora)=a;
      b_all(:,pecora)=b;
    
end %for isub
     

