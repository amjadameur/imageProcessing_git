clear;
close all; 
clc;

 A =  double(imread('implant.bmp'));
 B =  imread('lezard.bmp');
 %C =  imread('implant.bmp');
% Is  = zeros(size(A,1), size(A, 2), 3);
% Is(:, :, 3)=A;
% figure
% imshow(uint8(Is));
% figure
% imshow(A);


%B = double(imread('cameraman.tif'));
% %% entropie
% f = histcounts(C(:),256); %ou histc(C(:),(0:255))
% prob = f/(size(C,1)* size(C,2));
% pos = find(prob);
% Entro = -sum(prob(pos).*log2(prob(pos)))
% E = entropy(C)
% 

%% Histogramme
N =256;
v =double(B(:)); %conversion matrice en vecteur
a = linspace(0,255,N);
%h1 = histc(v, a);
%figure, bar(a, h1, 'histc'), xlim([min(a) max(a)]);
[h2, c] = hist(v, N);
%figure, bar(c, h2, 'hist'), xlim([min(c) max(c)]);

%%
 D = [A(:,1:127)- A(:,2:128) A(:,128)];
% D =zeros(size(A));
% for(j = 1:length(A)-1)
%    D(:,j) = A(:,j)- A(:,j+1); 
% end
% D(:,128) = A(:,128);
%imshow(D);

N =256;
v =double(D(:)); %conversion matrice en vecteur
a = linspace(-255,255,N);
%h1 = histc(v, a);
%figure, bar(a, h1, 'histc'), xlim([min(a) max(a)]);

f = histcounts(D(:), (-255:255)); %ou histc(C(:),(0:255))
prob = f/(size(D,1)*size(D,2));
pos = find(prob);
Entro = -sum(prob(pos).*log2(prob(pos)))


E = entropy(uint8(D))

%% Compression vidéo


I1 = double(imread('football044.ras')); 
I2 = double(imread('football045.ras'));
I3 = double(imread('football046.ras'));

[Vx, Vy] = motionAtoB(I2, I1, [8 8], [15 15]);
[Vx3, Vy3] = motionAtoB(I2, I3, [8 8], [15 15]);
%figure, imshow(Vx, [-7 7])
%figure, imshow(Vy, [-7 7])
%figure, imshow(((Vx.*Vx + Vy.*Vy).^0.5) , [-10, 10]) %module
%figure, imshow(uint8(I2))
% hold on;
% [hV, wV] = size(Vx);
% [X, Y] = meshgrid(1:wV, 1:hV);
% X = (X-1)*8+4.5;
% Y = (Y-1)*8+4.5;
% quiver(X, Y, Vx, Vy);
% 
% hold off;
% 
% figure, imshow(uint8(I1))
% hold on;
% [hV, wV] = size(Vx);
% [X, Y] = meshgrid(1:wV, 1:hV);
% X = (X-1)*8+4.5;
% Y = (Y-1)*8+4.5;
% quiver(X, Y, Vx, Vy);
% hold off;

figure, imshow(uint8(I3));
I1c =  motionCompensate (I1, Vx, Vy); 
figure, imshow(uint8(I1c))
I3c =  motionCompensate (I3, Vx3, Vy3); 
figure, imshow(uint8(I3c))
figure, imshow(I2 - I3, [-150 150])
figure, imshow(I2 - I1c, [-150 150])
figure, imshow(I2 - (I1c+I3c)/2, [-150 150])

f = histcounts(I2(:)-I1(:), (-255:255)); %ou histc(C(:),(0:255))
prob = f/(size(I2(:)-I1(:),1)*size(I2(:)-I1(:),2));
pos = find(prob);
Entro1 = -sum(prob(pos).*log2(prob(pos)))

f = histcounts(I2(:)-I1c(:), (-255:255)); %ou histc(C(:),(0:255))
prob = f/(size(I2(:)-I1c(:),1)*size(I2(:)-I1c(:),2));
pos = find(prob);
Entro2 = -sum(prob(pos).*log2(prob(pos)))

f = histcounts(round(I2(:)-(I1c(:)+I3c(:))/2), (-255:255)); %ou histc(C(:),(0:255))
prob = f/(size(round(I2(:)-(I1c(:)+I3c(:))/2),1)*size(round(I2(:)-(I1c(:)+I3c(:))/2),2));
pos = find(prob);
Entro3 = -sum(prob(pos).*log2(prob(pos)))
