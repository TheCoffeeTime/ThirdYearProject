%{
Description:
    - Combined cell array

Parameter
    - cellarr: Cell data structure

Return:
    - .mat
%}
function outdata = preprocessing(indata, FS)

    % Remove silence
    tempData = detectVoiced(indata, FS, 0);
    
    s = size(tempData, 2);
    
    % If it is possible to remove silent then do it. 
    if s > 1
        outdata = tempData{1}
        for i = 2:s
            outdata = vertcat(outdata, tempData{i});
        end
    else % Else just use the original sound with out silent removal
        outdata = indata;
    end
    