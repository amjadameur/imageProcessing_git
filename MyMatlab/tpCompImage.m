close all;
clear;
clc;

M = 256; % gray scale

img = imread('cameraman.tif');

%% AC/DC
dct2Handler = @(block_struct) dct2(block_struct.data);
imDct = blockproc(double(img)-128, [8 8], dct2Handler);
imDct = double(imDct);

quantifHandler = @(block_struct) quantification(block_struct.data);
imQuant = blockproc(imDct, [8 8], quantifHandler);
imQuant = double(imQuant);

%% AC (la composante continue s'annulle, nous ne conservons que les contours (riches en fréquence)
getAcHandler = @(block_struct) getAc(block_struct.data);

imDctAc = blockproc(imDct, [8 8], getAcHandler);
imDctAc = double(imDctAc);

imQuantAc = blockproc(imQuant, [8 8], getAcHandler);
imQuantAc = double(imQuantAc);


%% Output image after compression
compHandler = @(block_struct) compress(25, block_struct.data); % 25 est le facteur de qualité dans ce cas
imOut = blockproc(img, [8 8], compHandler);
imOut = uint8(imOut);

%% Entropie et PSNR
entropIn  = entropie(img); % bit/symbole

entropOut = zeros(1, 99);
PSNR = zeros(1, 99);

% for ii = 1 : 1 : 99
%     compHandler = @(block_struct) compress(ii, block_struct.data); % 25 est le facteur de qualité dans ce cas
%     im = blockproc(img, [8 8], compHandler);
%     im = uint8(im);
%     
%     % Entropie
%     entropOut(ii) = entropie(im);
%     
%     %PSNR
%     PSNR(ii) = psnr(img, im);
%     
% end

%% writing output
imwrite(imOut, 'camera.tif');

infoIn  = imfinfo('cameraman.tif');
infoOut = imfinfo('camera.tif');

%% Plots
figure,
subplot(1, 2, 1), imshow(img), title('image originale');
subplot(1, 2, 2), imshow(imOut), title('image de sortie');

figure,
subplot(2, 2, 1), imshow(log(abs(double(imDct))), [])  , title('AC avant quantification'), colormap(gca, jet(256)), colorbar;
subplot(2, 2, 2), imshow(log(abs(double(imQuant))), []), title('AC après quantification'), colormap(gca, jet(256)), colorbar;

subplot(2, 2, 3), imshow(log(abs(double(imDctAc))), [])  , title('AC avant quantification'), colormap(gca, jet(256)), colorbar;
subplot(2, 2, 4), imshow(log(abs(double(imQuantAc))), []), title('AC après quantification'), colormap(gca, jet(256)), colorbar;


figure,
n = [1 : 99];
subplot(2, 1, 1), plot(n, entropOut), xlabel('q : facteur de qualité'), ylabel('Entropie'), xlim([1 99]);
subplot(2, 1, 2), plot(n, PSNR), title('Rapport signal sur bruit'), xlabel('q : facteur de qualité'), ylabel('PSNR'), xlim([1 99]);

