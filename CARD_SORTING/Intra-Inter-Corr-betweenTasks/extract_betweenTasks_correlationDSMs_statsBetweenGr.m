%% In this script:
% - calculation of the  task correlation: correlate the neural DSM of
% each subject with the mean of the neural DSMs of all the other subject in
% the other task. --> IMPORTAnt: I still do this between subject to keep
% the same level of variance as for the other correlations betweeen groups

clear;


 %%set output path
 output_path='Between_gr_corr_allWORDS_betweenTasks/';
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


%%load the data
data_path= fileparts(cd);

%num of subject in each group
nSCneutre=20;
nSColfa=20;

nACneutre=20;
nAColfa=20;

%%load the data
data_path= fileparts(cd);%load the Neutral task Anosmic

%load the Neutral task Anosmic
load (strcat(data_path,'/CARD-SORTING-NEUTRE/DSMs_vectors.mat'));
all_CON_Neutre=DSM_SC_all;
all_ANO_Neutre=DSM_AC_all;

load (strcat(data_path,'/CARD-SORTING-OLFA/DSMs_vectors.mat'));
all_CON_Olfa=DSM_SC_all;
all_ANO_Olfa=DSM_AC_all;

meanCONneutre=mean(all_CON_Neutre);
meanCONolfa=mean(all_CON_Olfa);

meanANOneutre=mean(all_ANO_Neutre);
meanANOolfa=mean(all_ANO_Olfa);

%% compute the correlation between tasks in Controls 

%%Correlate each ControlNeutre DSM with the mean of ControlOlfa DSM f
for sub=1:nSCneutre
     %select one sub DSM
            DSM=all_CON_Neutre(sub,:);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCONolfa;
           
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%Correlate each ControlOlfa DSM with the mean of ControlNeutrec DSM
for sub=1:nSColfa
     %select one sub DSM
            DSM=all_CON_Olfa(sub,:);
            
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCONneutre;
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for SC

%% Compute the correlation between tasks in Anosmics
%%Correlate each ControlNeutre DSM with the mean of ControlOlfa DSM f
for sub=1:nACneutre
     %select one sub DSM
            DSM=all_ANO_Neutre(sub,:);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANOolfa;
           
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%Correlate each ControlOlfa DSM with the mean of ControlNeutrec DSM
for sub=1:nAColfa
     %select one sub DSM
            DSM=all_ANO_Olfa(sub,:);
            
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANOneutre;
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%Compute the final average between the 2 directions 
Mean_betweeNTasks_corr_Controls=(mean(r_SCneutre)+mean(r_SColfa))/2;
disp (strcat('Corr_betweenTasks in Controls:',num2str(Mean_betweeNTasks_corr_Controls)));


%Compute the final average between the 2 directions 
Mean_betweeNTasks_corr_Anosmics=(mean(r_ACneutre)+mean(r_AColfa))/2;
disp (strcat('Corr_betweenTasks in Anosmics:',num2str(Mean_betweeNTasks_corr_Anosmics)));

%Compute the difference 
real_diff=Mean_betweeNTasks_corr_Anosmics-Mean_betweeNTasks_corr_Controls;
disp (strcat('Diff between groups:',num2str(real_diff)));

%% start iteration
disp 'iteration started'
% Gr1=all_CON_Neutre;
% Gr2=all_CON_Olfa;
for iter=1:10000 %repeat teh iteration 10000 times to build the null distribution
%%Correlate each ControlNeutre DSM with the mean of ControlOlfa DSM f
for sub=1:nSCneutre
     %select one sub DSM
            DSM=all_CON_Neutre(sub,:);
            DSM=Shuffle(DSM);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCONolfa;
            averaged_DSMs=Shuffle(averaged_DSMs);
           
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SCneutre(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%Correlate each ControlOlfa DSM with the mean of ControlNeutrec DSM
for sub=1:nSColfa
     %select one sub DSM
            DSM=all_CON_Olfa(sub,:);
             DSM=Shuffle(DSM);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanCONneutre;
            averaged_DSMs=Shuffle(averaged_DSMs);
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SColfa(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for SC

%% Compute the correlation between tasks in Anosmics
%%Correlate each ControlNeutre DSM with the mean of ControlOlfa DSM f
for sub=1:nACneutre
     %select one sub DSM
            DSM=all_ANO_Neutre(sub,:);
             DSM=Shuffle(DSM);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANOolfa;
           averaged_DSMs=Shuffle(averaged_DSMs);
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub
            if corr_type==1   %%Pearson corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_ACneutre(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%Correlate each ControlOlfa DSM with the mean of ControlNeutrec DSM
for sub=1:nAColfa
     %select one sub DSM
            DSM=all_ANO_Olfa(sub,:);
             DSM=Shuffle(DSM);
            %correlate with the average DSMs from the other gr (CON)
            averaged_DSMs=meanANOneutre;
            averaged_DSMs=Shuffle(averaged_DSMs);
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_AColfa(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%Compute the final average between the 2 directions 
Mean_betweeNTasks_corr_Controls=(mean(r_SCneutre)+mean(r_SColfa))/2;

%Compute the final average between the 2 directions 
Mean_betweeNTasks_corr_Anosmics=(mean(r_ACneutre)+mean(r_AColfa))/2;

%Compute the difference 
iter_diff(iter)=Mean_betweeNTasks_corr_Anosmics-Mean_betweeNTasks_corr_Controls;
 end


%open this, update the name and save (if you keep the same name the
%previous file will be overwritten)
save(strcat(output_path,'allWords_ITER_BetweenTasks_corrDSMs_statsBetweenGr',Task_name,'_allSub'),'real_diff','iter_diff');

