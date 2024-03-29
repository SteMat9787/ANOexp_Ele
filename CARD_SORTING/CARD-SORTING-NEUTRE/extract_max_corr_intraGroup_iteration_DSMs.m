%% In this script:

clear;
SUB_inclusion=1; %All subjects (to exclude incense open line 39 and close line 38)


 %%set ROIs_DSMs

output_path='Inter_Intra_Corr_results/Max_correlation_allWORDS/';


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

nAC=20;
nSC=20;


%%load the data
data_path= cd;


load (strcat(data_path,'/DSMs_vectors.mat'));


all_ANO=DSM_AC_all;
all_CON=DSM_SC_all;

%%Anosmic
for sub=1:nAC
     %select one sub DSM
            DSM=all_ANO(sub,:);
            %average all the others DSMs
            all=[1:nAC];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nAC
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

%%SC
for sub=1:nSC
     %select one sub DSM
            DSM=all_CON(sub,:);
            %average all the others DSMs
            all=[1:nSC];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_CON(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nSC
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


disp (strcat('Intra corr ANOSMIC:',num2str(mean(r_AC))));
disp (strcat('Intra corr CONTROLS:',num2str(mean(r_SC))));

Real_diff= (mean(r_SC)) - (mean(r_AC))
%start iteration
disp 'permutation starts';
n_iter=10000;
allSUB=[all_CON;all_ANO];
for iter=1:n_iter
    random_Gr = allSUB(randperm(size(allSUB, 1)), :);
    all_ANO=random_Gr(1:nAC,:);
    all_CON=random_Gr(nAC+1:nAC+nSC,:);

    
    %%Anosmic
for sub=1:nAC
     %select one sub DSM
            DSM=all_ANO(sub,:);
            %average all the others DSMs
            all=[1:nAC];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_ANO(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nAC
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
for sub=1:nSC
     %select one sub DSM
            DSM=all_CON(sub,:);
            %average all the others DSMs
            all=[1:nSC];
            others_sub=all(setdiff(1:end,sub));
            for i= others_sub
                %for line=1:16
                others_DSMs(i,:) = all_CON(i,:);
            end
            
            %%delete the empty line of the sub
            if sub~=nSC
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


%open this, update the name and save (if you do not change the name the
%previous file will be overwritten)
save(strcat(output_path,'allWords_Max_corr_DSMs_',Task_name,num2str(n_iter),'iter_40sub'),'r_AC','r_SC','Real_diff','Iter_diff');