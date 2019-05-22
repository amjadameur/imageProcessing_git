clear; 
close all;
clc;

%% Q1
A=double(imread('pool.tif'));
R=A(:,:,1); 
G=A(:,:,2); 
B=A(:,:,3);

Y=0.299*R+0.587*G+0.114*B;
Cb=0.564*(B-Y)+128;
Cr=0.713*(R-Y)+128;
L=(R+G+B)/3;

% figure, 
% imshow(uint8(A))
% figure, 
% imshow(uint8(L))
% figure, 
% imshow(uint8(Y))
% tx=90:350;
% ty=160:330;
% figure,
% subplot(2,3,1)
% imshow(uint8(R(ty,tx)))
% subplot(2,3,2)
% imshow(uint8(B(ty,tx)))
% subplot(2,3,3)
% imshow(uint8(G(ty,tx)))
% subplot(2,3,4)
% imshow(uint8(Cr(ty,tx)))
% subplot(2,3,5)
% imshow(uint8(Cb(ty,tx)))
% subplot(2,3,6);
% imshow(uint8(A(ty,tx,:)));

%% Q2
AA=double(imread('foreground.jpg'));
BB = double(imread('background.jpg'));
R=AA(:,:,1); 
G=AA(:,:,2); 
B=AA(:,:,3);

YY=0.299*R+0.587*G+0.114*B;
Cbb=0.564*(B-YY)+128;
Crr=0.713*(R-YY)+128;
LL=(R+G+B)/3;
% figure, 
% imshow(uint8(AA)), colorbar;
% 
% figure, 
% imshow(uint8(B)), colorbar;
% figure, 
% imshow(uint8(AA))
% figure, 
% imshow(uint8(BB))


% subplot(2,3,1)
% imshow(uint8(R)
% subplot(2,3,2)
% imshow(uint8(B))
% subplot(2,3,3)
% imshow(uint8(G))
% subplot(2,3,1)
% imshow(uint8(Crr))
% subplot(2,3,2)
% imshow(uint8(Cbb))
% subplot(2,3,3);
% imshow(uint8(AA));


Cbb = (Cbb <= 139) * 255;

% figure
% imshow(Cbb)       
Is = AA;
Is = ((Cbb == 0).*BB) + ((Cbb ~= 0).*AA);
% figure
% imshow(uint8(Is))

 
%% Q3

mask = (B <= 150)*255;
figure; 
imshow(uint8(mask))

