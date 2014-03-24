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
function [accuracy] = testpffeatures(loopno, features_pf, label, kfoldindex)
    ds = size(label, 1);                % data size (number of files)
    tss = sum(kfoldindex == loopno);    % testig data size
    
    % Training phase
    pfmodel = pftrain(loopno, features_pf, label, kfoldindex);
    pfmodel.ModelType = 'PF';
    
    % Testing phase
    correctcount = 0;
    for i = 1:ds
        %if it is a testing data
        if kfoldindex(i) == loopno
            predictedlabel = svmclassify(pfmodel, features_pf(i, :));
            if(predictedlabel == label(i))
                correctcount = correctcount + 1;
            end
        end
    end
    accuracy = correctcount / tss;
end