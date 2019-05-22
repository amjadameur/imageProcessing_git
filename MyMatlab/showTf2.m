function showTf2(img)

[h, w] = size(img);

tfImg  = log10(abs(fft2(img)));

fy = linspace(-0.5, 0.5-1/h, h);
fx = linspace(-0.5, 0.5-1/w, w);

imagesc(fx, fy, fftshift(tfImg))
colormap(jet(256)), colorbar








