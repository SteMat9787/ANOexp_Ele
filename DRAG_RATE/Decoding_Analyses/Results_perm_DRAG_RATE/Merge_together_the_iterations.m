% Get the current folder
currentFolder = pwd;

% Get a list of all files in the current folder
fileList = dir(fullfile(currentFolder, '*.mat'));

% Display the list of .mat files
%disp('List of .mat files in the current folder:');
for i = 1:length(fileList)
    %disp the filename and assign it a variable name
    disp(fileList(i).name);
    file= (fileList(i).name);
    %load the file
    load(file);
    
    Real_acc_all(i)=real_accuracy;
    Perm_acc_all(i,:)=perm_accuracy;
end
Mean_acc_all=mean(Real_acc_all);
Perm_acc_vec=Perm_acc_all(:);

save('Perm_SC_AC20000_39sub_ALL_words_20iterations','Real_acc_all','Perm_acc_all','Mean_acc_all','Perm_acc_vec');
