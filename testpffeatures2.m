function [accuracy] = testpffeatures2(model, features, label)
    ds = size(label, 1);
    correctCount = 0;
    for i = 1:ds
        if svmclassify(model, features(i, :)) == label(i);
            correctCount = correctCount + 1;
        end
    end
    accuracy = correctCount * 100 / ds;
end