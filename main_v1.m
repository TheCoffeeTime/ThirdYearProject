% Number of sets of data
n = 10;
noofmfcccoeff = 13;

% Group all the samples from various places into one place
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/*.wav';
[datasetpath, label] = combineddata(adultfilespath, 1, childfilespath, 0);
datasize = size(label, 1);

% For each of those sample, extract features.
% Pitch and formants features 
% MFCCs feature set.
%feature_pf = zeros(datasize, 4);
%feature_pf(:, 1) = pitchfromfiles(datasetpath);
%feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
[feature_mfccs, mfccslabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
mfccdatasize = size(mfccslabel, 1);

%for i=1:n
    
    %Create indexs for tranining and testing randomly.
    tstpercent = 0.4; % percent of the whole data for testing
    [trainmfcc, testmfcc] = crossvalind('HoldOut', mfccslabel, tstpercent); 
    
    
    traindata = zeros(sum(trainmfcc == 1), noofmfcccoeff);
    testdata = zeros(sum(testmfcc == 1), noofmfcccoeff);
    
    trainlabel = zeros(sum(trainmfcc == 1), 1);
    testlabel = zeros(sum(testmfcc == 1), 1);
    %Index for traindata and testdata
    k = 1; l = 1;
    for j = 1:mfccdatasize
        if trainmfcc(j) == 1
            traindata(k, :) = feature_mfccs(j, :);
            trainlabel(k, 1) = mfccslabel(j);
            k = k+1;
        else
            testdata(l, :) = feature_mfccs(j, :);
            testlabel(l, 1) = mfccslabel(j);
            l = l+1;
        end
    end
    
    options = statset('MaxIter', 100000);
    mfccmodel = svmtrain(traindata, trainlabel, 'kernel_function', 'polynomial', 'polyorder', 13, 'options', options);
    
%end