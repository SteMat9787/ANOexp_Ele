clear all

%%Script to create RDM - Representational Dissimilarity matrices based on
%%the olfactoory valence of the words

%load here the correct file based on which DSM you want to create
%IMPORTANT: the sub 15 of ANO group is always excluded because he/she did
%not perform correctly the task (all words around 0)

load drag_rate_39SUB_allWords % for a DSM including 39 subject
% load drag_rate_37SUB_allWords % for a DSM including 37 subject (sub 4 and 10 excluded because they did not know the meaning of encens) and all 11 words

%transpose the values from raws to col
all_CON_t=all_CON';
all_ANO_t=all_ANO';

%select from 1 to 11 if you want to include Encens, from 1 to 10 if you
%want to exclude Encens
words_label=[1:11];

all_ANO=all_ANO_t(:,words_label);
all_CON=all_CON_t(:,words_label);

%this is to put the words from the low to the high olfactorry valence
labels_idx=[7,4,5,10,8,9,6,1,2,3,11];
for order=1:length(labels_idx)
    new_ANO(:,order)=all_ANO(:,labels_idx(order));
end %for order
all_ANO=new_ANO;
for order=1:length(labels_idx)
    new_CON(:,order)=all_CON(:,labels_idx(order));
end %for order
all_CON=new_CON;

%% ANO
for isub=1:19
    stimuli=all_ANO(isub,:);
    %%%compute the absolute difference between each pair of value
    for i=1:length(stimuli)
        for j=1:length(stimuli)
            dsm(i,j)=abs(stimuli(i)-stimuli(j));
        end
    end
    vec=squareform(dsm);
    vec_norm=mat2gray(vec);
    All_vec_norm_ANO(isub,:)=vec_norm;
end

%creat group mean vec
Mean_ANO=mean(All_vec_norm_ANO);
%normalize the vector from 0 to 1
Mean_ANO=mat2gray(Mean_ANO);
%
% %visualize the DSMs
%if you excluded encens takee out the 'Encens' label here
labels={'Assiette','Pierre','Aluminium','Riz','Miel','Pêche','Gazon','Menthe','Lavande','Chlore','Encens'};

figure(); imagesc(squareform(Mean_ANO));
colorbar;
set(gca,'XTick',1:length(Mean_ANO),'XTickLabel',labels,...
    'YTick',1:length(Mean_ANO),'YTickLabel',labels);
xtickangle(45);
ax=gca;
set(ax,'FontName','Avenir','FontSize',18, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);
%% CON
for isub=1:20
    stimuli=all_CON(isub,:);
    %%%compute the absolute difference between each pair of value
    for i=1:length(stimuli)
        for j=1:length(stimuli)
            dsm(i,j)=abs(stimuli(i)-stimuli(j));
        end
    end
    vec=squareform(dsm);
    vec_norm=mat2gray(vec);
    All_vec_norm_CON(isub,:)=vec_norm;
end
%Create group mean
Mean_CON=mean(All_vec_norm_CON);
%normalize the vector from 0 to 1
Mean_CON=mat2gray(Mean_CON);


% %visualize the DSMs

%if you excluded encens takee out the 'Encens' label here
labels={'Assiette','Pierre','Aluminium','Riz','Miel','Pêche','Gazon','Menthe','Lavande','Chlore','Encens'};

figure(); imagesc(squareform(Mean_CON));
colorbar;
set(gca,'XTick',1:length(Mean_CON),'XTickLabel',labels,...
    'YTick',1:length(Mean_CON),'YTickLabel',labels);
xtickangle(45);
ax=gca;
set(ax,'FontName','Avenir','FontSize',18, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);

% open this and update the name to save the mat file
% save(strcat('drag_rate_allSUB_siENCENS_39sub_DSMvec_allWords'),'All_vec_norm_ANO','All_vec_norm_CON','Mean_ANO','Mean_CON')