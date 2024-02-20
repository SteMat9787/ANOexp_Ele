


%load ('drag_rate_39SUB_noEncens'); 
%load ('drag_rate_37SUB_allWords'); 
load ('drag_rate_39SUB_allWords'); %only with this put line 8 =1

Ex_incense_sub4and10=1; %put 0 if you do not want to exclude it

%change the nANO basedd on the file you selected (it can be 19 or 17)  
nANO=19;
nCON=20;

all_ANO=all_ANO';
all_CON=all_CON';

%original order
%labels={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','Pêche','Riz'};

LOW_label=[4,5,7,10];
all_CON_LOW=all_CON(:,LOW_label);
all_ANO_LOW=all_ANO(:,LOW_label);
mean_CON_LOW=mean(all_CON_LOW,2);
mean_ANO_LOW=mean(all_ANO_LOW,2);

MIDDLE_label=[6,8,9];
all_CON_MIDDLE=all_CON(:,MIDDLE_label);
all_ANO_MIDDLE=all_ANO(:,MIDDLE_label);
mean_CON_MIDDLE=mean(all_CON_MIDDLE,2);
mean_ANO_MIDDLE=mean(all_ANO_MIDDLE,2);

if Ex_incense_sub4and10==1
%%%%I add this section to exclude incens only from sub 4 and 10 (they did
%%%%not know the meaning)
%%Only for the representation purpose I will insert the 2 subject as
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

HIGH_label=[1,2,3,11];
all_CON_HIGH=all_CON(:,HIGH_label);
all_ANO_HIGH=all_ANO(:,HIGH_label);
mean_CON_HIGH=mean(all_CON_HIGH,2);
mean_ANO_HIGH=mean(all_ANO_HIGH,2);

all_CON=[mean_CON_LOW,mean_CON_MIDDLE,mean_CON_HIGH];
all_ANO=[mean_ANO_LOW,mean_ANO_MIDDLE,mean_ANO_HIGH]



figure();

data=all_ANO;
Gr=2;
make_DotPlot_LOW_MIDDLE_HIGH(data,Gr);
hold on

data=all_CON;
Gr=1;
make_DotPlot_LOW_MIDDLE_HIGH(data,Gr);
