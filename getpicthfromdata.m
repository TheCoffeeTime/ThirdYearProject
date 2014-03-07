function [pitch] = getpicthfromdata(data, FS)
    pitch = fxpefac(data, FS);
    pitch = mean(pitch);
end