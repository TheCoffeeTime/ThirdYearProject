% Record your voice for 5 seconds.
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');
myRecording = getaudiodata(recObj);

%open up ui for browsing file name. 
[FileName,PathName,FilterIndex] = uigetfile();