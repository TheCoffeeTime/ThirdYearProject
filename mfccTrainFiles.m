%{
Description
    From a given array of file path (datasetpath) corresponding with the
    label (label), extract mfcc features and create a model using SVM

Parameter: 
    datasetpath: Array of data
    label: array of label corresponding to the datasetpath

Return: 
    a SVM model containing MFCCs data
%}
function [model] = mfccTrainFiles(datasetpath, label)
    noofmfcccoeff = 13;
    [feature_mfccs, shortlabel, longlabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
    options = statset('MaxIter', size(feature_mfccs, 1));
    try
        model = svmtrain(feature_mfccs, longlabel, 'kernel_function', 'rbf', 'options', options);
    catch
        options = statset('MaxIter', size(feature_mfccs, 1) * 3);
        model = svmtrain(feature_mfccs, longlabel, 'kernel_function', 'rbf', 'options', options);
    end
    model.ModelType = 'MFCC';
end