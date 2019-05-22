clear; 
close all;
clc;

Im = double(imread('monument.bmp'));

[h,w] = size(Im);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);

Imf =  fftshift(log10(abs(fft2(Im))));

%% Filtre passe bas
sigma = 5;
a = 1+2*ceil(3*sigma)
[X, Y] = meshgrid(-(a-1)/2:(a-1)/2);
h11 = exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma*sigma); % Filtre gaussien passe bas
h1 = h11/sum(sum(h11));                                 % Normalisation du filtre gaussien    
H1 = fftshift(log10(abs(h1)));

C = conv2(Im, h1);  % Image filtrée par le passe bas

%% Filtre passe bande
f0x = 0.0992;
f0y = -0.3996;
h2 = 2* h1.* cos(2*pi*(f0x*X + f0y*Y));
B = conv2(Im, h2);   % Isolation du bruit

H2 = fftshift(log10(abs(h2)));

%% Filtre coupe bande

dir = zeros(size(h2));
dir((size(h2)+1)/2,(size(h2)+1)/2) = 1;
h3 = dir - h2;

%% Image filtrée
A = conv2(Im, h3);
Af =  fftshift(log10(abs(fft2(A))));
%% Filtrage de la deuxième trame

fx_t2 = 0.1991;
fy_t2 = 0.1989;

h2_t2 = 2* h1.* cos(2*pi*(fx_t2*X + fy_t2*Y));
h3_t2 = dir - h2_t2;

%  W=kaiser(512,10)*kaiser(512,10)';
%  B = A(1:512, 122:633);
%  Iw=B.*W;
%  If2=fftshift(log10(abs(fft2(Iw,1024,1024))));
%  figure, imagesc(fx1,fy1,If2)

  A_bis = conv2(A, h3_t2);                    % Deuxième trame filtrée
  A_f =  fftshift(log10(abs(fft2(A_bis))));   % Transformée de Fourier de la deuxième image filtrée
%% Figures :
figure, imshow(uint8(Im));                  % l'image
figure, imagesc(fx,fy,Imf), axis('square'); % la transformée de fourier de l'image
figure, freqz2(h1);                         % Réponse fréquentielle d'un filtre passe-bas
figure, imshow(uint8(B));                   % Le bruit isolé
figure, freqz2(h2);                         % Réponse fréquentielle du filtre passe bande
figure, freqz2(h3);                         % Réponse fréquentielle d'un filtre coupe bande
figure, imagesc(fx,fy,Af), axis('square');  % la transformée de fourier de l'image filtrée
figure, imagesc(fx,fy,A_f), axis('square'); % la transformée de fourier de la deuxième image filtrée
figure, imshow(uint8(A))                    % l'image filtrée
figure, imshow(uint8(A_bis));               % la deuxième image filtrée 

