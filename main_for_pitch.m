% Number of sets of data
n = 10;
nooffeature = 4;

% Group all the samples from various places into one place
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/*.wav';
[datasetpath, label] = combineddata(adultfilespath, 1, childfilespath, 0);
datasize = size(label, 1);

% For each of those sample, extract features.
% Pitch and formants features 
% MFCCs feature set.
feature_pf = zeros(datasize, nooffeature);
feature_pf(:, 1) = pitchfromfiles(datasetpath);
feature_pf(:, 2:nooffeature) = formantsfromfiles(datasetpath);
mfccdatasize = size(label, 1);

accuracy = zeros(n, 1);
for i=1:n
    disp(strcat('Main Loop ', num2str(i)));
    %Create indexs for tranining and testing randomly.
    tstpercent = 0.4; % percent of the whole data for testing
    [trainmfcc, testmfcc] = crossvalind('HoldOut', label, tstpercent); 
    
    
    traindata = zeros(sum(trainmfcc == 1), nooffeature);
    testdata = zeros(sum(testmfcc == 1), nooffeature);
    
    trainlabel = zeros(sum(trainmfcc == 1), 1);
    testlabel = zeros(sum(testmfcc == 1), 1);
    %Index for traindata and testdata
    k = 1; l = 1;
    for j = 1:mfccdatasize
        if trainmfcc(j) == 1
            traindata(k, :) = feature_pf(j, :);
            trainlabel(k, 1) = label(j);
            k = k+1;
        else
            testdata(l, :) = feature_pf(j, :);
            testlabel(l, 1) = label(j);
            l = l+1;
        end
    end
    
    disp('Creating MFCCs Model');
    mfccmodel = svmtrain(traindata, trainlabel, 'kernel_function', 'rbf');
    
    
    textprogressbar('Classifying Mfccs data: ');
    percentconstant = 100/l;
    for j = 1:size(testdata, 1)
        textprogressbar(j*percentconstant);
        if (svmclassify(mfccmodel, testdata(j, :)) == testlabel(j, 1))
            accuracy(i, 1) = accuracy(i, 1) + 1;
        end
    end
    textprogressbar('done');
end