% Number of sets of data
n = 10;

%Combined all the required data into single set of data, and single set of
%label corresponding to the set of data
childfileDir = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes - children/';
adultfilesDir = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts - adults/';
childfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/childes - children/*.wav';
adultfilespath = '/Users/Thanakorn/Documents/MATLAB/speech-data/podcasts - adults/*.wav';
[dataset, label] = combineddata(childfilespath, {'child'} , adultfilespath, {'adult'});

datasize = size(label);
dataperset = floor(datasize/n);

