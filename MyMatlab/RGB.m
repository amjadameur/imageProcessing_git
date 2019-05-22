function [R, G, B] = RGB(img)

R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);