# DRAG RATE: explanation of all files and folders
A summary .key of all these results and analyses can be found [here](https://www.dropbox.com/scl/fi/mtfw6pfnipusdtctxlgrd/Results_withAndWithoutSomewords_sub_Feb24.key?rlkey=6d0rtp7dtqb62ntntiiw4jada&dl=0).

## DATA FILES

### Raw Data into .mat files
Starting from the files I received from Eleonore and that she directly got from the platform where she ran the experiment I organized the data in .mat files.

- <ins>dataALL_40sub.mat</ins> (all subjects)
- <ins>dataALL_39sub.mat</ins> (excluding sub 15 ANOSMIC who did not perform the task well)
- <ins>dataALL_37sub.mat</ins> (excluding sub 15 ANOSMIC + sub 4 and 10 ANOSMIC who did not know the meaning of the word Encens)

### Drag_rate values for each subject
From the raw data .mat files I extracted for each subject the values assigned to each word in this task and I created some .mat files including only those values:

- <ins>drag_rate37SUB_allWords.mat</ins>
- <ins>drag_rate39SUB_allWords.mat</ins>
- <ins>drag_rate39SUB_noEncens.mat</ins>

### Dissimilarity Matrices (DSMs)
From the previous .mat files I created 1 DSM for each subject based on his/her own valence values. As dissimilarity distance I used the difference of valence assigned between each pair of words.
The DSMs are stored in vector shape with 55 entries when all 11 words are used [n=((11 X 11)-11)/2], and 45 when Encens is excluded [n=((10 X 10)-10)/2].

- <ins>drag_rate_allSUB_noENCENS_39sub_DSMvec_All_words.mat</ins>;
- <ins>drag_rate_allSUB_siENCENS_37sub_DSMvec_All_words.mat</ins>;
- <ins>drag_rate_allSUB_siENCENS_39sub_DSMvec_All_words.mat</ins>;

To create the dissimilarity matrices I used the script:
- <ins>create_RDM.m</ins>
 --> This script only need one of the 3 drag_rate files to run.

## ANALYSES & VISUALIZATION OF DRAG_RATE VALUES

### Visualization of how the words have been evaluated 

First, you can visualize the average position for each group. The sccript is:
- <ins>Extract_positions_plotONtheSAMEgraph.m</ins> --> to run this script you only need the data in the drag_rate values format;

Second, you can visualize the average position for each subject (one figure per group). 
this script will not plot the woords but the number from 1 to 11, assigned to each word from low to high valence. E.g 11==Encens). The script is:
 - <ins>Extract_positions_plotONtheSAMEgraph_eachSUB.m</ins>
   --> to run this script you need:
   1. the data in the drag_rate values format;
   2. the file <ins>pm_data_no15.m</ins>
 

### Visualization of the average values for each Group (each subject is a dot)
There are two possible ways of visualizing these values:

The first possibility is to plot every words for a total of 10 or 11 words plotted in the same graph. The script to use is:
- <ins>visualize_DotPlot_allWords.m</ins>
     --> to run this script you need:
     1. The data in the drag_rate values format;
     2. The function: <ins>compute_density.m</ins>;
     3. The function: <ins>make_DotPlot.m</ins>;

The second possibility is to plot the values averaged for LOW, MIDDLE and HIGH olfaction valence words. The script to use is:
- <ins>visualize_DotPlot_LOW_MID_HIGH.m</ins>
  --> to run this script you need:
     1. The data in the drag_rate values format;
     2. The function: <ins>compute_density.m</ins>;
     3. The function: <ins>make_DotPlot_LOW_MIDDLE_HIGH.m</ins>;

 ### ANOVA(s) based on these values Group * Olfa_level (2 * 3) or Group * Words (2 * 11).
 These data are in the folder:
 - <ins>ANOVA</ins> --> whithin this folder you can find:
   - the .csv file where all values are included after excluded outliers: <ins>DragandRATE_withNanFOR_OUTLIERS.csv</ins> --> values deviating from the group average >2.5 standard deviations are considered outliers
   - the Jasp file in which the ANOVAs are stored: <ins>DragandRATE_withNanFOR_OUTLIERS.jasp</ins>
   
 
 ## ANALYSES & VISUALIZATION OF DSMs VALUES

 ### Visualization of DSMs, multidimentional scaling and dendrogram/clustering analysis
 
 Visualization of Group Average DSMs, multidimensional scaling MDS (not really relevant for this task since there is only one relevant dimension) and dendrogram/clustering. This ccan be done with the script:
 - <ins>visualize_DSM_MDS_dendrogram.m</ins> --> to run this script you only needd the data in DSMs format

