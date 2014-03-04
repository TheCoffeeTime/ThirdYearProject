%{
%}
function [accuracy] = testmfccfeatures(loopno, features_mfccs, label, kfoldindex)
    
    ds = size(label, 1);
    nmfccd = (abs(label(:, 2) - label (:, 3))) + 1;     % vector of no. of mfccs for each data.
    tss = sum((kfoldindex == loopno) .* nmfccd);        % Test data size
    
    mfccmodel = mfcctrain(loopno, features_mfccs, label, kfoldindex);
    savemodel(mfccmodel, strcat('mfcc_', num2str(loopno)), '/Users/Thanakorn/Documents/ThirdYearProject/models/');
    
    % Testing
    nooftdf = 0;
    correctcount = 0;
    correctcountfull = 0;
    for i = 1:ds
        % If it is a testing data, then test it
        if loopno == kfoldindex(i)
            nooftdf = nooftdf + 1;
            tdf = features_mfccs(label(i, 2):label(i, 3), :);
            s = size(tdf, 1);
            apl = zeros(s, 1);
            for j = 1:s
                apl(j) = svmclassify(mfccmodel, tdf(j, :));
                
                %This is just here to count the accuracy of the method
                %since I seems to be getting 100% accuracy. 
                if(apl(j) == label(i, 1))
                    correctcountfull = correctcountfull + 1;
                end
            end
            predictedlabel = mode(apl);
            if predictedlabel == label(i, 1)
                correctcount = correctcount +1;
            end
        end
    end
    accuracy = zeros(1, 2);
    accuracy(1) = correctcount / nooftdf;
    accuracy(2) = correctcountfull / tss;
    
end