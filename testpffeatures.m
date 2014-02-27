%{
%}
function [accuracy] = testpffeatures(loopno, features_pf, label, kfoldindex)
    ds = size(label, 1);                % data size (number of files)
    tds = sum(kfoldindex ~= loopno);    % training data size
    tss = sum(kfoldindex == loopno);    % testig data size
    td = zeros(tds, 1);                 % vector of training data
    tdl = zeros(tds, 1);                % training data label;
    tdi = 1;                            % current training data index
    
    % Fill td and ts array
    for i = 1:ds
        % if it is a testing data
        if kfoldindex(i) ~= loopno
            td(tdi) = features_pf(i);
            tdl(tdi) = label(i);
            tdi = tdi + 1;
        end
    end
    
    pfmodel = svmtrain(td, tdl, 'kernel_function', 'rbf');
    
    % Testing phase
    correctcount = 0;
    for i = 1:ds
        %if it is a testing data
        if kfoldindex(i) == loopno
            predictedlabel = svmclassify(pfmodel, features_pf(i));
            if(predictedlabel == label(i))
                correctcount = correctcount + 1;
            end
        end
    end
    accuracy = correctcount / tss;
end