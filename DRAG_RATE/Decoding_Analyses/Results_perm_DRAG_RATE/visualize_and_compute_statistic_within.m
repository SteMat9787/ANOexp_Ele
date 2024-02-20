
clear all

%%%%%visualize and compute statistic within

n_iter=1000;

% load(strcat('Perm_SC_AC1000_39sub_AL_words11.mat'));
load 'Perm_SC_AC20000_39sub_ALL_words_20iterations.mat';


% realAcc=real_accuracy;
% Acc_perm=perm_accuracy(1:n_iter);

realAcc=Mean_acc_all;
%Acc_perm=Perm_acc_vec(1:n_iter);
mean_perm=mean(Perm_acc_all);
Acc_perm=mean_perm(1:n_iter);


pVal=(sum(Acc_perm>realAcc)+1)/(n_iter+1);

%%%%visualize the null distribution
figure();
set(gcf,'color','w'); %to have white background
nbins= 16;

texttitle = ['Permuting DSMs between Controls and Anosmics'];

hist(Acc_perm,nbins);

h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','k')
%Overlay our observation
hold on
Color=[255 158 74]/256; %
plot([realAcc,realAcc],ylim,'Color',Color,'LineWidth',4);
hold off
% Add title and axis labels
title(texttitle);
X_label='Accuracy level';
Y_label='Number of permutations';

ax=gca;
set(ax,'FontName','Avenir','FontSize',20, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0])%,...
%'yLim',yLim,'xLim',xLim,'XTick', XTick,'XTickLabel', XTickLabel,'FontSize',FontSize);
% xlabel(['ANIM','HUMAN','OBJ','BIG'],'FontSize',18,'FontAngle','italic');
ylabel(Y_label,'FontSize',20,'FontAngle','italic');
xlabel(X_label,'FontSize',20,'FontAngle','italic');

disp (strcat('% ACCURACY:',num2str(realAcc*100)));
disp (strcat('pVal:',num2str(pVal)));
