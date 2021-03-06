%{
Description:
    - THIS FILE IS NOT A FUNCTION
    - This file is the main UI of the program.
    - This file is broken down into 2 parts, 
    - 1st part is the structure of the UI
    - 2nd part is the call back funtion
%}

function projectUI()
%Init----------------------------------------------------------------------
% The main panel is 800 x 600
f = figure('Position', [100, 100, 800, 600]);
set(f, 'MenuBar', 'none', 'name', 'Who is speaking, Adult or Child?', 'numbertitle','off');
config = configfile();

% For efficiency, it is better to have a global model path and model
% so that we don't have to download them every time if it is the same model
global currentModelPath;
global selectedModel;
currentModelPath = config.CMP;
initAudioFilePath = config.IAFP;
m= load(currentModelPath);
selectedModel = m.model;


% Set up the most outer layer, mainPanel. 
% Main panel contains menuBox on the left and contentBox on the right
% Content box contain cardPanel at the top and system message at the bottom
mainPanel = uiextras.HBox( 'Parent', f );
menuBox = uiextras.VBox( 'Parent', mainPanel, 'Padding', 5);
contentBox = uiextras.VBox('Parent', mainPanel, 'Padding', 5);
cardPanel = uiextras.CardPanel( 'Parent', contentBox, 'Padding', 5);
mainPanel.Sizes = [150, -1];
sysmsgPanel = uiextras.Panel('Parent', contentBox, 'Title', 'Output', 'FontSize', 20);
SP1 = uicontrol('String', '>>', 'Parent', sysmsgPanel, 'Style', 'Text', ...
          'FontSize', 15, 'HorizontalAlignment', 'left', 'Tag', 'sysmsg');
contentBox.Sizes = [-1, 150];

% Set up the Menu Box by 3 buttons and 4 empty space
% Also register all the buttons to a call back function
MB1 = uiextras.VBox( 'Parent', menuBox, 'Padding', 2);
MB2 = uiextras.VBox( 'Parent', menuBox, 'Padding', 2);
MB3 = uiextras.Empty( 'Parent', menuBox );
menuBox.Sizes = [-3, -2, -5];
MB10 = uicontrol( 'Style', 'text', 'String', 'Testing', 'Parent', MB1, ...
                    'HorizontalAlignment', 'left', 'FontSize', 15);
MB11 = uicontrol( 'String', 'Online Testing', 'Callback', {@onlinebtn_callback,cardPanel}, ...
                  'Parent', MB1, 'FontSize', 15);
MB12 = uicontrol( 'String', 'Offline Testing', 'Callback', {@offlinebtn_callback,cardPanel}, ...
                   'Parent', MB1, 'FontSize', 15);
MB1.Sizes = [-1, -5, -5];
MB20 = uicontrol( 'Style', 'text', 'String', 'Training', 'Parent', MB2, ...
                  'HorizontalAlignment', 'left', 'FontSize', 15);
MB21 = uicontrol( 'String', 'Create & Evaluate a model', 'FontSize', 15, ...
                  'Callback', {@cmodelbtn_callback,cardPanel}, 'Parent', MB2);
MB2.Sizes = [-1, -5];

% add 3 panels to the cardPanel
% Online, Offline, and Create model. 
CP1 = uiextras.Panel('Parent', cardPanel);
CP2 = uiextras.Panel('Parent', cardPanel);
CP3 = uiextras.Panel('Parent', cardPanel);
cardPanel.SelectedChild = 1;


% Setting for offline panel------------------------------------------------
CP21 = uiextras.VBox( 'Parent', CP2);
CP211 = uiextras.Panel('Parent', CP21);
%Header
CP2111 = uicontrol('String', 'Offline Testing', 'Parent', CP211, 'Style', 'Text', ...
          'FontSize', 40, 'HorizontalAlignment', 'left');
CP212 = uiextras.VBox( 'Parent', CP21);
CP21.Sizes = [50, -1];
uiextras.Empty( 'Parent', CP212);
CP2121 = uiextras.Panel('Parent', CP212, 'FontSize', 16, ...
                        'Title', 'Currently selected testing file');
uiextras.Empty( 'Parent', CP212);
CP2122 = uiextras.Panel('Parent', CP212, 'FontSize', 16, ...
                        'Title', 'Currently selected model');
