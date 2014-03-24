%{
Description:
    - Validate a given feature set using svm. 
    - For every row of feature, test it using a given model
    - return the accuracy of whole rows. 
Parameters:
    - model: Classification model (SVM)
    - features: data features (datasize x number_of_features) (Must be
      corresponding to the model used)
    - Label corresponding to the data
Return:
    - Accuracy in percentage
%}
function [accuracy] = testpffeatures2(model, features, label)

    ds = size(label, 1);        % Data size
    correctCount = 0;           % Accuracy count
    
    % For each data, test it using SVM
    for i = 1:ds
        if svmclassify(model, features(i, :)) == label(i);
            correctCount = correctCount + 1;
        end
    end
    accuracy = correctCount * 100 / ds;
end