%{
Description:
    From a given audio signal, along with frame rate,
    extract f0-f1 and then use a given model to classify it. 

Parameters:
    - audioData: The audio data wanted to be classified
    - FS: frame rate
    - sysmsg: User message
    - model: SVM of pitch and formants model

Return
    - This function doesn't return anything as it already set the user
    message
%}
function classifyPF(audioData, FS, sysmsg, model)
    feature_pf = zeros(1, 4);
    set(sysmsg, 'String', 'Extracting Pitch...');
    feature_pf(1) = getpicthfromdata(audioData, FS);
    set(sysmsg, 'String', 'Extracting Formant...');
    formant = getformantsfromdata(audioData);
    feature_pf(2:4) = formant(1:3);
    set(sysmsg, 'String', 'Classifying...');
    label = svmclassify(model, feature_pf);
    if label == 1
        set(sysmsg, 'String', 'Result<PF>: Adult');
    elseif label == 0
        set(sysmsg, 'String', 'Result<PF>: Child ');
    end
end