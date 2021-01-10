%% Plot results
% Takes results.m file produced by compileResults.m and produces a pretty
% graph
% 

%% Housekeeping
clear; clc;
addpath('C:\Users\kevin\Desktop\Thesis_Project\') 
load db3_results_MAV
% Next 3 need to be kept coherent
% resultNames = {
%                 'resultsSeq'
%                 };
% 
% xNames = {       
%             'xArb'
%             };
% 
% legendEntries = {
%                     'Arb'
%                     };
% titles = {
%          {'KNN'; 'Average Correct Classification '};
%          {'LDA'; 'Average Correct Classification '};
%          {'SVM RBF'; 'Average Correct Classification '};
%          {'SVM Linear'; 'Average Correct Classification '};
%          {'Decision Tree' 'Average Correct Classification '}
%          {'Random Forest'; 'Average Correct Classification '};
%          };
% 
% 
% figure(1); clf reset
% for classifier = 1:size(titles)
%     for metric = 1:size(resultNames)
%         subplot(6,1,classifier)
%         hold on;
% 
%         eval(['plot(1:53,' resultNames{metric} '(classifier,:),''linewidth'',2)']);
% 
%         title(titles{classifier})
%         ylim([0 1])
%         xlim([1 53])
% 
%         ylabel('Performance');
%         xlabel('Number of Movements');
% 
%         grid on;
%         grid minor;
%         hold off;
%     end
% end
% change z to 1:50 if using db2&3
z = 1:53;


seq1 = resultsSeq(1,:);
% seq2 = resultsSeq(2,:);
% seq3 = resultsSeq(3,:);
% seq4 = resultsSeq(4,:);
% seq5 = resultsSeq(5,:);
% seq6 = resultsSeq(6,:);

kl1 = resultsKL(1,:);
% kl2 = resultsKL(2,:);
% kl3 = resultsKL(3,:);
% kl4 = resultsKL(4,:);
% kl5 = resultsKL(5,:);
% kl6 = resultsKL(6,:);
% kl6(1,31) = .55;


hold on 
% plot(z,seq1,'LineWidth',2) 
% plot(z,kl1,'LineWidth',2) 
% plot(z,seq2,'LineWidth',2)
% plot(z,seq3,'LineWidth',2)
% plot(z,seq4,'LineWidth',2)
% plot(z,seq5,'LineWidth',2)
% plot(z,seq6,'LineWidth',2)
% % 
% plot(z,kl1,'LineWidth',2) 
% plot(z,kl2,'LineWidth',2)
% plot(z,kl3,'LineWidth',2)
% plot(z,kl4,'LineWidth',2)
% plot(z,kl5,'LineWidth',2)
% plot(z,kl6,'LineWidth',2)
% title('Database 1 Sequential Movement Ordering Classification Accuracy (MAV)', 'FontSize', 20)
% title('Database 3 RF Sequential vs KLD Ordering (MAV)', 'FontSize', 20)

xlabel('Movements', 'FontSize', 18) 
set(gca,'FontSize',14);
ylabel('Accuracy','FontSize', 18) 
hold off

set(gca,'XLim',[1 50])
set(gca,'XTick',(1:2:50))
ylim([0 1])
% 
% legend('KNN','LDA','RBF','SVM','DT','RF', ...
%     'Location', 'southoutside','Orientation','horizontal', 'FontSize', 14)
legend('Seq','KLD',...
    'Location', 'southoutside','Orientation','horizontal', 'FontSize', 14)

set(legend,'location','northeast')
%legend(legendEntries{1}, ...
 %   'Location','northeast','Orientation','horizontal')
%set(legend,'location','northeast')
% legend(legendEntries{1}, ...
%     'Location', 'southoutside','Orientation','horizontal')
% set(legend,'location','northeast')
newres = kl1-seq1;
newres = newres*100;
plot(newres);
xlabel('Movements', 'FontSize', 12) 
set(gca,'FontSize',12);
ylabel('Percentage','FontSize', 14) 
set(gca,'XLim',[1 50])
set(gca,'XTick',(1:2:50))
title('Percentage Increases Database 3 MAV RF', 'FontSize', 20)

