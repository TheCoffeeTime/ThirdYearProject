%{
Description:
    - For each files in the array of file path, extract formants from them

Paramter:
    - arrayoffilepath: Array of file 

Return
    - arrayofformants: Array of formants which has the same number of rows
      as the arrayoffilepath
%}
function [arrayofformants] = formantsfromfiles(arrayoffilepath)
    config = configfile();
    noOfFormants = config.NOF;
    arraysize = size(arrayoffilepath, 1);
    arrayofformants = zeros(arraysize, noOfFormants);
    i = 1;
    
    %textprogressbar('extracting formants: ');
    %percentconstant = 100/arraysize;
    
    for file = arrayoffilepath'
        %textprogressbar(i*percentconstant);
        
        [data, FS] = readwav(char(file));
        
        % Pre-processing
        data = preprocessing(data, FS);
        
        F = getformantsfromdata(data);
        arrayofformants(i, 1:noOfFormants) = F(1, 1:noOfFormants);
        i = i+1;
    end
    textprogressbar('done');
end