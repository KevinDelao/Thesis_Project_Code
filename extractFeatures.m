%% Do windowing + feature extraction for NINAPRO database 1
%% Saves result to savePath
% Saves 27 .mat files (one for each subject) in "savePath" that contain
% windowed feature data for the Mean Absolute Value (MAV) feature
% as well as 1-D arrays of which gesture and repetition is occuring at the
% most recent sample in each window
% Kevin Delao

clear; clc; tic;

%% Settings

addpath('D:\Thesis_DataSets\db3') % Database path: *
% addpath('C:\Users\kevin\Desktop\Thesis_Work\Thesis_DataSets') % Database path: *
% savePath = 'db3_feat'; % Save path: 

windowIncrement = 1; % Number of Samples, 10ms increment
windowLength = 40; % Number of Samples, 400ms window

% Filter specs (cutoff and db sample rate)
fc = 500; % 5 Hz, cut off below 5Hz, 500hz for db2&3
fs = 2000; % 100 Hz sampling rate of db1, 2kHz for db 2&3
[B,A] = butter(2,2*fc/fs,'low');


%% Lop through subjects in DB
for subject = 1:11
    
    %print which subject we are calculating 
    disp(subject);
    
    %Initialize Arrays to Store EMG data
    emgAll = [];
    restimulusAll = [];
    rerepetitionAll = [];

    % Dynamic allocation
%     load(['S' num2str(subject) '_A1_E1.mat']);
    load(['S' num2str(subject) '_E1_A1.mat']);
    % Add emg for each patient into array emgAll
    emg = double(abs(emg));
    emgAll = [emgAll; emg];
    % Add restimulus for each patient into array restimulusAll
    restimulus = double(abs(restimulus));
    restimulusAll = [restimulusAll; restimulus];
    % Add rerepetition for each patient into array rerepetitionAll
    rerepetition = double(abs(rerepetition));
    rerepetitionAll = [rerepetitionAll; rerepetition];

%     load(['S' num2str(subject) '_A1_E2.mat']);
    load(['S' num2str(subject) '_E2_A1.mat']);
    emg = double(abs(emg));
    emgAll = [emgAll; emg];
    restimulus = double(abs(restimulus));
    rerepetition = double(abs(rerepetition));
    restimulusAll = [restimulusAll; (restimulus+max(restimulusAll)*logical(restimulus))];
    rerepetitionAll = [rerepetitionAll; rerepetition];

%     load(['S' num2str(subject) '_A1_E3.mat']);
    load(['S' num2str(subject) '_E3_A1.mat']);
    emg = double(abs(emg));
    emgAll = [emgAll; emg];
    restimulus = double(abs(restimulus));
    rerepetition = double(abs(rerepetition));
    restimulusAll = [restimulusAll; (restimulus+max(restimulusAll)*logical(restimulus))];
    rerepetitionAll = [rerepetitionAll; rerepetition];
    
    %Number of channels for db, ie number of columns
    numChannels = size(emgAll,2);
    
    %% Preprocess with butterworth filter
    %apply filter to all channels, db1 has 10
    a = emgAll;
    for k=1:numChannels
        emgAll(:,k) = filtfilt(B, A, emgAll(:,k));
    end
    b = emgAll;
    %% Windowing
    numWindows = floor((size(emgAll,1)- windowLength)/windowIncrement) + 1;

    %each numWindows here will be a windowLength of 40
    windows = zeros(numWindows,windowLength,numChannels);
    %all rows/windows of emg data
    gesture = zeros(numWindows,1);
    rep = zeros(numWindows,1);

    classList = unique(restimulusAll);
    
    repList = unique(rerepetitionAll);

    winStart = 1;
    winEnd = winStart+windowLength-1;
    
    %windows are rows in emgAll
    for n = 1:numWindows
        windows(n,:,:) = emgAll(winStart:winEnd,:); % Window EMG data

        rep(n) = rerepetitionAll(winEnd);
        
        gesture(n) = restimulusAll(winEnd);

        %increment windows 
        winStart = winStart + windowIncrement;
        winEnd = winEnd + windowIncrement;
    end

    %% Feature Extraction
     emgMAV = zeros(numWindows,numChannels);
     emgVAR = zeros(numWindows,numChannels);
     emgRMS = zeros(numWindows,numChannels);
    for n = 1:numWindows
        % Mean Absolute Value of windows EMG data, each n of windows is a
        % window of 40 emg rows
        emgMAV(n,:) = abs(mean(windows(n,:,:)));
        % Variance
        emgVAR(n,:) = var(windows(n,:,:));
        %Get the RMS of the EMG data within the 400ms window
        emgRMS(n,:) = rms(windows(n,:,:));
    end
    


    %% Save Data
%     save([savePath '\s' num2str(subject) '_feat'],'gesture','rep','emgMAV','emgVAR','emgRMS');
end

% toc
% a2 = a(1:10000,1);
% b2 = b(1:10000,1);
% z = 1:10000;
% 
% tiledlayout(2,1) % Requires R2019b or later
% 
% %Top plot
% nexttile
% plot(z,a2)
% title('Non Filtered sEMG','FontSize', 20)
% xlabel('Time(ms)','FontSize', 16) 
% ylabel('Hertz(Hz)','FontSize', 16)
% set(gca,'FontSize',14);
% 
% ylim([0 2])
% % Bottom plot
% nexttile
% plot(z,b2)
% title('Butterworth Filter','FontSize', 20)
% xlabel('Time(ms)','FontSize', 16) 
% ylabel('Hertz(Hz)','FontSize', 16) 
% set(gca,'FontSize',14);
% 
% ylim([0 2])

% plot(z,SeqOrd,'LineWidth',2) 
% hold on 
% plot(z,KLOrd,'LineWidth',2)
% hold off
% set(gca,'XLim',[1 53])
% set(gca,'XTick',(1:2:53))
% ylim([0 1])
% title('Sequential Vs KLD Ordering(VAR)','FontSize', 20)
% xlabel('Movements','FontSize', 16) 
% ylabel('Accuracy','FontSize', 16) 
% legend('Sequential','KLD', ...
%     'Location', 'southoutside','Orientation','horizontal','FontSize', 14)
% set(legend,'location','northeast')

