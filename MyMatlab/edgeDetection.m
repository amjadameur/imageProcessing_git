close all;
clear;
clc;

[img, map] = imread('cameraman.tif');

sigma = 5;

a = 2*ceil(3*sigma)+1;

[X, Y] = meshgrid(-(a-1)/2 : (a-1)/2);

Hx = exp(-(X.^2 + Y.^2) / (2*sigma^2)) .* (-X/(2*pi*sigma^4));
Hy = exp(-(X.^2 + Y.^2) / (2*sigma^2)) .* (-Y/(2*pi*sigma^4));

%H = H/sum(sum(H));

filteredX = conv2(img, Hx, 'same');
filteredY = conv2(img, Hy, 'same');

filtered = (filteredX.*filteredX + filteredY.*filteredY).^0.5;
filtered = uint8(filtered);

figure, imshow(filtered, [0 25]); colormap(flipud(gray(256)));

