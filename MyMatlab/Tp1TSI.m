close all;
clear;
clc;

[foreGround, map] = imread('foreground.jpg');
[backGround, map] = imread('background.jpg');

[R, G, B]   = RGB(foreGround);
[Y, Cb, Cr] = yCbCr(R, G, B);


sky = uint8(Cb > max(Cb)-20); % ciel de l'image 2 (backGround)

Rout = sky.*backGround(:, :, 1) + (1-sky).*R;
Gout = sky.*backGround(:, :, 2) + (1-sky).*G;
Bout = sky.*backGround(:, :, 3) + (1-sky).*B;

imOut = cat(3, Rout, Gout, Bout);
figure, imshow(imOut)



