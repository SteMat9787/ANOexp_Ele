%% In this script:
% - calculation of the intra group correlation: correlate the neural DSM of
% each subject with the mean of the neural DSMs of all the other subject in
% the same group.

clear;


 %%set output path
 output_path='Inter_Intra_Corr_results/Between_gr_corr_allWORDS/';
 Task_name = 'CARD-SORTING';


corr_type=3;%%1==pearson // 2==Kendall// 3==Spearman
if corr_type==1
    disp('corr type: Pearson');
end
if corr_type==2
    disp('corr type: Kendal');
end
if corr_type==3
    disp('corr type: Spearman');
end

%num of subject in each grouo
nAC=20;
nSC=20;


%%load the data
data_path= cd;

load (strcat(data_path,'/DSMs_vectors.mat'));


all_ANO=DSM_AC_all;
all_CON=DSM_SC_all;

meanANO=mean(all_ANO);
meanCON=mean(all_CON);

%%Correlate each Anosmic DSM with the mean of Control DSM
for sub=1:nAC
     %select one sub DSM
            DSM=all_ANO(sub,:);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCON;
           
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%Correlate each Control DSM with the mean of Anosmic DSM
for sub=1:nSC
     %select one sub DSM
            DSM=all_CON(sub,:);
            
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANO;
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for SC

%Compute the final average between the 2 direction ANO to CON and CON to
%ANO
Mean_betweenGr_corr=(mean(r_AC)+mean(r_SC))/2;
disp (strcat('Corr_betwenGr:',num2str(Mean_betweenGr_corr)));

%% start iteration
disp 'iteration started'
Gr1=all_ANO;
Gr2=all_CON;
for iter=1:10000 %repeat teh iteration 10000 times to build the null distribution
       
meanANO=mean(Gr1);
meanCON=mean(Gr2);

%%Anosmic with mean Cont
for sub=1:nAC
     %select one sub DSM
            DSM=Gr1(sub,:);
            DSM=Shuffle(DSM);%shuffle the DSMs label for each subject DSM
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCON;
            averaged_DSMs=Shuffle(averaged_DSMs);%shuffle the labels for the mean DSM
           
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_AC(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%SC
for sub=1:nSC
     %select one sub DSM
            DSM=Gr2(sub,:);
            DSM=Shuffle(DSM);%shuffle the DSMs label for each subject DSM
            
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANO;
            averaged_DSMs=Shuffle(averaged_DSMs);%shuffle the labels for the mean DSM
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SC(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for SC
%create a vector with the 10000 values from the itarions with shuffled DSMs labels
    ITER_Mean_betweenGr_corr(iter)=(mean(r_AC)+mean(r_SC))/2;
 end


%open this, update the name and save (if you keep the same name the
%previous file will be overwritten)
save(strcat(output_path,'allWords_ITER_BetweenGr_corrDSMs',Task_name,'_allSub'),'Mean_betweenGr_corr','ITER_Mean_betweenGr_corr');

