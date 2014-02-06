addpath '/Users/Thanakorn/Downloads'

I = imread('image.jpg');
I = rgb2gray(I);
G = fspecial('gaussian',[50 50],200);
%# Filter it
IG = imfilter(I,G,'same');
IGI = IG - I;
oldIGI = IGI;

[w h] = size(IGI);
for i = 1:w
    for j = 1:h
        if(IGI(i, j) > 4)
            IGI(i, j) = 255;
        else
            IGI(i, j) = 0;
        end
    end
end

imshow(IGI);
