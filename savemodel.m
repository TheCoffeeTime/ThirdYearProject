%{
Description:
    - Save a given variable (in this case is the model), name it 'name'
      and in the 'path' given
Parameter: 
    - model: SVM model
    - name: the name of the model wanting to be saved
    - path: directory path
%}
function [] = savemodel(model, name, path)
    mp = strcat(path, name);
    save(mp, 'model');
end
