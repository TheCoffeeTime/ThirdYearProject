
childFilePath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes-children/';
adultFilePath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts-adults/';

childFile = dir(strcat(childFilePath, '*.wav'));
adultFile = dir(strcat(adultFilePath, '*.wav'));
childPitch = zeros(size(childFile, 1), 1);
adultPitch = zeros(size(adultFile, 1), 1);
i = 1;

%For each child wav file
for file = childFile'
    [data, FS] = readwav(strcat(childFilePath, file.name));
    data = data(:, 1);
    pitch = fxpefac(data, FS);
    pitch = mean(pitch);
    childPitch(i, 1) = pitch;
    i = i+1
end

i = 1
%For each adult wav file
for file = adultFile'
    [data, FS] = readwav(strcat(adultFilePath, file.name));
    data = data(:, 1);
    pitch = fxpefac(data, FS);
    pitch = mean(pitch);
    adultPitch(i, 1) = pitch;
    i = i+1
end

 scatter(adultPitch, (1:size(adultPitch, 1)), 10, 'g');
 hold on;
 scatter(childPitch, (1:size(childPitch, 1)), 10, 'r');
 hold off;