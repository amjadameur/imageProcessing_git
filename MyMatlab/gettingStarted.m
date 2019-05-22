close all;
clear;
clc;

imIn = imread('cameraman.tif');
imIn = uint8(imIn);
[height, width] = size(imIn);

% différence entre les colonnes 
imOut = zeros(height, width);

for w = 1 : width-1
    imOut(:, w) = imIn(:, w) - imIn(:, w+1); 
end
imOut(:, width) = imIn(:, width);

figure, imshow(imOut, []);
figure, histogram(imOut);

