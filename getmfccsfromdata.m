%{
Description:
    - Extract MFCCs from a given data and Frame rate.

Parameter: 
    - data: speech sample 
    - FS: sample rate.

Return
    - array of MFCCs extracted from file. 
%}
function [MFCCs] = getmfccsfromdata(data, FS)
    Tw = 25;           % analysis frame duration (ms)
    Ts = 10;           % analysis frame shift (ms)
    alpha = 0.97;      % preemphasis coefficient
    R = [ 300 3700 ];  % frequency range to consider
    M = 20;            % number of filterbank channels 
    C = 13;            % number of cepstral coefficients
    L = 22;            % cepstral sine lifter parameter
    
    % hamming window (see Eq. (5.2) on p.73 of [1])
    hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    
   [ MFCCs, FBEs, frames ] = mfcc( data, FS, Tw, Ts, alpha, hamming, R, M, C, L );
   MFCCs = MFCCs';
end