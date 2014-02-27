%{
%}
function [accuracy] = testmfccfeatures(loopno, features_mfccs, label, kfoldindex)
    
    noofdata = size(label, 1);
    noofmfccs = size(features_mfccs, 2);
    nmfccd = (abs(label(:, 2) - label (:, 3))) + 1;     % vector of no. of mfccs for each data.
    testdatasize = sum((kfoldindex == loopno) .* nmfccd);
    traindatasize = sum(nmfccd) - testdatasize;
    testdata = zeros(testdatasize, noofmfccs);
    traindata = zeros(traindatasize, noofmfccs);
    testindex = 1;
    trainindex = 1;
    
    % For each file data, seperate them into training or testing data
    % depening on the loop number. 
    for i = 1:noofdata
        if loopno == kfoldindex(i)  % if it is a testing data
            endindex = testindex+nmfccd(i) - 1;
            testdata(testindex:endindex, :) = features_mfccs(label(i, 2):label(i, 3), :);
            testindex = testindex+nmfccd(i);
        else % else it is a training data
            endindex = trainindex+nmfccd(i) - 1;
            traindata(trainindex:endindex, :) = features_mfccs(label(i, 2):label(i, 3), :);
            trainindex = trainindex+nmfccd(i);
        end
    end
    accurcy = 0;
    
end