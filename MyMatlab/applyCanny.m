function filtered = applyCanny(sigma, img) 
% sigma = 0.5 is good

a = 2*ceil(3*sigma)+1;

[X, Y] = meshgrid(-(a-1)/2 : (a-1)/2);

Hx = -X.*exp(-(X.^2 + Y.^2) / (2*sigma^2));
Hy = -Y.*exp(-(X.^2 + Y.^2) / (2*sigma^2));

filteredX = conv2(img, Hx, 'same');
filteredY = conv2(img, Hy, 'same');

filtered = (filteredX.*filteredX + filteredY.*filteredY).^0.5;
filtered = uint8(filtered);

figure,
subplot(1, 2, 2);
imshow(filtered, [0 25]), colormap(flipud(gray(256)));
title('Edge-Detected Image')

subplot(1, 2, 1);
imshow(img);
title('Original Image');

