%% In this script:

clear;


 %%set ROIs_DSMs

output_path='Max_correlation_allWORDS_betweenTasks/';


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
%define number of sub in each gr

nACneutre=20;
nAColfa=20;


%%load the data
data_path= fileparts(cd);

%load the Neutral task Anosmic
load (strcat(data_path,'/CARD-SORTING-NEUTRE/DSMs_vectors.mat'));
all_ANO_Neutre=DSM_AC_all;

load (strcat(data_path,'/CARD-SORTING-OLFA/DSMs_vectors.mat'));
all_ANO_Olfa=DSM_AC_all;

%%nAnosmic Neutre
for sub=1:nACneutre
     %select one sub DSM
            DSM=all_ANO_Neutre(sub,:);
            %average all the others DSMs
            all=[1:nACneutre];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO_Neutre(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nACneutre
                others_DSMs(sub,:)=[];
            end
            %%average all the others sub DSMs
            averaged_DSMs = mean(others_DSMs);
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
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

%%nANosmic Olfa
for sub=1:nAColfa
     %select one sub DSM
            DSM=all_ANO_Olfa(sub,:);
            %average all the others DSMs
            all=[1:nAColfa];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO_Olfa(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nAColfa
                others_DSMs(sub,:)=[];
            end
            %%average all the others sub DSMs
            averaged_DSMs = mean(others_DSMs);
            
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


disp (strcat('Intra corr ANOSMIC Neutre:',num2str(mean(r_AC))));
disp (strcat('Intra corr ANOSMIC Olfa:',num2str(mean(r_SC))));

Real_diff= (mean(r_SC)) - (mean(r_AC))
%start iteration
disp 'permutation starts';
n_iter=10000;
allSUB=[all_ANO_Olfa;all_ANO_Neutre];
for iter=1:n_iter
    random_Gr = allSUB(randperm(size(allSUB, 1)), :);
    all_ANO_Neutre=random_Gr(1:nACneutre,:);
    all_ANO_Olfa=random_Gr(nACneutre+1:nACneutre+nAColfa,:);

    
    %%Anosmic
for sub=1:nACneutre
     %select one sub DSM
            DSM=all_ANO_Neutre(sub,:);
            %average all the others DSMs
            all=[1:nACneutre];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO_Neutre(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nACneutre
                others_DSMs(sub,:)=[];
            end
            %%average all the others sub DSMs
            averaged_DSMs = mean(others_DSMs);
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_AC_iter(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_AC_iter(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_AC_iter(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for AC

%%SC
for sub=1:nAColfa
     %select one sub DSM
            DSM=all_ANO_Olfa(sub,:);
            %average all the others DSMs
            all=[1:nAColfa];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO_Olfa(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nAColfa
                others_DSMs(sub,:)=[];
            end
            %%average all the others sub DSMs
            averaged_DSMs = mean(others_DSMs);
            
            %%compute the correlation between the sub DSM and the averaged DSMs
            %%and store it in "r.mat" in which each row is a sub, each column is a ROI
            if corr_type==1   %%Pearson corr
                r_SC_iter(sub,1)=corr(DSM',averaged_DSMs');            
            end
            
            if corr_type==2    %Kendall corr
                r_SC_iter(sub,1)=corr(DSM',averaged_DSMs','type','Kendall');               
            end
            
            if corr_type==3     %%Spearman corr
                r_SC_iter(sub,1)=corr(DSM',averaged_DSMs','type','Spearman');       
            end
end %for SC
  
Iter_diff(iter)= (mean(r_SC_iter)) - (mean(r_AC_iter));
end %iteration

r_ACneutre=r_AC;
r_AColfa=r_SC;
%open this, update the name and save (if you do not change the name the
%previous file will be overwritten)
save(strcat(output_path,'Anosmics_allWords_Max_corr_DSMs_',Task_name,num2str(n_iter),'iter_40sub'),'r_ACneutre','r_AColfa','Real_diff','Iter_diff');