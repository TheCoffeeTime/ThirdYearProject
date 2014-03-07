function [accuracy] = testmfccfeatures2(model, features_mfccs, shortlabel)
    ds = size(shortlabel, 1);
    correctCount = 0;
    for i = 1:ds
        ts = features_mfccs(shortlabel(i, 2):shortlabel(i, 3), :);
        predictedlabel = testMFCC(ts, model);
        if predictedlabel == shortlabel(i, 1)
            correctCount = correctCount +1;
        end
    end
    accuracy = correctCount * 100 / ds;
end