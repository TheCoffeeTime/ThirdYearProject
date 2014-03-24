%{
Description:
    - Record a voice using the build in microphone.
Parameter: 
    - s: number of second for recording. 
%}
function [recObj] = recordFromMic(s) 
    FR = 16000;
    nBits = 16;
    nChannels = 1;
    recObj = audiorecorder(FR, nBits, nChannels);
    record(recObj);
    pause(s);
    stop(recObj);
end