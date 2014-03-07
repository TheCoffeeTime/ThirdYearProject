function [predictedlabel, confidence] = testMFCC(ts, mfccmodel)
    tss = size(ts, 1);
    apl = zeros(tss, 1);
    for j = 1:tss
        apl(j) = svmclassify(mfccmodel, ts(j, :));
    end
    predictedlabel = mode(apl);
    if predictedlabel == 1
        confidence = sum(apl) / tss;
    else
        confidence = 1- (sum(apl) / tss);
    end