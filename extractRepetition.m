%% Regenrate repetition array saving to savePath
% Takes the original array denoting repetitions
% Labels rests as belonging to proceeding repetition
% Adds dead zone (denoted by 0s) around each repetition to ensure that
% the training and testing sets are decoupled when split by repetition
% number
% Requires gesture array to be updated by extractGesture.m


%% House Keeping/Setup
clear; clc;

addpath('gesture') % Gesture array path: ***EDIT ACCORDIGNLY***
savePath = 'repetition'; % Save path: ***EDIT ACCORDIGNLY***

for subject=1:27
    %where gesture majority 
    eval(['load s' num2str(subject) '_gestureMajority']);
    rep = zeros(numel(gesture),1);
    %get index of row right before gesture number changes in gesture.mat
    gestureChangeInd = find(diff(gesture)~=0); % Get indices for end of each gesture/rest

    repNum = 1;
    %max repition for db1
    repMax = 10;
    for kk = 2:2:numel(gestureChangeInd)
        startInd = gestureChangeInd(kk - 1) + 1;
        %last patient in db1
        if(subject == 27)
            disp(startInd);

        end
        endInd = gestureChangeInd(kk);
         if(subject == 27)
             disp(endInd);
        end
        rep(startInd:endInd) = repNum;
        repNum = repNum + 1;

        if repNum > repMax
            repNum = 1;
        end
    end


    %% Label each rest as belonging to the proceeding repetition
    curRep = 0;
    for ii = numel(rep):-1:1
        if rep(ii) == 0
            rep(ii) = curRep;
        elseif  rep(ii) ~= curRep
            curRep = rep(ii);
        end
    end

    %% Decouple repetion by adding dead zone before and after each repetion - prevents cross-contam with test set
    skipLength = 40; % Number of samples to skip over at end of each rep
    skipLength = skipLength - 1; % Since we need to null at the crossover seperately
    curRep = rep(1);
    skipCount = 0;
    for ii = 1:numel(rep)
        if skipCount ~= 0
            rep(ii) = 0;
            skipCount = skipCount - 1;
        elseif  rep(ii) ~= curRep
            skipCount = skipLength;
            curRep = rep(ii);
            rep(ii) = 0;
        end
    end

    eval(['save ' savePath '\s' num2str(subject) '_rep.mat rep']);
end
