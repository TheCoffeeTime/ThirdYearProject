%{
Description:    
    From a given set of MFCCs features, test it, and do a voite. 
Parameter: 
    ts: Testing data
    mfccmodel: SVM model of MFCCs
%}
function [predictedlabel, confidence] = testMFCC(ts, mfccmodel)
    tss = size(ts, 1);      % ts size
    apl = zeros(tss, 1);    % Array of predicted label
    
    % For each frame from a speech, test them and keep the predicted label 
    for j = 1:tss
        apl(j) = svmclassify(mfccmodel, ts(j, :));
    end
    
    % Get the voted label and calculate the accuracy.
    predictedlabel = mode(apl);
    if predictedlabel == 1
        confidence = sum(apl) / tss;
    else
        confidence = 1- (sum(apl) / tss);
    end