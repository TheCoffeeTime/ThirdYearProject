function [arrayofformants] = formantsfromfiles(arrayoffilepath)
    arraysize = size(arrayoffilepath, 1);
    arrayofformants = zeros(arraysize, 3);
    i = 1;
    
    textprogressbar('extracting formants: ');
    percentconstant = 100/arraysize;
    
    for file = arrayoffilepath'
        textprogressbar(i*percentconstant);
        
        [data, FS] = readwav(char(file));
        data = data(:, 1);
        F = getformantsfromdata(data);
        arrayofformants(i, 1:3) = F(1, 1:3);
        i = i+1;
    end
    textprogressbar('done');
end