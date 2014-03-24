%{
Description:
    - Validate a given feature set using svm. 
    - For every row of feature, test it using a given model
    - For MFCC, we do a vote.
Parameters:
    - model: Classification model (SVM)
    - features: data features (datasize x number_of_features) (Must be
      corresponding to the model used)
    - Label corresponding to the data
Return:
    - Accuracy in percentage
%}
function [accuracy] = testmfccfeatures2(model, features_mfccs, shortlabel)
    ds = size(shortlabel, 1);       % Number of files
    correctCount = 0;               % accuracy count
    
    % For each file/data test it
    for i = 1:ds
        ts = features_mfccs(shortlabel(i, 2):shortlabel(i, 3), :);
        
        %Each file is broken down into many parts and we test it many
        %times.
        predictedlabel = testMFCC(ts, model);
        if predictedlabel == shortlabel(i, 1)
            correctCount = correctCount +1;
        end
    end
    accuracy = correctCount * 100 / ds;
end