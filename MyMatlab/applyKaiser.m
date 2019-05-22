function applyKaiser(beta, img)
% communly beta takes 10


[h, w] = size(img);
kaiser2 = kaiser(h, beta)*kaiser(w, beta)';

imgKaiser = double(img).*kaiser2;

showTf2(imgKaiser);