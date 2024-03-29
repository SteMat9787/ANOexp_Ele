%%exclude the words cannelle and ammoniac (because 2 sub. did not know
%%their meaning)
excl_words=0 %include all the words
%excl_words=1; %exclude words ammoniac and cannelle

excl_sub=0 %include all sub
%excl_sub=1 % excllude settled-coral (n11) and darlig-griphon (n10).

if excl_sub==0
    Anosmic_sub=[1:20]
elseif excl_sub==1
    Anosmic_sub=[1:9,12:20];
end

%get the subject info (name and group)
global sub
sub=pm_data;

load ('dataALL_40sub');
if excl_words==0
labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Ammoniac','Fumier','Vin','Poivre','Vanille','Cannelle','Stylo','Assiette','Ville'};
elseif excl_words==1
 labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Fumier','Vin','Poivre','Vanille','Stylo','Assiette','Ville'};
end

%Ammoniac==12
%Cannelle==17


%normalized=0; %no
normalized=1; %yes

%Plot  DSM for anosmic
figure();

for isub=Anosmic_sub
    DSM=dataALL.(sub(isub).name).rdm;
    if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
    
    DSM_AC_all(isub,:)= DSM;
    if normalized==1
        DSM=mat2gray(DSM);
    end
    subplot(5,4,isub);
    imagesc(squareform(DSM));
    set(colorbar,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
    title (strcat('AC SUB n',num2str(isub)));
    
    if isub==170
        set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels);
        set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels);
        xtickangle(90);
    else
        set(gca, 'YTick',(1:length(labels)),'YTickLabel',[]);
        set(gca, 'XTick',(1:length(labels)),'XTickLabel',[]);
    end
    ax=gca;
    set(ax,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);
    %suptitle('Anosmic Subjects');
end %for isub

%Plot not-normalized DSM for controls
figure();
for isub=21:40
    DSM=dataALL.(sub(isub).name).rdm;
    if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
    
    
    DSM_SC_all([isub-20],:)= DSM;
    if normalized==1
        DSM=mat2gray(DSM);
    end
    subplot(5,4,isub-20);
    imagesc(squareform(DSM));
    set(colorbar,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
    title (strcat('SC SUB n',num2str(isub-20)));
    
    if isub==370
        set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels);
        set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels);
        xtickangle(90);
    else
        set(gca, 'YTick',(1:length(labels)),'YTickLabel',[]);
        set(gca, 'XTick',(1:length(labels)),'XTickLabel',[]);
    end
    ax=gca;
    set(ax,'FontName','Avenir','FontSize',10, 'FontWeight','bold',...
        'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);
    %suptitle('Control Subjects');
end %for isub

%Plot the mean DSM for each group

DSM_AC_mean=mean(DSM_AC_all);
DSM_AC_mean=mat2gray(DSM_AC_mean);
figure();
imagesc(squareform(DSM_AC_mean));
set(colorbar,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
title ('Anosmic Subjects Mean - Neutral Task');
set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels);
set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels);
xtickangle(90);
ax=gca;
set(ax,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);



DSM_SC_mean=mean(DSM_SC_all);
DSM_SC_mean=mat2gray(DSM_SC_mean);
figure()
imagesc(squareform(DSM_SC_mean));
set(colorbar,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0]);
title ('Control Subjects Mean - Neutral Task');
set(gca, 'YTick',(1:length(labels)),'YTickLabel',labels);
set(gca, 'XTick',(1:length(labels)),'XTickLabel',labels);
xtickangle(90);
ax=gca;
set(ax,'FontName','Avenir','FontSize',26, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0]);
if excl_words==0
    if excl_sub==0
save('DSMs_vectors','DSM_SC_all','DSM_AC_all','DSM_SC_mean','DSM_AC_mean');
    elseif excl_sub==1
        save('DSMs_vectors_exclSub','DSM_SC_all','DSM_AC_all','DSM_SC_mean','DSM_AC_mean');
    end
elseif excl_words==1
save('DSMs_vectors_exclWords','DSM_SC_all','DSM_AC_all','DSM_SC_mean','DSM_AC_mean');
end