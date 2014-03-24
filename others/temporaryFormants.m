%{
addpath('/Users/Thanakorn/Downloads/voicebox');
childFilePath = '/Users/Thanakorn/Documents/3rd project/speech-data/childes - children/';
adultFilePath = '/Users/Thanakorn/Documents/3rd project/speech-data/podcasts - adults/';

childFile = dir(strcat(childFilePath, '*.wav'));
adultFile = dir(strcat(adultFilePath, '*.wav'));
childFormants = zeros(size(childFile, 1), 3);
adultFormants = zeros(size(adultFile, 1), 3);
i=1;

% In determining formants, poles are ignored if any of the following hold:
%        (a) they are on the real axis
%        (b) they have bandwidth > t*frequency (if t>0)
%        (c) they have bandwidth > -t (if t<=0)
t = 100;


%For each child wav file
for file = childFile'
    disp(i);
    [data, FS] = readwav(strcat(childFilePath, file.name));
    data = data(:, 1);
    ar_coeffs = arburg(data,12);
    [N,F,A,B] = lpcar2fm(ar_coeffs, 300);
    childFormants(i, 1) = F(1);
    childFormants(i, 2) = F(2);
    childFormants(i, 3) = F(3);
    i = i+1;
end

i = 1;
%For each adult wav file
for file = adultFile'
    disp(i);
    [data, FS] = readwav(strcat(adultFilePath, file.name));
    data = data(:, 1);
    ar_coeffs = arburg(data,12);
    [N,F,A,B] = lpcar2fm(ar_coeffs, 200);
    adultFormants(i, 1) = F(1);
    adultFormants(i, 2) = F(2);
    adultFormants(i, 3) = F(3);
    i = i+1;
end
%}
scatter3(adultFormants(:, 1), adultFormants(:, 2), adultFormants(:, 3), 10, 'r');
hold on;
scatter3(childFormants(:, 1), childFormants(:, 2), childFormants(:, 3), 10, 'g');
hold off;