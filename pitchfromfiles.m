%{
Description: 
    - For each file in the array of file path, extract pitch and return.

Parameter: 
    - arrayoffilepath: array of file names 

Return:
    - array of pitch which have the same number of rows as arrayoffilepath.
%}

function [arrayofpitch] = pitchfromfiles(arrayoffilepath)
    arraysize = size(arrayoffilepath, 1);
    arrayofpitch = zeros(arraysize, 1);
    i = 1;
    
    %textprogressbar('extracting pitch: ');
    %percentconstant = 100/arraysize;
    
    for file = arrayoffilepath'
        %textprogressbar(i*percentconstant);
        
        [data, FS] = audioread(char(file));
        
        % Pre-processing
        data = preprocessing(data, FS);
        
        pitch = getpicthfromdata(data', FS);
        
        arrayofpitch(i, 1) = pitch;
        i = i+1;
    end
    textprogressbar('done');
end