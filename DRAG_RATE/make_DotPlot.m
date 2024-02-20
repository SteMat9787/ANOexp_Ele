function  make_DotPlot(data,Gr)


%% make a dot plot taking into account the overlap/density of the plot. 
%%This script gives 2 possible solutions:

%%1.  Baloon dot plot: if the values  are closer than a treshold
%%value they will be merged in one marker. The size of the marker will
%%increase according to the number of values that it represents. 

%%2. Jittered dot plot: there will be one marker for each value. In case of
%%close/overlapping values, the markers will be jittered on the x axis. The
%%size of the marker will not change. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EVERYTHING TO BE SET IS HERE: 

% % set the density_distance for clustering (all the values that are
% % within the density distance will be plotted as one marker, the size
% % of the marker will increase according to the number of values that it
% % represents) 
density_distance=-0.1; %if not density clustering put -0.1 here. With a value >0 you will have a baloon dot plot

%%%%set jittering (normally to be used when the density clustering is not implemented)
jitterAmount=0.2;% for no jittering put 0 here (otherwise try 0.15/ to be adjusted according to the data)

%%set the size of the markers that represent one value
starting_size=1500; % in the density_plot this will be the smallest marker size (= 1 sub), in the jittered plot all the markers will be of this size


%%set the shape of the markers
%Here some possibilities
% 'o'	Circle
% '+'	Plus sign
% '*'	Asterisk
% '.'	Point
% 'x'	Cross
% 'square' or 's'	Square
% 'diamond' or 'd'	Diamond
% '^'	Upward-pointing triangle
% 'v'	Downward-pointing triangle
% '>'	Right-pointing triangle
% '<'	Left-pointing triangle
% 'pentagram' or 'p'	Five-pointed star (pentagram)
% 'hexagram' or 'h'	Six-pointed star (hexagram)
% 'none'	No markers
shape='.';

%%set the width of the edge of the markers
LineWidthMarkers=3;
%%set the width of the edge of the mean line
LineWidthMean=8;
%%set the length of the mean line
LineLength=0.4; %the actual length will be the double of this value

%%set if you want filled or empty markers
% % % NB: Option to fill the interior of the markers, specified as 'filled'.
% % % Use this option with markers that have a face, for example, 'o' or 'square'.
% % %     Not fort Markers that do not have a face and contain only edges ('+', '*', '.', and 'x').

%filled=0; %0 if you want empty markers
filled=1 % 1 if you want filled markers

%%set if you want the error bars or not
error_bar=1; end_points=1; % with error bars with endpoints
%error_bar=1; end_points=0; % with error bars only one line (no endpoints)
%error_bar=0 %without error bars

%%%set the color for each condition in RGB (and divide them by 256 to be matlab compatible)
% Col_A=[255 171 2]/256; %orange
% Col_B=[225 63 251]/256; %pink
% Col_C=[0 205 90]/256;   %green
% Col_D=[2 73 191]/256; %blue

    Col_B=[105 170 153]/256; %EB 
    Col_A=[97 94 151]/256;%SC
%     Col_A=[255 158 74]/256; %LB 
%     Col_B=[97 94 151]/256;%SC
if Gr==1
Colors=repmat(Col_A,11,1)
elseif Gr==2
    Colors=repmat(Col_B,11,1)
end
 %Colors=[Col_A;Col_B;Col_C;Col_D];
%%%set the transparency of the markers
Transparency=0.7;

%%set other characteristics of the graph
XTick= 1:11;%size(data,2);
%%original order
%%XTickLabel={'Menthe','Lavande','Chlore','Pierre','Aluminium','Gazon','Assiette','Miel','Pêche','Riz','Encens'};
%%new order
XTickLabel={'Assiette','Pierre','Aluminium','Riz','Miel','Pêche','Gazon','Menthe','Lavande','Chlore','Encens'};
%these go under each column
xLim=[0,max(XTick)+1];
yLim=[0 1]; %put here your xLim
FontName='Avenir'; %set the style of the labels
FontSize=20; %%set the size of the labels
Y_label='RATING of OLFACTION VALENCE'; %%write here your measure/label for y axis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%visualize data
%figure()
set(gcf,'color','w'); %to have white background


for i_col=1:length(XTick)
    col= data(:,i_col);
    
    %call the function that average the values according to the density distance and
    %give as outputs the new vector and the size of each density cluster
    [new_vec,size]=compute_density(col,density_distance, starting_size);
    data_density=new_vec;
    [row] = length(data_density);
    xrow = repmat(i_col,row,1);
    %plot the marker for each sub (density clustered)
    if filled==0 %%for empty markers
        scatter(xrow(:), data_density(:),size, shape,'MarkerEdgeColor',Colors(i_col,:),'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
    elseif filled==1 %%for filled markers
        scatter(xrow(:), data_density(:),size, shape,'filled','MarkerFaceColor',Colors(i_col,:),'MarkerEdgeColor',Colors(i_col,:),'MarkerEdgeAlpha',Transparency,'MarkerFaceAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
    end
    hold on;
    %%plot the mean
    plot([xrow(1,1)-LineLength; xrow(1,1) + LineLength], repmat(mean(data(:,i_col), 1), 2, 1),'LineWidth',LineWidthMean,'Color',Colors(i_col,:));
    
    if error_bar==1
    %%plot the st. err
    stDev=std(col); %compute the standard deviation
    stErr=stDev/sqrt(length(col)); %compute the standard error
    plot([xrow(1,1); xrow(1,1)], [mean(data(:,i_col))+stErr mean(data(:,i_col))-stErr],'k','LineWidth',3)%,'Color',Colors(i_col,:));
    %%plot the 2 small line at the endpoint of the error bar
    if end_points==1
    hold on
    plot([xrow(1,1)-0.05 xrow(1,1)+0.05],[mean(data(:,i_col))+stErr mean(data(:,i_col))+stErr],'k','LineWidth',3)%,'Color',Colors(i_col,:));
    hold on
    plot([xrow(1,1)-0.05 xrow(1,1)+0.05],[mean(data(:,i_col))-stErr mean(data(:,i_col))-stErr],'k','LineWidth',3)%,'Color',Colors(i_col,:));
    end %if end_points
    end %if error bar
end %for col(umns) number
ax=gca;
set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'yLim',yLim,'xLim',xLim,'XTick', XTick,'XTickLabel',XTickLabel,'FontSize',FontSize);
% xlabel(['ANIM','HUMAN','OBJ','BIG'],'FontSize',18,'FontAngle','italic');
ylabel(Y_label,'FontSize',FontSize,'FontAngle','italic');
end