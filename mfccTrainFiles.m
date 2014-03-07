function [model] = mfccTrainFiles(datasetpath, label)
    noofmfcccoeff = 13;
    [feature_mfccs, shortlabel, longlabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
    options = statset('MaxIter', size(feature_mfccs, 1));
    model = svmtrain(feature_mfccs, longlabel, 'kernel_function', 'rbf', 'options', options);
    model.ModelType = 'MFCC';
end