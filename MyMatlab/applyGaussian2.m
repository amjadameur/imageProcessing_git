function filtered = applyGaussian2(sigma ,img)
% sigma = 10

a = 2*ceil(3*sigma)+1;

[X, Y] = meshgrid(-(a-1)/2 : (a-1)/2);

H = exp(-(X.^2 + Y.^2) / (2*sigma^2)) / (2*pi*sigma^2);

H = H/sum(sum(H));

filtered = applyConv2(H, img);