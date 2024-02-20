clear all;

%% Load data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1=CON 2=ANO
Pairs= [1,2];
%set the numebr of iterations
niter=1000;
%%%To run all the possible pair of binary classification in one loop

for p=1:size(Pairs,1) %%In this case is only 2 because we have 2 groups
    CAT_one=Pairs(p,1);
    CAT_two=Pairs(p,2);
    no_categories=2; %here the categories are actually the groups (CON/ANO)
    
    %chose the categories
    if CAT_one==1
        classes(1)={'SC'};
    elseif CAT_one==2
        classes(1)={'AC'};
    end
    
     if CAT_two==1
        classes(2)={'SC'};
    elseif CAT_two==2
        classes(2)={'AC'};
     end
    
    disp(strcat(classes{1},'/',classes{2}));

%% Define data
%config=cosmo_config();
study_path= fileparts(cd); %the previous folder in the hierarchy if path

 numVoxelsTokeep=55;%this is the number of enties in eache DSMvec when also Encens is included
 
    %%prepare the targets (as for 2 categories)
    targets=repmat(1:2,1,19)'; %2 are the gropu and 19 the subject in each group
    targets= sort(targets);

chunks=[1:19,1:19]';


    load('ds.mat'); %this is just a ds.mat from another experiment. I will use this as a template and put my new targets, chunks and samples 
    ds.sa.targets=targets;
    ds.sa.chunks=chunks;
    
     load (strcat(study_path,'drag_rate_allSUB_siENCENS_39sub_DSMvec_All_words.mat'));

     for i=1:19
         AC(i,:)=mat2gray(All_vec_norm_ANO(i,:));
     end
     pecora=1;
     for i=[2:20]
         SC(pecora,:)=mat2gray(All_vec_norm_CON(i,:));
         pecora=pecora+1;
     end
     %

    samples=[SC;AC];
    ds.samples=samples;
 
        idx_one=find(ds.sa.targets==CAT_one);
        idx_two=find(ds.sa.targets==CAT_two);
        idxs=[idx_one;idx_two];
        %idxs= sort(idxs);
        ds=cosmo_slice(ds,idxs);
        targets= (ds.sa.targets);
        chunks= ds.sa.chunks;
 
    % remove constant features (due to liberal masking)
    ds=cosmo_remove_useless_data(ds);
    
    measure= @cosmo_crossvalidation_measure;
    
    % Make a struct containing the arguments for the measure:
    args=struct();
    args.child_classifier = @cosmo_classify_lda;
    %args.child_classifier = @cosmo_classify_svm;
    %args.partitions = cosmo_nfold_partitioner(ds);
    args.output='predictions';
    args.normalization = 'zscore';%'demean';
   % args.normalization = 'demean';
    args.feature_selector=@cosmo_anova_feature_selector;
    
      if size(ds.samples,2)==numVoxelsTokeep
args.feature_selection_ratio_to_keep = numVoxelsTokeep;
elseif size(ds.samples,2)<numVoxelsTokeep
    disp (strcat('Num vox: ',num2str(length(ds.samples))));
args.feature_selection_ratio_to_keep = length(ds.samples);
end
   
    partitions = cosmo_nfold_partitioner(ds);
    %fprintf('Using the following measure:\n');
    %cosmo_disp(measure,'strlen',Inf); % avoid string truncation
    
    %fprintf('\nUsing the following measure arguments:\n');
    %cosmo_disp(args);
    
    % Apply the measure to ds, with args as second argument. Assign the result
    % to the variable 'ds_accuracy'.
     cosmo_warning('off')
    ds_accuracy = cosmo_crossvalidate(ds,@cosmo_meta_feature_selection_classifier,partitions,args);
        
           ds_accuracy = reshape(ds_accuracy', 1, []);
            ds_accuracy = ds_accuracy(~isnan(ds_accuracy))';
    cosmo_warning('off')
    confusion_matrix=cosmo_confusion_matrix(targets,ds_accuracy);
    
    
    %confusion_matrix=cosmo_confusion_matrix(ds_accuracy.sa.targets,ds_accuracy.samples);
    sum_diag=sum(diag(confusion_matrix));
    sum_total=sum(confusion_matrix(:));
    accuracy=sum_diag/sum_total;
   
    real_accuracy=accuracy
  
    
    
    %% start permutation
       a=(100:100:niter);
    for i=1:niter
        if sum(i==a)==1
            disp (strcat('iter_num_',num2str(i)));
        end
    %shuffle the targets
    targets=Shuffle(ds.sa.targets);
    
     % Apply the measure to ds, with args as second argument. Assign the result
    % to the variable 'ds_accuracy'.
     cosmo_warning('off')
    ds_accuracy = cosmo_crossvalidate(ds,@cosmo_meta_feature_selection_classifier,partitions,args);
     
           ds_accuracy = reshape(ds_accuracy', 1, []);
            ds_accuracy = ds_accuracy(~isnan(ds_accuracy))';
    cosmo_warning('off')
    confusion_matrix=cosmo_confusion_matrix(targets,ds_accuracy);
    
    
    %confusion_matrix=cosmo_confusion_matrix(ds_accuracy.sa.targets,ds_accuracy.samples);
    sum_diag=sum(diag(confusion_matrix));
    sum_total=sum(confusion_matrix(:));
    accuracy=sum_diag/sum_total;
   
    perm_accuracy(i)=accuracy;
    end %niter
end %for p (pairs)
%end%%for iroi

%open this to save
%save(strcat('Results_perm_DRAG_RATE/Perm_SC_AC',num2str(niter),'_39sub_AL_words20'),'real_accuracy','perm_accuracy');