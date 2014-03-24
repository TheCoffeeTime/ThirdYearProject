%{
Description: 
    - Extract formants (f1-f3) from a given speech data. 

Parameter:
    - Speech sample

Return: 
    - Array of formants. 
%}
function [formants] = getformantsfromdata(data)
    ar_coeffs = arburg(data,12);
    [N,F,A,B] = lpcar2fm(ar_coeffs, 200);
    formants = F;
end