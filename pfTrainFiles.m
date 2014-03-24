%{
Description:
    - From a given array of file names (datasetpath) associate with the label
      (label), extract f0-f3 (features) and create a model (to be used to
      classification later)

Parameter: 
    datasetpath: array of files 
    label: array of label corresponding to the array of files

Return:
    an SVM model using only pitch and formants
%}
function [model] = pfTrainFiles(datasetpath, label)
    datasize = size(label, 1);
    feature_pf = zeros(datasize, 4);
    %Get pitch
    feature_pf(:, 1) = pitchfromfiles(datasetpath);
    %Get formants
    feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
    model = svmtrain(feature_pf, label);
    model.ModelType = 'PF';
end