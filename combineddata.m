%{
    - A function which combine/zip path of that file to itself then group
      all of them together into one data set. 
    - varargin is an infinite number of arguments
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
function [data, label] = combineddata(varargin)
    arglength = size(varargin, 2);
    
    %Check if length is even as a pair of path and label required
    if mod(arglength, 2) ~= 0
        err = MException('combineddata:ArgumentLengthNotEven', ...
        'Some directories does not have a label');
        throw(err);
    end
    %Check if length is not 0
    if arglength <= 0
        err = MException('combineddata:ArgumentLengthIsZero', ...
        'The argument length is 0');
        throw(err);
    end
    
    %{
    %Calculate how files in total needed
    s = 0;
    for i = 1:2:arglength
        s = s+ size(dir(varargin{i}), 1);
    end
    %}
    
    %Combine all the files into one single data single label vector. 
    startindex = 1;
    for i = 1:2:arglength
        nooffiles = size(dir(varargin{i}), 1);
        endindex = nooffiles + startindex - 1;
        data(startindex:endindex, 1) = dir(varargin{i});
        label(startindex:endindex, 1) = varargin{i+1};
        startindex = endindex + 1;
    end
    
end