
clear all


load('allWords_Max_corr_DSMs_CARD-SORTING10000iter_40sub.mat')



%%%%%visualize and compute statistic within
n_iter=10000;

realCorr=Real_diff;
Corr_perm=Iter_diff(1:n_iter);

pVal=(sum(Corr_perm>realCorr)+1)/(n_iter+1);


%%%%visualize the null distribution
figure();
set(gcf,'color','w'); %to have white background
nbins= 10;

texttitle = ['Permuting Groups labels'];

 hist(Corr_perm,nbins);

 h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','k')
%Overlay our observation
hold on
%     Color=[105 170 153]/256; %EB 

    Color=[255 158 74]/256; %LB 
plot([realCorr,realCorr],ylim,'Color',Color,'LineWidth',4);
hold off
% Add title and axis labels
title(texttitle);
X_label='Difference of Within  Gr Corr.';
Y_label='Number of permutations';

 ax=gca;
    set(ax,'FontName','Avenir','FontSize',20, 'FontWeight','bold',...
        'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0])%,...
        %'yLim',yLim,'xLim',xLim,'XTick', XTick,'XTickLabel', XTickLabel,'FontSize',FontSize);
    % xlabel(['ANIM','HUMAN','OBJ','BIG'],'FontSize',18,'FontAngle','italic');
    ylabel(Y_label,'FontSize',20,'FontAngle','italic');
    xlabel(X_label,'FontSize',20,'FontAngle','italic');
    
disp (strcat('WithinGrCorr-CON:',num2str(mean(r_SC))));
disp (strcat('WithinGrCorr-ANO:',num2str(mean(r_AC))));
disp (strcat('pVal-differenceOfWithinCorr-between groups:',num2str(pVal)));
