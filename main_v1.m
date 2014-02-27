% Number of sets of data
n = 10;
noofmfcccoeff = 13;
accuracy = zeros(n, 1); %Accuracy array

% Get all the file names required and put them into one list. 
% also create a label corresponding to them. 
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/*.wav';
[datasetpath, label] = combineddata(adultfilespath, 1, childfilespath, 0);

%Total number of files in the list. 
datasize = size(label, 1);

% For each of those sample, extract features.
% Pitch and formants features 
% MFCCs feature set.
%feature_pf = zeros(datasize, 4);
%feature_pf(:, 1) = pitchfromfiles(datasetpath);
%feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
[feature_mfccs, mfccslabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
mfccdatasize = size(mfccslabel, 1);

[kfoldindex] = crossvalind('Kfold', label, n);
for i=1:n
    disp(strcat('Test MFCCs loop no.', num2str(i)));
    testmfccfeatures(i, feature_mfccs, mfccslabel, kfoldindex);
end
%}