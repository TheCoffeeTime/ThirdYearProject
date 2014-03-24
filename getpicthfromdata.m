%{
Description:
    - From a given speech data and frame rate, 
      extract pitch, calculate the average of the pitch, and return it. 

Parameter: 
    - data: Speech sample data
    - FS: sample rate

Return: 
    - estimated pitch
%}
function [pitch] = getpicthfromdata(data, FS)
    pitch = fxpefac(data, FS);
    pitch = mean(pitch);
end