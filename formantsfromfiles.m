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
        ar_coeffs = arburg(data,12);
        [N,F,A,B] = lpcar2fm(ar_coeffs, 200);
        arrayofformants(i, 1:3) = F(1, 1:3);
        i = i+1;
    end
    textprogressbar('done');
end