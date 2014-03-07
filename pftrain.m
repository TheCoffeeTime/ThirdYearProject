%{
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