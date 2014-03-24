% Test silent removal function
filepath = '/Users/Thanakorn/Documents/MATLAB/speech-data/testAdult/2.wav';
[x, fs] = audioread(filepath);
segment1 = detectVoiced(x, fs, 0); 
a = combinedCArr(segment1);