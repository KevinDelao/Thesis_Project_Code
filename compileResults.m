%% Compile results into .mat file for easy reference later
% Need to have run all 6 trainClassifiersX scripts


addpath('D:\Thesis_DataSets\db3_results_VAR') % ***EDIT ACCORDIGNLY***

classifierSet = {
%                  'knn';
%                  'lda';
%                  'rbf';
%                  'svm linear';
%                  'tree';
                 'forest';
                 };
%%
fileNames = {
             'predictionsVARArbitary';
             'predictionsVARKL'
             };
%%
resultsToCompile = 1:50; % Which results to compile (number of gestures in set,53 db1, 50 db3)
resultLen = numel(resultsToCompile);

%6 for normal cases, this for ARB
resultsSeq = zeros(1,resultLen);
for classifier = 1:numel(classifierSet)
    for numGestures = resultsToCompile
                 eval(['load ' fileNames{1} num2str(numGestures)]);
%         if(classifier == 6)
%             a = {};
%             for i = 1:27
%                  b = (predictions(i,1,6));
%                  b = b{:};
%                  b = str2double(b);
%                  a{end+1} = b;
%             end
%             a =reshape(a,27,1);
%             predictions(:,1,6) = a;
%         end
        classMean = getClassifierAccuracy(predictions(:,1,classifier),testClassesAll);
        disp(['Gestures: ' num2str(numGestures) ' ' classifierSet{classifier} ' Mean:' num2str(classMean)]);
        resultsSeq(classifier,numGestures) = classMean;
    end
end


%for KL
resultsKL = zeros(1,resultLen);
for classifier = 1:numel(classifierSet)
    for numGestures = resultsToCompile
                 eval(['load ' fileNames{2} num2str(numGestures)]);
%         if(classifier == 6)
%             a = {};
%             for i = 1:27
%                  b = (predictions(i,1,6));
%                  b = b{:};
%                  b = str2double(b);
%                  a{end+1} = b;
%             end
%             a =reshape(a,27,1);
%             predictions(:,1,6) = a;
%         end
        classMean = getClassifierAccuracy(predictions(:,1,classifier),testClassesAll);
        disp(['Gestures: ' num2str(numGestures) ' ' classifierSet{classifier} ' Mean:' num2str(classMean)]);
        resultsKL(classifier,numGestures) = classMean;
    end
end



save db3_results_VAR.mat resultsSeq resultsKL




