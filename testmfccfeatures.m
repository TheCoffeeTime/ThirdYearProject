%{
Description:
    - Test a given dataset (features from data) using SVM
    - Training data = loopno != kfoldindex
    - Training data = loopno == kfoldindex
Parameters:
    - loopno and kfoldindex: use for comparision of what training and
      testing data to use
    - features_pf: data features (pitch and formants, f0-f3)
    - label corresponding to the data
Return:
    - Accuracy in percentage
%}
function [accuracy] = testmfccfeatures(loopno, features_mfccs, label, kfoldindex)
    
    ds = size(label, 1);
    
    % Training phase
    mfccmodel = mfccTrainCrossV(loopno, features_mfccs, label, kfoldindex);
    mfccmodel.ModelType = 'MFCC';
    
    % Testing
    noofts = 0;
    correctcount = 0;
    for i = 1:ds
        % If it is a testing data, then test it
        if loopno == kfoldindex(i)
            noofts = noofts + 1;
            ts = features_mfccs(label(i, 2):label(i, 3), :);
            predictedlabel = testMFCC(ts, mfccmodel);
            if predictedlabel == label(i, 1)
                correctcount = correctcount +1;
            end
        end
    end
    accuracy = correctcount / noofts;
    
end