%{
Description
    From a given speech signal along with framerate, do a classification
    using a given model. 

Parameters:
    - audioData: The audio data wanted to be classified
    - FS: frame rate
    - sysmsg: User message
    - model: SVM of MFCCs model
%}
function [label, confidence] = classifyMFCC(audioData, FS, sysmsg, model)
    set(sysmsg, 'String', 'Extracting MFCC...');
    feature_mfcc = getmfccsfromdata(audioData, FS);
    set(sysmsg, 'String', 'Classifying...');
    [label, confidence] = testMFCC(feature_mfcc, model);
    str = ['with ' num2str(confidence * 100) '% confidence'];
    if label == 1
        set(sysmsg, 'String', ['Result<MFCC>: Adult ' str]);
    elseif label == 0
        set(sysmsg, 'String', ['Result<MFCC>: Child ' str]);
    end
end