function entrop = entropie(img)

img = img(:);

[ni, ] = histcounts(img, 256); % histogramme brut
niTmp = find(ni); % pour enlever les éléments nuls (on utilisera le log après)
niM = ni(niTmp)/size(img, 1); 
 
entrop = -sum(niM.*log2(niM));

