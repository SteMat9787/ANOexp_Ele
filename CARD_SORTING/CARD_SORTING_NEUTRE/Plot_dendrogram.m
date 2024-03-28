%get the subject info (name and group)
global sub
sub=pm_data;
excl_words=0 %include all the words
%excl_words=1; %exclude words ammoniac and cannelle


load ('dataALL_40sub');

if excl_words==0
labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Ammoniac','Fumier','Vin','Poivre','Vanille','Cannelle','Stylo','Assiette','Ville'};
elseif excl_words==1
 labels={'Menthe','Essence','Pierre','Laine','Gazon','Rose','Océan','Pin','Asperge','Choux de Bruxelles','Cigarette','Fumier','Vin','Poivre','Vanille','Stylo','Assiette','Ville'};
end
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
    
    ColorTreshold=0.7; %default is 0.7
    Reorder=[];
    subdend=linkage(squareform(DSM));
    subplot(5,4,isub);
    H=dendrogram(subdend,'Reorder',Reorder,'labels',labels,'orientation','left','ColorThreshold',ColorTreshold * max(subdend(:,3)));
    title (strcat('AC SUB n',num2str(isub)));
    set(H,'LineWidth',2)
    
end %for isub

%Plot control subjects
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
    ColorTreshold=0.7; %default is 0.7
    Reorder=[];
    subdend=linkage(squareform(DSM));
    subplot(5,4,isub-20);
    H=dendrogram(subdend,'Reorder',Reorder,'labels',labels,'orientation','left','ColorThreshold',ColorTreshold * max(subdend(:,3)));
    title (strcat('AC SUB n',num2str(isub-20)));
    set(H,'LineWidth',2)
    
end %for isub

%Plot the mean Anosmic
load 'DSM_Gr_mean';

    DSM=DSM_AC_mean;
        if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
    figure();
    set(gcf,'color','w'); %to have white background
    ColorTreshold=0.7; %default is 0.7
    Reorder=[];
    subdend=linkage(squareform(DSM));
    H=dendrogram(subdend,'Reorder',Reorder,'labels',labels,'orientation','left','ColorThreshold',ColorTreshold * max(subdend(:,3)));
    title ('Anosmic Group');
    set(H,'LineWidth',2)
    
    
    
    DSM=DSM_SC_mean;
        if excl_words==1
        DSMmat=squareform(DSM);
        DSMmat([12,17],:)=[];
        DSMmat(:,[12,17])=[];
        DSM=squareform(DSMmat);
    end 
    figure();
    set(gcf,'color','w'); %to have white background
    ColorTreshold=0.7; %default is 0.7
    Reorder=[];
    subdend=linkage(squareform(DSM));
    H=dendrogram(subdend,'Reorder',Reorder,'labels',labels,'orientation','left','ColorThreshold',ColorTreshold * max(subdend(:,3)));
    title ('Control Group');
    set(H,'LineWidth',2)