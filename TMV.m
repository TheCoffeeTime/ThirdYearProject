%{
Description: 
    - A call back function 
    - This is called when the test my voice button is pressed
    - Record a voice for a certain period, extract features, and do a
    classifivation accoring to the model selected.
%}
function TMV()  
    global currentModelPath;
    global selectedModel;
    global recordedVoice;
    
    % Get the classifiction model path and load it. 
    CMP = findobj('Tag', 'currentModel');
    selectedModelPath = get(CMP, 'String');
    
    % Set the user message to be >>
    sysmsg = findobj('Tag', 'sysmsg');
    set(sysmsg, 'String', '>>');
    
    % boolean variable used to make the system stop when error occur. 
    hasError = false;
    
    % Load new model if the path has changed
    if strcmp(selectedModelPath, currentModelPath) ~= 1;
        try
            m = load(selectedModelPath);
            selectedModel = m.model;
            currentModelPath = selectedModelPath;
            set(sysmsg, 'String', '>> New Model');
        catch err
            set(sysmsg, 'String', err.message);
            hasError = true;
        end
    end
   
    if hasError == false
        % Record a voice. 
        set(sysmsg, 'String', '>> Start recording...');
        audioObj = recordFromMic(4);
        recordedVoice = audioObj;
        audioData = audioObj.getaudiodata;
        FS = audioObj.SampleRate;
        
        % Pre-processing
        audioData = preprocessing(audioData, FS);
        
        % if it is PF model
        if strcmp(selectedModel.ModelType, 'PF') == 1
            classifyPF(audioData, FS, sysmsg, selectedModel);
        % else if it is MFCC model
        elseif strcmp(selectedModel.ModelType, 'MFCC') == 1
            classifyMFCC(audioData, FS, sysmsg, selectedModel);
        else %Error type mis-match
            set(sysmsg, 'String', 'Error: Model type miss matched');
        end
    end