uiextras.Empty( 'Parent', CP212);
CP2123 = uiextras.Panel('Parent', CP212, 'Padding', 5, 'BorderType', 'none');
CP21211 = uiextras.HBox('Parent', CP2121, 'Padding', 50);
CP21221 = uiextras.HBox('Parent', CP2122, 'Padding', 50);
CP21231 = uicontrol( 'String', 'Test', 'Callback', @TAF_callback, 'Parent', CP2123, 'FontSize', 15);
CP212.Sizes = [-1, 160, -1, 160, -1, 60];
CP212111 = uicontrol( 'String', 'play', 'Callback', @playAudio_callback, 'Parent', CP21211, 'FontSize', 15);
CP212112 = uicontrol( 'String',initAudioFilePath, 'BackgroundColor', 'w', 'Style', 'edit', ...
                      'Parent', CP21211, 'FontSize', 12, 'Tag', 'currentAFile');
CP212113 = uicontrol( 'String', 'Browse', 'Callback', {@browseWAV_callback, CP212112}, ...
                      'Parent', CP21211, 'FontSize', 15);
CP21211.Sizes = [-1, -10, -1];
CP212211 = uiextras.VBox('Parent', CP21221);
CP212212 = uicontrol( 'String', currentModelPath, 'BackgroundColor', 'w', 'Style', 'edit', ...
                      'Parent', CP21221, 'FontSize', 12, 'Tag', 'currentModel');
CP212213 = uicontrol( 'String', 'Browse', 'Callback', {@browseMAT_callback, CP212212}, ...
                      'Parent', CP21221, 'FontSize', 15);
CP21221.Sizes = [-1, -10, -1];

% Setting for online panel-------------------------------------------------
CP11 = uiextras.VBox( 'Parent', CP1);
CP111 = uiextras.Panel('Parent', CP11);
CP112 = uiextras.HBox('Parent', CP11);
CP11.Sizes = [50, -1];
%Header
CP1111 = uicontrol('String', 'Online Testing', 'Parent', CP111, 'Style', 'Text', ...
          'FontSize', 40, 'HorizontalAlignment', 'left');
CP1121 = uiextras.Empty( 'Parent', CP112 );
CP1122 = uiextras.VBox('Parent', CP112);
CP1123 = uiextras.Empty( 'Parent', CP112);
CP112.Sizes = [-1, -3, -1];
CP11221 = uicontrol( 'String', 'Test my voice', 'Callback', @TMV_callback, ...
                     'Parent', CP1122, 'FontSize', 15);
CP11222 = uiextras.HBox('Parent', CP1122);
CP1122.Sizes = [-1, 50];
CP112221 = uicontrol('String', 'Play', 'Parent', CP11222, 'Callback', @playBack_callback,...
                     'FontSize', 15);
CP112222 = uicontrol('Parent', CP11222 ,'String', 'Select a model', ...
                      'Callback', {@browseMAT_callback, CP212212},'FontSize', 15);
CP11222.Sizes = [-1, -4];

