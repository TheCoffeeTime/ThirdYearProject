% Number of sets of data
n = 10;

% Group all the samples from various places into one place
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/*.wav';
[datasetpath, label] = combineddata(adultfilespath, {'adult'}, childfilespath, {'child'});
datasize = size(label, 1);

% For each of those sample, extract features.
% Pitch and formants features 
% MFCCs feature set.
feature_pf = zeros(datasize, 4);
feature_pf(:, 1) = pitchfromfiles(datasetpath);

dataperset = floor(datasize/n);

%for i=1:n
    
    %Create indexs for tranining and testing randomly with X percentage of
    %testing value
    [train, test] = crossvalind('HoldOut', label, 0.4);
    
%end