# DRAG RATE: explanation of all files and folders

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
 - <ins>Extract_positions_plotONtheSAMEgraph_eachSUB.m</ins>  --> to run this script yoou need the data in the drag_rate values format;
 

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
   
 
 
