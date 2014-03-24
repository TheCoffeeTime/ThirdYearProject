%{
Description:
    - From a given array of file path (datasetpath) corresponding with the
     label (label), extract mfcc features and create a model using SVM
    - This function is used only with the k-fold cross validation

Parameters:
    - loopno and kfoldindex: use for comparision of what training and
      testing data to use
    - features_pf: data features (MFCC)
    - label corresponding to the data

Return
    - MFCCs model 
    
%}
function [mfccmodel] = mfccTrainCrossV(loopno, features_mfccs, label, kfoldindex)
    
    noofdata = size(label, 1);
    noofmfccs = size(features_mfccs, 2);
    nmfccd = (abs(label(:, 2) - label (:, 3))) + 1;     % vector of no. of mfccs for each data.
    tds = sum((kfoldindex ~= loopno) .* nmfccd);        % Train data size
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