clear all;
%%to exclude the words incens (because 2 sub. did not know
%%its meaning)excl_words=1
excl_words=0; %include all the words
%excl_words=1; %exclude Encens


%get the subject info (name and group)
global sub

% %open the next 4 lines if you want to include 37 sub 
% sub=pm_data_no15_no4_no10;
% load ('dataALL_37sub');
% nANO=[1:17];
% nCON=[18:37];

%open the next 4 lines if you want to include 39 sub 
sub=pm_data_no15;
load ('dataALL_39sub');
nANO=[1:19];
nCON=[20:39];


if excl_words==0
    labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','P�che','Riz','Encens'};
elseif excl_words==1
    labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','P�che','Riz'};
    %labels={'8','9','10','1','3','7','2','5','6','4'};
end

%Set the color for each group
Col_A=[105 170 153]/256; %ANOS
Col_B=[97 94 151]/256;%CONT

%normalized=0; %no
normalized=1; %yes

%Plot  MDS for anosmic
figure();
set(gcf,'color','w'); %to have white background

for isub=nANO
    
    for n_item=1:length(labels)
        a(n_item,1)=dataALL.(sub(isub).name).positions(n_item).x;
        b(n_item,1)=dataALL.(sub(isub).name).positions(n_item).y;
    end
    a=zeros(length(labels),1);
    DSMcmd=[a,b];
    a_all(:,isub)=a;
    b_all(:,isub)=b;
    
end %for isub

set(gcf,'color','w'); %to have white background

a_meanALL=mean(a_all,2);
b_meanALL=mean(b_all,2);

DSMcmd_all=[a_meanALL,b_meanALL];
text(DSMcmd_all((1:length(DSMcmd_all)),1),DSMcmd_all((1:length(DSMcmd_all)),2),labels(1:length(DSMcmd_all)),'Color',Col_A,'FontName','Avenir','FontSize',26,'FontWeight','Bold');
mx=(max(abs(DSMcmd_all(:)))+0.1);
xlim([-0.05 2]); ylim([0 1]);
ax=gca;
set(ax,'FontName','Avenir','FontSize',16, 'FontWeight','bold',...
    'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);

all_ANO=b_all;

clear a_all;
clear b_all;
hold on

pecora=0;%set a counter
for isub=nCON
    
    for n_item=1:length(labels)
        a(n_item,1)=dataALL.(sub(isub).name).positions(n_item).x;
        b(n_item,1)=dataALL.(sub(isub).name).positions(n_item).y;
    end
    a=ones(length(labels),1);
    DSMcmd=[a,b];
    pecora=pecora+1;
    a_all(:,pecora)=a;
    b_all(:,pecora)=b;
    
end %for isub

all_CON=b_all;


a_meanALL=mean(a_all,2);
b_meanALL=mean(b_all,2);

DSMcmd_all=[a_meanALL,b_meanALL];
text(DSMcmd_all((1:length(DSMcmd_all)),1),DSMcmd_all((1:length(DSMcmd_all)),2),labels(1:length(DSMcmd_all)),'Color',Col_B,'FontName','Avenir','FontSize',26,'FontWeight','Bold');
mx=(max(abs(DSMcmd_all(:)))+0.1);
xlim([-0.05 2]); ylim([0 1]);
ax=gca;
set(ax,'FontName','Avenir','FontSize',16, 'FontWeight','bold',...
    'LineWidth',2,'TickDir','out', 'TickLength', [0,0]);



