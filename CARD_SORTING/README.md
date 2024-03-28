# DRAG RATE: explanation of all files and folders
A summary .key of all these results and analyses can be found [here](https://www.dropbox.com/scl/fi/mtfw6pfnipusdtctxlgrd/Results_withAndWithoutSomewords_sub_Feb24.key?rlkey=6d0rtp7dtqb62ntntiiw4jada&dl=0).
A description of the words used as stimuli is [here](https://www.dropbox.com/scl/fi/ic678hfzf1d7gg890crxu/Tableaux_Stimuli_EleonoreNov23.pdf?rlkey=gsn6u0q470tryhl50d5jnwiru&dl=0).

## DATA FILES

### Raw Data into .mat files
Starting from the files I received from Eleonore and that she directly got from the platform where she ran the experiment I organized the data in .mat files.

- <ins>dataALL_40sub.mat</ins> (all subjects)


### Dissimilarity Matrices (DSMs) 
From the previous .mat files I created 1 DSM for each subject based on his/her own values. 

The DSMs are stored in vector shape with 190 entries when all words are used, and 153 when ammoniac and cannelle are excluded (sub 10 and 11 did not know their meaning). 

- <ins>DSM_vectors.mat</ins>
- <ins>DSM_vectors_exclSub.mat</ins>
- <ins>DSM_vectors_exclWords.mat</ins>


To create an visualize the dissimilarity matrices I used the script:
- <ins>plotDSM.m</ins>
 --> This script need the dataALL_40sub.mat file & 'pm_data.m' function to run.


## DATA VISUALIZATION
### Dissimilarity Matrices representation
See above for cassica DSM representation (same script as for creating the dsm files);

These two scripts plot the DSMs changing the order of the conditions based on their similarities. It is useful in order to appreciate possible clustering of the conditions:
- <ins>REORDER_DSM_Olfa_basedONsimilarity.m<ins>
- <ins>REORDER_DSM_Neutre_basedONsimilarity.m<ins>

To run these script only the file <ins>DSM_Gr_mean.mat<ins> with the mean value of each group (20 sub) is neeeded.


### Multidimentional scaling
Script for MDS is <ins>Plot_MDS.m<ins>

This script need:
- <ins>dataALL_40sub.mat</ins> file
- <ins>pm_data.m<ins> function
- <ins>DSM_Gr_mean.mat<ins> with the mean value of each group

### Dendogram
Script is <ins>Plot_dendogram.m<ins>

This script need:
- <ins>dataALL_40sub.mat</ins> file
- <ins>pm_data.m<ins> function
- <ins>DSM_Gr_mean.mat<ins> with the mean value of each group


## ANALYSES
### Decoding analysis: can we decode the group label from the DSMs?
All files related to this analysis are in the folder: <ins>Decoding_Analyses</ins>.
The script to run it is:
- <ins>Decode_DSMmatrices_CARD_SORTING_NEUTRE_SC_AC_permutation.m</ins>
- <ins>Decode_DSMmatrices_CARD_SORTING_OLFA_SC_AC_permutation.m</ins>
 --> to run this script you need:
  1. the data in DSMs format
  2. the <ins>ds.mat</ins> file (template to organize the data for the decoding in CosmoMVPA style).

 The results are in the folder <ins>Results_perm_CARD_SORTING_NEUTRE</ins> and <ins>Results_perm_CARD_SORTING_OLFA</ins>.
 Inside this folder there is 1 scripts:

 - <ins>visualize_and_compute_statistic_within.m</ins> to visualize the null distribution, the real accuracy value and compute the p value. 

  


