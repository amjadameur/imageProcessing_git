clear; 
close all;
clc;

[A, map] = imread("cameraman.tif");
imshow(A);
[X Y] = ginput(1);
%x_ent = floor(X);
%y_ent = floor(Y);


block = A(X-7:X, Y-7:Y, :)

block_c = double(block) - 128;
dct = dct2(block_c)

q = 99;
alpha = ((q>=1 && q<=50)/q)*50 + ((q>50 && q<=99)/50)*(100-q) ; 

dct_quantifie = quantification(alpha, dct); 

 
%% Reconstitution de l'image
 % Déquantification :
 
 Q = [16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104  113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

  dct_dequantifie = alpha*dequantification(dct_quantifie) 
  %dct_quantifie.*(alpha*Q)
  %dequantification(alpha, dct_quantifie)

  dct_inverse = idct2(dct_dequantifie);
  dct_inverse_c = dct_inverse + 128 ;
   
 figure(1)
 subplot(231)
 imshow(block);
 title("Bloc 8x8")
 subplot(232);
 imshow(dct);
 title("DCT")
 subplot(233)
 imshow(dct_quantifie);
 title("Quantification")
 subplot(236)
  imshow(dct_dequantifie)
 title("Déquatification")
 subplot(235)
 imshow(uint8(dct_inverse))
 title("DCT inverse")
 subplot(234)
 imshow(uint8(dct_inverse_c))
 title("Imagette de sortie")
 

 
%% Traitement sur toute l'image
 

 A1 = double(imread("cameraman.tif"))
 A2 = A1 -128;
 close all
 fun = @dct2
 im_dct = blkproc(A2, [8, 8], fun);
 figure, imshow(uint8(im_dct))
for(q=1:99)
%q =99;   
alpha = ((q>=1 && q<=50)./q)*50 + ((q>50 && q<=99)/50).*(100-q) ;

 fun1 = @(dct)quantification(alpha, dct);
 im_dct_quan = blkproc(im_dct, [8, 8], fun1);
 
 
 fun2 = @(dct_quantifie)alpha*dequantification(dct_quantifie);
 im_dct_dequan = blkproc(im_dct_quan, [8, 8], fun2);
 
 fun3 = @idct2;
 im_idct = blkproc(im_dct_dequan, [8, 8], fun3);
 im_idct_c = im_idct + 128;
 
 dif = A1 - im_idct_c;
 
 %figure(2), imshow(uint8(A1));
 %figure(3), imshow(uint8(im_dct_inverse_c))
 
 % Entropie : 
 % Entropie de l'image initiale 
f = histcounts(A1(:),256);
prob = f/(size(A1,1)* size(A1,2));
pos = find(prob);
Entro_init = -sum(prob(pos).*log2(prob(pos)));

% Entropie de l'image finale
f = histcounts(im_idct_c(:),256);
prob = f/(size(im_idct_c,1)* size(im_idct_c,2));
pos = find(prob);
Entro_fin(q) = -sum(prob(pos).*log2(prob(pos)));

%Rapport signal sur bruit
MSE = sqrt(mean(mean(dif.^2)));
PSNR(q) = 20*log10(255/MSE);

info_init = imfinfo("cameraman.tif");
imwrite(uint8(A1),'im.jpg','jpg','Quality',q) ;
info_fin = imfinfo( "im.jpg", 'jpg');
fac_comp(q) = info_init.FileSize/info_fin.FileSize;
taux_comp(q) = 1/fac_comp(q);
gain_comp(q) = 1-taux_comp(q);
end




q = 1:1:99;
figure, plot(q, alpha)
figure, plot(q, Entro_fin);
title("Entropie en fonction du facteur de qualité");
xlabel("Facteur de qualité q");
ylabel("Entropie");

figure, plot(q, PSNR);
title("Rapport signal/bruit en fonction du facteur de qualité");
xlabel("Facteur de qualité q");
ylabel("RSB");
 
figure, plot(q, fac_comp);
title("Facteur de compression en fonction du facteur de qualité");
xlabel("Facteur de qualité q");
ylabel("fac_comp");

figure, plot(q, taux_comp);
title("taux de compression en fonction du facteur de qualité");
xlabel("Facteur de qualité q");
ylabel("taux_comp");
 
figure, plot(q, gain_comp);
title("gain de compression en fonction du facteur de qualité");
xlabel("Facteur de qualité q");
ylabel("gain_comp"); 





