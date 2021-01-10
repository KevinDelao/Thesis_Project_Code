addpath('results_VAR') % ***EDIT ACCORDIGNLY***
% addpath('C:\Users\Kevin Delao\Desktop\Thesis_Work\Thesis_DataSets\results_fix_mav') % ***EDIT ACCORDIGNLY***

% savePath = 'results_fix_mav'; % Save path: 
savePath = 'results_fix_var'; % Save path: 


fileNames = {
             'predictionsVARKL'
             };
resultsToCompile = 21:53; % Which results to compile (number of gestures in set)
resultLen = numel(resultsToCompile);
%  for numGestures = resultsToCompile
%         eval(['load ' fileNames{1} num2str(numGestures)]);
%         eval(['pred_forest' num2str(numGestures) '=predictions']);
% %         temp = predictions;
% %         eval(['temp' '=pred_forest' num2str(numGestures)]);
% %         save([savePath '\pred_forest' num2str(numGestures) '.mat'] ...
% %              ,'temp');
%  end

 for numGestures = resultsToCompile
        predictions2 = cell(27,1,6);
        eval(['load ' fileNames{1} num2str(numGestures)]);
        predictions2(:,1,1) = predictions(:,1,1);
        predictions2(:,1,2) = predictions(:,1,2);
        predictions2(:,1,3) = predictions(:,1,3);
        predictions2(:,1,4) = predictions(:,1,4);
        predictions2(:,1,5) = predictions(:,1,5);
        eval(['predictions2(:,1,6)' '=pred_forest' num2str(numGestures) '(:,1)']);
        predictions=predictions2;
        save([savePath '\predictions' 'MAV' 'KL' num2str(numGestures) '.mat'] ...
             ,'predictions','testClassesAll','trainTime');
         predictions = {};
 end







