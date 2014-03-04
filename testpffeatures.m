%{
%}
function [accuracy] = testpffeatures(loopno, features_pf, label, kfoldindex)
    ds = size(label, 1);                % data size (number of files)
    tss = sum(kfoldindex == loopno);    % testig data size
    
    pfmodel = pftrain(loopno, features_pf, label, kfoldindex);
    %savemodel(pfmodel, strcat('pf_', num2str(loopno)), '/Users/Thanakorn/Documents/ThirdYearProject/models/');
    
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