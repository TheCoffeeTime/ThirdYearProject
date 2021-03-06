%{
Description:
    This is a script used to validate the accuracy of the data and features
    used. It does a crossfold validation. 
%}

% Number of sets of data
n = 10;
noofmfcccoeff = 13;
accuracy = zeros(n, 2); %Accuracy array

% Get all the file names required and put them into one list. 
% also create a label corresponding to them. 
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/*.wav';
[datasetpath, label] = combineddata(adultfilespath, 1, childfilespath, 0);

%Total number of files in the list. 
datasize = size(label, 1);

% For each of those sample, extract features.
% Pitch and formants features and MFCCs feature set.

%feature_pf = zeros(datasize, 4);
%feature_pf(:, 1) = pitchfromfiles(datasetpath);
%feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
[feature_mfccs, mfccslabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
%mfccdatasize = size(mfccslabel, 1);


[kfoldindex] = crossvalind('Kfold', label, n);
for i=1:n
    disp(strcat('Test main loop ', num2str(i)));
    accuracy(i, 1) = testmfccfeatures(i, feature_mfccs, mfccslabel, kfoldindex);
    %accuracy(i, 2) = testpffeatures(i, feature_pf, label, kfoldindex);
end
%}