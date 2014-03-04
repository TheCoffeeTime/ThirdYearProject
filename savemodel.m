function [] = savemodel(model, name, path)
    mp = strcat(path, name);
    save(mp, 'model');
end
