
load ('drag_rate_39SUB_allWords');
%     
Ex_incense_sub4and10=1 %put 0 if you want to keep incens for all sub, 1 if you want too exclude it only for sub 4 and 10

nANO=39;
nCON=20;

all_ANO=all_ANO';
all_CON=all_CON';

%original order
%labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','Pêche','Riz','Incens'};
if Ex_incense_sub4and10==1
%%%%I add this section to exclude incens only from sun 4 and 10 (they did
%%%%not know the meaning)
%%Only for the representation purpose I will inseert the 2 subject as
%%average value computed without including them in the group)
%Extract the values for ANO group for incens
Incens_vec_ANO=all_ANO(:,11);
%Exclude sub 4 and 10 and compute the mean (whitout them)
Incens_vec_ANO(10)=[];
Incens_vec_ANO(4)=[];
Mean_Incens_without4and10=mean(Incens_vec_ANO);
%Insert the mean values insteead of thee ooriginal value for incense fpr
%sub 4 and 10
all_ANO(4,11)=Mean_Incens_without4and10;
all_ANO(10,11)=Mean_Incens_without4and10;
end


labels_idx=[7,4,5,10,8,9,6,1,2,3,11];
for order=1:length(labels_idx)
    new_ANO(:,order)=all_ANO(:,labels_idx(order));
end %for order
all_ANO=new_ANO;
for order=1:length(labels_idx)
    new_CON(:,order)=all_CON(:,labels_idx(order));
end %for order
all_CON=new_CON;


    figure();

data=all_ANO;
Gr=2;
make_DotPlot(data,Gr);
hold on

data=all_CON;
Gr=1;
make_DotPlot(data,Gr);
