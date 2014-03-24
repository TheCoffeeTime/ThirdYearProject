%{
Description:
    Initial configuration for the program. 
%}
function config = configfile()

config = struct('CMP', '/Users/Thanakorn/Documents/ThirdYearProject/models/01_mfcc.mat', ... % Current Model Path
                'IAFP', '/Users/Thanakorn/Documents/MATLAB/speech-data/trainChildren/ks61g3w0.wav',... % Init Audio File Path
                'NOF', 3 ...    % Number of formants
            );

end