% Setting for create model-------------------------------------------------
trainAPath = '/Users/Thanakorn/Documents/MATLAB/speech-data/trainAdult/';
trainCPath = '/Users/Thanakorn/Documents/MATLAB/speech-data/trainChildren/';
testAPath = '/Users/Thanakorn/Documents/MATLAB/speech-data/testAdult/';
testCPath = '/Users/Thanakorn/Documents/MATLAB/speech-data/testChildren/';
CP31 = uiextras.VBox( 'Parent', CP3, 'Padding', 10);
CP311 = uiextras.Panel('Parent', CP31, 'Title', 'Create a model', 'FontSize', 16);
CP312 = uiextras.Panel('Parent', CP31, 'Title', 'Evaluate a model', 'FontSize', 16);
CP31.Sizes = [-5, -3];
CP3111 = uiextras.VBox('Parent', CP311);
CP3121 = uiextras.VBox('Parent', CP312);
uiextras.Empty( 'Parent', CP3111);
CP31111 = uiextras.HBox('Parent', CP3111);
CP31112 = uiextras.HBox('Parent', CP3111);
CP31113 = uiextras.HBox('Parent', CP3111);
CP31114 = uiextras.Panel('Parent', CP3111, 'Title', 'Model Features', 'FontSize', 15);
uiextras.Empty( 'Parent', CP3111);
CP3111.Sizes = [-1, 35, 35, 35, 80, -1];
CP311111 = uicontrol('Style', 'Text', 'Parent', CP31111, 'String', ...
                     'Model name', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP311112 = uicontrol('Style', 'Edit', 'Parent', CP31111, 'BackgroundColor', 'w', 'Tag', 'modelName');
CP311113 = uicontrol('Parent', CP31111, 'String', 'Create a model', 'FontSize', 15, ...
                     'Callback', @createModel_callback);
CP31111.Sizes = [-2, -7, -3];

CP311121 = uicontrol('Style', 'Text', 'Parent', CP31112, 'String', ...
                     'Adult Data', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP311122 = uicontrol('Style', 'Edit', 'Parent', CP31112, 'BackgroundColor', 'w', ...
                     'String', trainAPath, 'Tag', 'TrnADP');
CP311123 = uicontrol('Parent', CP31112, 'String', 'Browse', 'FontSize', 15, ...
                     'Callback', {@SFP_callback, CP311122});
CP31112.Sizes = [-2, -7, -3];

CP311131 = uicontrol('Style', 'Text', 'Parent', CP31113, 'String', ...
                     'Child Data', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP311132 = uicontrol('Style', 'Edit', 'Parent', CP31113, 'BackgroundColor', 'w',...
                     'String', trainCPath, 'Tag', 'TrnCDP');
CP311133 = uicontrol('Parent', CP31113, 'String', 'Browse', 'FontSize', 15,...
                     'Callback', {@SFP_callback, CP311132});
CP31113.Sizes = [-2, -7, -3];

CP311141 = uiextras.VBox('Parent', CP31114);
CP3111411 = uicontrol('Parent', CP311141, 'Style', 'checkbox', ...
                      'String', 'MFCC', 'Tag', 'MFCCselected', 'FontSize', 15);
CP3111412 = uicontrol('Parent', CP311141, 'Style', 'checkbox', 'FontSize', 15, ...
                      'String', 'Pitch and Formants', 'Tag', 'PFSelected');

uiextras.Empty( 'Parent', CP3121);
CP31211 = uiextras.HBox('Parent', CP3121);
CP31212 = uiextras.HBox('Parent', CP3121);
CP31213 = uiextras.HBox('Parent', CP3121);
uiextras.Empty( 'Parent', CP3121);
CP3121.Sizes = [-1, 35, 35, 35, -1];

CP312111 = uicontrol('Style', 'Text', 'Parent', CP31211, 'String', ...
                     'Model', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP312112 = uicontrol('Style', 'Edit', 'Parent', CP31211, 'BackgroundColor', 'w',...
                     'Tag', 'modeltobeEvaulated');
CP312113 = uicontrol('Parent', CP31211, 'String', 'Browse', 'FontSize', 15,...
                     'Callback', {@browseMAT_callback, CP312112});
CP312114 = uicontrol('Parent', CP31211, 'String', 'Evaluate a model', 'FontSize', 15,...
                     'Callback', @evaluateModel_callback);
CP31211.Sizes = [-2, -7, -1, -2];

CP312121 = uicontrol('Style', 'Text', 'Parent', CP31212, 'String', ...
                     'Adult data', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP312122 = uicontrol('Style', 'Edit', 'Parent', CP31212, 'BackgroundColor', 'w', ... 
                     'String', testAPath, 'Tag', 'TstADP');
CP312123 = uicontrol('Parent', CP31212, 'String', 'Browse', 'FontSize', 15,...
                     'Callback', {@SFP_callback, CP312122});
CP31212.Sizes = [-2, -7, -3];

CP312131 = uicontrol('Style', 'Text', 'Parent', CP31213, 'String', ...
                     'Child data', 'HorizontalAlignment', 'center', 'FontSize', 15);
CP312132 = uicontrol('Style', 'Edit', 'Parent', CP31213, 'BackgroundColor', 'w', ...
                     'String', testCPath, 'Tag', 'TstCDP');
CP312133 = uicontrol('Parent', CP31213, 'String', 'Browse', 'FontSize', 15, ...
                     'Callback', {@SFP_callback, CP312132});
CP31213.Sizes = [-2, -7, -3];


% CALL BACK FUNCTION-------------------------------------------------------
% Online test button pressed
function onlinebtn_callback(hObject, eventdata, handles)
    handles.SelectedChild = 1;
    
% Offline test button pressed
function offlinebtn_callback(hObject, eventdata, handles)
    handles.SelectedChild = 2;
    
% Create model button pressed
function cmodelbtn_callback(hObject, eventdata, handles)
    handles.SelectedChild = 3;
    
% Online test; Test my voice button pressed
function TMV_callback(hObject, eventdata, handles)
    TMV();  
   
% Select model path
function browseMAT_callback(hObject, eventdata, handles)
    startpath = '/Users/Thanakorn/Documents/ThirdYearProject/models';
    [filename, pathname] = uigetfile('*.mat', 'mytitle', startpath);
    if filename ~= 0
        fnp = strcat(pathname, filename);
        set(handles, 'String', fnp);
    end
  
% Select audio file path
function browseWAV_callback(hObject, eventdata, handles)
    startpath = '/Users/Thanakorn/Documents/MATLAB/speech-data/testChildren';
    [filename, pathname] = uigetfile('*.wav', 'mytitle', startpath);
    if filename ~= 0
        fnp = strcat(pathname, filename);
        set(handles, 'String', fnp);
    end

% Play selected audio file
function playAudio_callback(hObject, eventdata, handles)
    CFPObj = findobj('Tag', 'currentAFile');
    sysmsg = findobj('Tag', 'sysmsg');
    fnp = get(CFPObj, 'String');
    try
        
        [y, Fs] = audioread(fnp);
        sound(y, Fs);
    catch err
        sysmsg = findobj('Tag', 'sysmsg');
        set(sysmsg, 'String', err.message);
    end

function TAF_callback(hObject, eventdata, handles)
    TAF();
    
function createModel_callback(hObject, eventdata, handles)
    savePath = '/Users/Thanakorn/Documents/ThirdYearProject/models/';
    sysmsg = findobj('Tag', 'sysmsg');
    mfccObj = findobj('Tag', 'MFCCselected');
    pfObj = findobj('Tag', 'PFSelected');
    TrnADPObj = findobj('Tag', 'TrnADP');
    TrnCDPObj = findobj('Tag', 'TrnCDP');
    modelName = findobj('Tag', 'modelName');
    modelName = get(modelName, 'String');
    Apath = strcat(get(TrnADPObj, 'String'), '*.wav');
    Cpath = strcat(get(TrnCDPObj, 'String'), '*.wav');
    [datasetpath, label] = combineddata(Apath, 1, Cpath, 0);
    
    if(get(mfccObj, 'Value') == 1)
        set(sysmsg, 'String', 'Creating MFCC model...');
        name = strcat(modelName, '_mfcc');
        model = mfccTrainFiles(datasetpath, label);
        savemodel(model, name, savePath);
    end
    
    if(get(pfObj, 'Value') == 1)
        set(sysmsg, 'String', 'Creating PF model...');
        name = strcat(modelName, '_pf');
        model = pfTrainFiles(datasetpath, label);
        savemodel(model, name, savePath);
    end
    
function evaluateModel_callback(hObject, eventdata, handles)
    sysmsg = findobj('Tag', 'sysmsg');
    set(sysmsg, 'String', 'Evaluating model...');
    pause(2);
    TstADPObj = findobj('Tag', 'TstADP');
    TstCDPObj = findobj('Tag', 'TstCDP');
    modelPath = findobj('Tag', 'modeltobeEvaulated');
    
    Apath = strcat(get(TstADPObj, 'String'), '*.wav');
    Cpath = strcat(get(TstCDPObj, 'String'), '*.wav');
    
    % If statement determining if the file path 
    
    
    if strcmp(Apath, '') == 0 && strcmp(Cpath, '') == 0
        [datasetpath, label] = combineddata(Apath, 1, Cpath, 0);
    elseif strcmp(Apath, '') == 1 && strcmp(Cpath, '') == 0
        [datasetpath, label] = combineddata(Cpath, 0);
    elseif strcmp(Apath, '') == 0 && strcmp(Cpath, '') == 1
        [datasetpath, label] = combineddata(Apath, 1);
    else
        err = MException('Test data path not given');
        throw(err);
    end
    
    m = load(get(modelPath, 'String'));
    selectedModel = m.model;
    
    if strcmp(selectedModel.ModelType, 'PF') == 1
        datasize = size(label, 1);
        feature_pf = zeros(datasize, 4);
        feature_pf(:, 1) = pitchfromfiles(datasetpath);
        feature_pf(:, 2:4) = formantsfromfiles(datasetpath);
        accuracy = testpffeatures2(selectedModel, feature_pf, label);
        set(sysmsg, 'String', num2str(accuracy));
    end
    
    if strcmp(selectedModel.ModelType, 'MFCC') == 1
        noofmfcccoeff = 13;
        [feature_mfccs, mfccslabel] = mfccsfromfiles(datasetpath, label, noofmfcccoeff);
        accuracy = testmfccfeatures2(selectedModel, feature_mfccs, mfccslabel);
        set(sysmsg, 'String', num2str(accuracy));
    end

% Play back the most recent recorded from the test my voice. 
function playBack_callback(hObject, eventdata, handles)
    global recordedVoice;
    audioData = recordedVoice.getaudiodata;
    FS = recordedVoice.SampleRate;
    sound(audioData, FS);
    
% Select a folder path and return reset the string in the handle. 
function SFP_callback(hObject, eventdata, handles)
    startpath = '/Users/Thanakorn/Documents/MATLAB/speech-data';
    foldername = uigetdir(startpath);
    if(isa(foldername, 'double') == 0)
        foldername = strcat(foldername, '/');
    else
        foldername = '';
    end
    set(handles, 'String', foldername);