%{
%}
function [accuracy] = testmfccfeatures(loopno, features_mfccs, label, kfoldindex)
    
    ds = size(label, 1);
    mfccmodel = mfccTrainCrossV(loopno, features_mfccs, label, kfoldindex);
    mfccmodel.ModelType = 'MFCC';
    %savemodel(mfccmodel, strcat('mfcc_', num2str(loopno)), '/Users/Thanakorn/Documents/ThirdYearProject/models/');
    
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