Visualization of dendrogram for each Sub. Use the script:
- <ins>visualize_dendrogram_allSub.m</ins> --> to run it you just need the data in the DSM format

### Between Groups Correlation
Compute the correlation between the DSMs of Control & Anosmic using this script:
- <ins>extract_betweenGroup_correlationDSMs.m</ins> --> to run it you only need thee data in DSM format
This script compute the Spearman correlation betweeen the DSMs of the 2 groups in this way:
1. Correlate the DSM of each anosmic subject with the mean DSM of the control group and average all thes values
2. Correlate the DSM of each control subject with the mean DSM of the anosmic group and average all thes values
3. Average the 2 values obtained from point 1 and 2 --> this is the final value representing the between groups Correlation

In the second part of the script the same procedure is performed 10000 times after shuffling the DSMs' label at the start of each iteration: this 10000 values are used to build a null distribution and compute statistics.

This script gives as an output a .mat file: e.g. <ins>siEncens_ITER_BetweenGr_corrDSMsDRAG-RATE_39sub</ins> stored in the folder: <ins>Inter_Intra_Corr_results/Between_gr_corr_allWORDS</ins>.
Inside the same folder there is also a script:
- <ins>visualize_and_compute_statistic_within.m</ins> : with this script you can visualize the null distribution, the real value of Corr and compute the p value (it will be printed in the command window together with the mean Corr value)

### Within Group Correlation, aka maxCorr
Compute the correlation between the DSMs of each subject with the rest of his/heer own group, for bpth group separately using:
- <ins>extract_max_corr_intraGroup_iteration_DSMs.m</ins> --> to run it you only need thee data in DSM format
The within group correlation gives an idea of the stability of the representation within each group, across subjects.

This script compute the within group correlation in this way:
1. Correlate the DSM of each anosmic subject with the mean DSM of the rest of the same group and average this value = withing Anosmic Gr Correlation
2. Correlate the DSM of each control subject with the mean DSM of the rest of the same group and average this value = withing Control Gr Correlation
3. To compute the statistical difference between the 2 group (i.e. is the representation more stable in one group compared to the other?) we finally compute the difference between the 2 values obtained in point 1 and 2

In the second part of the script the same procedure is performed 10000 times after shuffling the DSMs' label at the start of each iteration: this 10000 values are used to build a null distribution and compute statistics.

This script gives as an output a .mat file: e.g. <ins>SiEncens_Max_corr_DSMs_DRAG-RATE10000iter_39sub</ins> stored in the folder: <ins>Inter_Intra_Corr_results/Max_correlation_allWORDS</ins>.
Inside the same folder there is also a script:
- <ins>visualize_and_compute_statistic_within.m</ins> : with this script you can visualize the null distribution, the real values of Corr and compute the p value (it will be printed in the command window)

### Decoding analysis: can we decode the group label from the DSMs?
All files related to this analysis are in the folder: <ins>Decoding_Analyses</ins>.
The script to run it is:
- <ins>Decode_DSMmatrices_DRAG_RATE_SC_AC_permutation.m</ins>
 --> to run this script you need:
  1. the data in DSMs format
  2. the <ins>ds.mat</ins> file (template to organize the data for the decoding in CosmoMVPA style).

 To run this analysis there is a "problem" to solve. We need the same number of subject in both groups but we have 20 in Con and 19 in Ano. I only ran this analysis for all words (including Encens) and for all sub (only excluding sub 15 ano.
 I ran the decoding 20 times, each time excluding 1 different control (so I have evry time 19 sub in each group). 
 For each time I ran it, I also run 1000 permutation after shuffling the group label (i.e. assigning randomly each sub to one group). 
 The results are in the folder <ins>Results_perm_DRAG_RATE</ins>.
 Inside this folder there are 2 scripts:
 - <ins>Merge_together_the_iterations.m</ins> to average the 19 accuracy values (and the 1000 permutation values) in each of the 20 iterations --> this script creates the file <ins>Perm_SC_AC20000_39sub_ALL_words_20iterations</ins>
 - <ins>visualize_and_compute_statistic_within.m</ins> to visualize the null distribution, the average accuracy value and compute the p value. 
