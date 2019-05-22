function [Y, Cb, Cr] = yCbCr(R, G, B) 

Y  = 0.299*R + 0.587*G + 0.114*B;

Cb = 0.564*(B-Y)+128;

Cr = 0.713*(R-Y)+128;

Y  = uint8(Y);
Cb = uint8(Cb);
Cr = uint8(Cr);