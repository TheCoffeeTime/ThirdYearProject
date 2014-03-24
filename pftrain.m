%{
Description:
    From a given array of file names (datasetpath) associate with the label
    (label), extract f0-f3 (features) and create a model (to be used to
    classification later)

    This function is used with the k-fold method where training data is
    kfoldindex is not equal to loopno. The rest are testing data. 

Parameters:
    - loopno and kfoldindex: use for comparision of what training and
      testing data to use
    - features_pf: data features (pitch and formants, f0-f3)
    - label corresponding to the data
  
Return: 
    SVM model with only pitch and formants
%}
function [pfmodel] = pftrain(loopno, features_pf, label, kfoldindex)
    ds = size(label, 1);                % data size (number of files)
    tds = sum(kfoldindex ~= loopno);    % training data size
    td = zeros(tds, 4);                 % vector of training data
    tdl = zeros(tds, 1);                % training data label;
    tdi = 1;                            % current training data index
    
    % Fill training data array
    for i = 1:ds
        % if it is a testing data
        if kfoldindex(i) ~= loopno
            td(tdi) = features_pf(i);
            tdl(tdi) = label(i);
            tdi = tdi + 1;
        end
    end
    
    pfmodel = svmtrain(td, tdl, 'kernel_function', 'rbf');