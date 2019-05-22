function showImComponents(img)

[R, G, B]   = RGB(img);
[Y, Cb, Cr] = yCbCr(R, G, B);

figure,
subplot(2, 3, 1);
imshow(R);
title('R');

subplot(2, 3, 2);
imshow(G);
title('G');

subplot(2, 3, 3);
imshow(B);
title('B');

subplot(2, 3, 4);
imshow(Y);
title('Y');

subplot(2, 3, 5);
imshow(Cb);
title('Cb');

subplot(2, 3, 6);
imshow(Cr);
title('Cr');