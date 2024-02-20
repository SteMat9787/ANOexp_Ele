# DRAG RATE: explanation of all files and folders

## Data files

### Raw Data into .mat files
Starting from the files I received from Eleonore and that she directly got from the platform where she ran the experiment I organized the data in .mat files.

- dataALL_40sub.mat (all subjects)
- dataALL_39sub.mat (excluding sub 15 ANOSMIC who did not perform the task well)
- dataALL_37sub.mat (excluding sub 15 ANOSMIC + sub 4 and 10 ANOSMIC who did not know the meaning of the word Encens)

### Drag_rate values for each subject
From the raw data .mat files I extracted for each subject the values assigned to each word in this task and I created some .mat files including only those values:

- drag_rate37SUB_allWords.mat
- drag_rate39SUB_allWords.mat
- drag_rate39SUB_noEncens.mat

### Dissimilarity Matrices (DSMs)
From the previous .mat files I created 1 DSM for each subject based on his/her own valence values. As dissimilarity distance I used the difference of valence assigned between each pair of words.
The DSMs are stored in vector shape with 55 entries when all 11 words are used [n=((11*11)-11)/2], and 45 when Encens is excluded [n=((10*10)-10)/2].

- drag_rate_allSUB_noENCENS_39sub_DSMvec_All_words.mat;
- drag_rate_allSUB_siENCENS_37sub_DSMvec_All_words.mat;
- drag_rate_allSUB_siENCENS_39sub_DSMvec_All_words.mat;

To create the dissimilarity matrices I used the script:
- create_RDM.m
 --> This script only need one of the 3 drag_rate files to run.
  

