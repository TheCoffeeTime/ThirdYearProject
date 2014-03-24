%{
Description:
    - A function which return a set of mfccs for each files.
    - Each file is broken into frames. Calculate MFCC for each frame
    - Make sure the label stay the same for each frame. 
    - Do this to all the given files stored in arrayoffilepath
    - Group the set of mfccs together and return as on variable

Parameter:
    - arrayoffilepath: Array containing file name and path
    - arrayoflabel: Array of label corresponding to arrayoffilepath
    - noofmfcccoeff total number of MFCC features wanting to be generated

Return
    - arrayofmfccs: MFCC features
    - shortlabel: array of label which has the number of rows = arrayoffilepath
    - longlabel: array of label which has number of rows =
      (arrayoffilepath.noOfRow x 500, since each file can be broken into < 500 rows)
%}
function [arrayofmfccs, shortlabel, longlabel] = mfccsfromfiles(arrayoffilepath, arrayoflabel, noofmfcccoeff)

    nooffile = size(arrayoffilepath, 1);        % Total number of tiles
    maxnoofmfccs = nooffile * 500;              % An estimation number of mfccs
    temparrayofmfccs = ...                      % The result with more space needed
        zeros(maxnoofmfccs, noofmfcccoeff);
    templonglabel = zeros(maxnoofmfccs, 1);
    shortlabel = zeros(nooffile, 3);            % Label of each file, start index and ending index
    shortlabel(:, 1) = arrayoflabel;            % Set the first column to be the label
    startindex = 1;                             % initial starting index
    endindex = 0;                               % This variable will be recalculated 
                                                % stright away when entering the loop
   
    
    textprogressbar('extracting MFCCs: ');
    percentconstant = 100/nooffile;
    i = 1;
    for file = arrayoffilepath'
        textprogressbar(i*percentconstant);
        
        % Read wave from a file then extract mfcc
        [data, FS] = readwav(char(file));
        
        % Remove silence
        data = detectVoiced(data, FS, 0);
        
        MFCCs = getmfccsfromdata(data, FS);
        
        % Calculate where the ending index is.   
        thismfccsize = size(MFCCs, 1);  
        endindex = endindex + thismfccsize;
        
        % Update the starting and ending index of this file 
        shortlabel(i, 2) = startindex;
        shortlabel(i, 3) = endindex;
        
        % Store the mfcc into the array which will be return 
        temparrayofmfccs(startindex:endindex, :) = MFCCs;
        templonglabel(startindex:endindex) = arrayoflabel(i);
        
        % Calculate where the next start index will be
        startindex = startindex + thismfccsize;
        i = i+1;
    end
    textprogressbar('done');
    
    arrayofmfccs = temparrayofmfccs(1:endindex, :);
    longlabel = templonglabel(1:endindex);
    
end