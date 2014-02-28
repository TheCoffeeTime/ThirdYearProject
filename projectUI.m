function projectUI()
%Init----------------------------------------------------------------------
% The main panel is 800 x 600
f = figure('Position', [100, 100, 800, 600]);

% Set up the most outer layer, mainPanel. 
% Main panel contains menuBox on the left and cardPanel on the right
mainPanel = uiextras.HBox( 'Parent', f );
menuBox = uiextras.VBox( 'Parent', mainPanel, 'Padding', 5);
cardPanel = uiextras.CardPanel( 'Parent', mainPanel, 'Padding', 5 );
mainPanel.Sizes = [150, -1];

% Set up the Menu Box by 3 buttons and 4 empty space
% Also register all the buttons to a call back function
uiextras.Empty( 'Parent', menuBox );
uicontrol( 'String', 'Real time', 'Callback', {@RTB_callback,cardPanel}, 'Parent', menuBox );
uiextras.Empty( 'Parent', menuBox );
uicontrol( 'String', 'Simulation', 'Callback', {@SB_callback,cardPanel}, 'Parent', menuBox );
uiextras.Empty( 'Parent', menuBox );
uicontrol( 'String', 'New model', 'Callback', {@NMB_callback,cardPanel}, 'Parent', menuBox );
uiextras.Empty( 'Parent', menuBox );

% add 3 panels to the cardPanel
% Real time, Simulation, and New Model
RTPanel = uiextras.Panel('Parent', cardPanel);
SPanel = uiextras.Panel('Parent', cardPanel);
NMPanel = uiextras.Panel('Parent', cardPanel);


% Setting for Real time panel----------------------------------------------
RTP1 = uiextras.VBox( 'Parent', RTPanel);
RTP2 = uiextras.Panel('Parent', RTP1);
RTP3 = uiextras.HBox('Parent', RTP1);
RTP4 = uiextras.Panel('Parent', RTP1, 'Title', 'Output', 'FontSize', 20);
RTP1.Sizes = [50, -2, -1];
%Header
uicontrol('String', 'Real time', 'Parent', RTP2, 'Style', 'Text', ...
          'FontSize', 40, 'HorizontalAlignment', 'left');
RTP5 = uiextras.Empty( 'Parent', RTP3 );
RTP6 = uiextras.VBox('Parent', RTP3);
RTP7 = uiextras.Empty( 'Parent', RTP3);
RTP3.Sizes = [-1, -3, -1];
RTP8 = uicontrol( 'String', 'Test my voice', 'Callback', {@NMB_callback,cardPanel}, 'Parent', RTP6);
RTP9 = uicontrol( 'String', 'select a model', 'Callback', {@NMB_callback,cardPanel}, 'Parent', RTP6 );
RTP6.Sizes = [-1, 50];
outputMsg = uicontrol('String', '>>', 'Parent', RTP4, 'Style', 'Text', ...
          'FontSize', 15, 'HorizontalAlignment', 'left');


% Setting for Simulation panel---------------------------------------------
SP1 = uiextras.VBox( 'Parent', SPanel);
SP2 = uiextras.Panel('Parent', SP1);
%Header
uicontrol('String', 'Simulation', 'Parent', SP2, 'Style', 'Text', ...
          'FontSize', 40, 'HorizontalAlignment', 'left');
SP3 = uiextras.VBox( 'Parent', SP1);
SP4 = uiextras.Panel('Parent', SP1, 'Title', 'Output', 'FontSize', 20);
SP1.Sizes = [50, -2, -1];
SP3_1 = uiextras.Panel('Parent', SP3, 'Padding', 40, 'BorderType', 'none');
SP3_2 = uiextras.Panel('Parent', SP3, 'Padding', 40, 'BorderType', 'none');
SP3_3 = uiextras.Panel('Title', 'Currently selected testing file', ...
                       'Padding', 10, 'Parent', SP3_1, 'FontSize', 16);
SP3_4 = uiextras.Panel('Title', 'Currently selected model', ...
                       'Padding', 10, 'Parent', SP3_2, 'FontSize', 16);
SP3_5 = uiextras.Panel('Parent', SP3, 'Padding', 5, 'BorderType', 'none');
SP5 = uiextras.HBox('Parent', SP3_3);
SP6 = uiextras.HBox('Parent', SP3_4);
SP7 = uiextras.HBox('Parent', SP3_5);
SP3.Sizes = [-1, -1, 50];
SP8 = uicontrol( 'String', 'play', 'Callback', {@NMB_callback,cardPanel}, 'Parent', SP5);
SP9 = uicontrol( 'String', '/path/', 'BackgroundColor', 'w', 'Style', 'edit', ...
                 'Parent', SP5, 'FontSize', 12);
SP10 = uicontrol( 'String', 'browse', 'Callback', {@NMB_callback,cardPanel}, 'Parent', SP5);
SP5.Sizes = [-1, -10, -1];
SP11 = uiextras.VBox('Parent', SP6);
SP12 = uicontrol( 'String', '/path/', 'BackgroundColor', 'w', 'Style', 'edit', ...
                 'Parent', SP6, 'FontSize', 12);
SP13 = uicontrol( 'String', 'browse', 'Callback', {@NMB_callback,cardPanel}, 'Parent', SP6);
SP6.Sizes = [-1, -10, -1];
SP14 = uicontrol( 'String', 'Test', 'Callback', {@NMB_callback,cardPanel}, 'Parent', SP7);
outputMsg2 = uicontrol('String', '>>', 'Parent', SP4, 'Style', 'Text', ...
          'FontSize', 15, 'HorizontalAlignment', 'left');

% CALL BACK FUNCTION-------------------------------------------------------
% Real time button pressed
function RTB_callback(hObject, eventdata, handles)
handles.SelectedChild = 1;
% Simulation button pressed
function SB_callback(hObject, eventdata, handles)
handles.SelectedChild = 2;
% New model button pressed
function NMB_callback(hObject, eventdata, handles)
handles.SelectedChild = 3;
