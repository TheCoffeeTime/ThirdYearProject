%{
%}
function [accuracy] = testmfccfeatures(loopno, features_mfccs, label, kfoldindex)
    
    noofdata = size(label, 1);
    noofmfccs = size(features_mfccs, 2);
    nmfccd = (abs(label(:, 2) - label (:, 3))) + 1;     % vector of no. of mfccs for each data.
    tds = sum((kfoldindex ~= loopno) .* nmfccd);        % Train data size
    tss = sum((kfoldindex == loopno) .* nmfccd);        % Test data size
    td = zeros(tds, noofmfccs);                         % train data matrix
    tdl = zeros(tds, 1);                                % train data label vector
    ti = 1;                                             % train data index 
    
    % For each file data, seperate them into training or testing data
    % depening on the loop number. 
    for i = 1:noofdata
        % if it is a training data, add it to the list. 
        if loopno ~= kfoldindex(i)
            endindex = ti+nmfccd(i) - 1;
            td(ti:endindex, :) = features_mfccs(label(i, 2):label(i, 3), :);
            tdl(ti:endindex, 1) = label(i, 1);
            ti = ti+nmfccd(i);
        end
    end
    
    % Create a MFCCs model from the training data
    options = statset('MaxIter', size(features_mfccs, 1));
    mfccmodel = svmtrain(td, tdl, 'kernel_function', 'rbf', 'options', options);
    
    % Testing
    nooftdf = 0;
    correctcount = 0;
    correctcountfull = 0;
    for i = 1:noofdata
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