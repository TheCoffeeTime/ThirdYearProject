%{
    A function which return a set of mfccs for each files.
    - Each file is broken into frames. Calculate MFCC for each frame
    - Make sure the label stay the same for each frame. 
    - Do this to all the given files stored in arrayoffilepath
    - Group the set of mfccs together and return as on variable
%}
function [arrayofmfccs, arrayofmfcclabel] = mfccsfromfiles(arrayoffilepath, arrayoflabel, noofmfcccoeff)
    arraysize = size(arrayoffilepath, 1);
    
    maxnoofmfccs = arraysize * 500;
    temparrayofmfccs = zeros(maxnoofmfccs, noofmfcccoeff);
    templabel = zeros(maxnoofmfccs, 1);
    startindex = 1;
    endindex = 0;
    
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
    percentconstant = 100/arraysize;
    i = 1;
    for file = arrayoffilepath'
        textprogressbar(i*percentconstant);
        [data, FS] = readwav(char(file));
        data = data(:, 1);
        [ MFCCs, FBEs, frames ] = ...
               mfcc( data, FS, Tw, Ts, alpha, hamming, R, M, C, L );
        
        MFCCs = MFCCs';
        thismfccsize = size(MFCCs, 1);  
        endindex = endindex + thismfccsize;
        
        %Need to do an out of bounce checking here......
        
        templabel(startindex:endindex, 1) = arrayoflabel(i, 1);
        temparrayofmfccs(startindex:endindex, :) = MFCCs;
        startindex = startindex + thismfccsize;
        i = i+1;
    end
    textprogressbar('done');
    
    arrayofmfccs = temparrayofmfccs(1:endindex, :);
    arrayofmfcclabel = templabel(1:endindex, 1);
    
end