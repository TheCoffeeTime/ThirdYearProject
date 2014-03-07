function [model] = pfTrainFiles(datasetpath, label)
    datasize = size(label, 1);
    feature_pf = zeros(datasize, 4);
    feature_pf(:, 1) = pitchfromfiles(datasetpath);
    feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
    model = svmtrain(feature_pf, label);
    model.ModelType = 'PF';
end