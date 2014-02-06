%{
    - For every path given as a parameter, get all the file names, 
      connect each file name with their path, and group them together. 
    - Return the group as the data set path, and label. 
    - varargin is an infinite number of arguments
    - The given path MUST contain '*' to indicate file format needed. 
    - Read given arguments in pair which "are directory path" and label
      of all the files in that directory (must be the same). (Well if they
      are not the same, why do you keep them in the same directory?)

    Example
    childfilepath = '/PATH/*.wav';
    adultfilepath = '/PATH2/*.wav';
    adultfilepath2 = '/PATH3/*.wav';
    [data, label] = combineddata(childfilepath, {'child'} , ...
                                 adultfilepath, {'adult'}, ...
                                 adultfilepath2,{'adult'});
    
    where 1 and 2 represent the class i.e. child and adult. 
%}
function [datasetpath, label] = combineddata(varargin)
    arglength = size(varargin, 2);
    
    %Calculate how files in total needed
    s = 0;
    for i = 1:2:arglength
        s = s+ size(dir(varargin{i}), 1);
    end
    
    
    %Combine all the files into one single data single label vector. 
    startindex = 1;
    datasetpath = cell(s, 1);
    for i = 1:2:arglength
        nooffiles = size(dir(varargin{i}), 1);
        endindex = nooffiles + startindex - 1;
        rawdata(startindex:endindex, 1) = dir(varargin{i});
        
        %Concadinate file name and its path. 
        pathoffile = strsplit(varargin{i}, '*');
        for j = startindex:endindex
            datasetpath(j, 1) = strcat(pathoffile(1, 1), cellstr(rawdata(j, 1).name));
        end
        
        
        label(startindex:endindex, 1) = varargin{i+1};
        startindex = endindex + 1;
    end
    
end