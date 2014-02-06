%{
    - Get a mean pitch for each files given. 
%}

function [arrayofpitch] = pitchfromfiles(arrayoffilepath)
    arraysize = size(arrayoffilepath, 1);
    arrayofpitch = zeros(arraysize, 1);
    i = 1;
    textprogressbar('extracting pitch: ');
    percentconstant = 100/arraysize;
    for file = arrayoffilepath'
        textprogressbar(i*percentconstant);
        [data, FS] = readwav(char(file));
        data = data(:, 1);
        pitch = fxpefac(data', FS);
        pitch = mean(pitch);
        arrayofpitch(i, 1) = pitch;
        i = i+1;
    end
    textprogressbar('done');
end