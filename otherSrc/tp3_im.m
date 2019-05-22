clear; 
close all;
clc;

sigma = 5;
[Gx, Gy]= gaussian_derivative(sigma);

Im1 = imread('building2.bmp');
%Im2 = imread('euro.jpg');