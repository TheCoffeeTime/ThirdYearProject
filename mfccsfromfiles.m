%{
    A function which return a set of mfccs for each files.
    - Each file is broken into frames. Calculate MFCC for each frame
    - Make sure the label stay the same for each frame. 
    - Do this to all the given files stored in arrayoffilepath
    - Group the set of mfccs together and return as on variable
%}
function [arrayofmfccs, arrayofmfcclabel] = mfccsfromfiles(arrayoffilepath, arrayoflabel, noofmfcccoeff)

    nooffile = size(arrayoffilepath, 1);        % Total number of tiles
    maxnoofmfccs = nooffile * 500;              % An estimation number of mfccs
    temparrayofmfccs = ...                      % The result with more space needed
        zeros(maxnoofmfccs, noofmfcccoeff);     
    arrayofmfcclabel = zeros(nooffile, 3);      % Label of each file, start index and ending index
    arrayofmfcclabel(:, 1) = arrayoflabel;      % Set the first column to be the label
    startindex = 1;                             % initial starting index
    endindex = 0;                               % This variable will be recalculated 
                                                % stright away when entering the loop
    
    Tw = 25;           % analysis frame duration (ms)
    Ts = 10;           % analysis frame shift (ms)
    alpha = 0.97;      % preemphasis coefficient
    R = [ 300 3700 ];  % frequency range to consider
    M = 20;            % number of filterbank channels 
    C = 13;            % number of cepstral coefficients
    L = 22;            % cepstral sine lifter parameter

    % hamming window (see Eq. (5.2) on p.73 of [1])
    hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    
    textprogressbar('extracting MFCCs: ');
    percentconstant = 100/nooffile;
    i = 1;
    for file = arrayoffilepath'
        textprogressbar(i*percentconstant);
        
        % Read wave from a file then extract mfcc
        [data, FS] = readwav(char(file));
        data = data(:, 1);
        [ MFCCs, FBEs, frames ] = ...
               mfcc( data, FS, Tw, Ts, alpha, hamming, R, M, C, L );
        
        % Calculate where the ending index is.   
        MFCCs = MFCCs';
        thismfccsize = size(MFCCs, 1);  
        endindex = endindex + thismfccsize;
        
        % Update the starting and ending index of this file 
        arrayofmfcclabel(i, 2) = startindex;
        arrayofmfcclabel(i, 3) = endindex;
        
        % Store the mfcc into the array which will be return 
        temparrayofmfccs(startindex:endindex, :) = MFCCs;
        
        % Calculate where the next start index will be
        startindex = startindex + thismfccsize;
        i = i+1;
    end
    textprogressbar('done');
    
    arrayofmfccs = temparrayofmfccs(1:endindex, :);
    
end