close all;
clear;
clc;

[img, map] = imread('monument.bmp');

%figure, imshow(img);



sigma = 10;
a = 2*ceil(3*sigma)+1;
[X, Y] = meshgrid(-(a-1)/2 : (a-1)/2);

myDirac = (X == 0 & Y == 0);
h = exp(-(X.^2 + Y.^2) / (2*sigma^2)) / (2*pi*sigma^2);

fx = 0.1;
fy = -0.4;


modulationCos = cos(2*pi*fx*X + 2*pi*fy*Y);

hModulated = 2*h.*modulationCos;

hModulated = myDirac - hModulated;
filtered2 = applyConv2(hModulated, img);

