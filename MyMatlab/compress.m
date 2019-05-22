function Bcomp = compress(q, B)

% DCT 2D sur le bloc 8x8
F = dct2(double(B)-128);


% Quality Factor (I chose the luminance)
Q = [16  11  10  16  24  40  51  61  ; ... 
     12  12  14  19  26  58  60  55  ; ...
     14  13  16  24  40  57  69  56  ; ...
     14  17  22  29  51  87  80  62  ; ...
     18  22  37  56  68  109 103 77  ; ...
     24  35  55  64  81  104 113 92  ; ...
     49  64  78  87  103 121 120 101 ; ...
     72  92  95  98  112 100 103 99  ];

% Quantization 

alpha = (q >= 1 & q < 50)*(50/q) + (q>=50 & q <= 99)*((100-q)/50); 

Fq = F./(alpha*Q);
Fq = fix(Fq);



%% Code 

%% Reconstruction
iFq = Fq.*(alpha*Q);
Bcomp = idct2(iFq) + 128;

% % PLots
% figure,
% subplot(2, 2, 1), imshow(B), title('bloc 8x8');
% subplot(2, 2, 2), imshow(log(abs(F)), []), title('DCT'), colormap(gca, jet(64)), colorbar;
% subplot(2, 2, 3), imshow(log(abs(Fq)), []), title('DCT quantified'), colormap(gca, jet(64)), colorbar;
% subplot(2, 2, 4), imshow(uint8(Bcomp)), title('processed 8*8 Bloc');

