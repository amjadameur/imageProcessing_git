function PSNR = psnr(imIn, imOut)

MseSquared = (imIn-imOut).^2;
MseSquared = mean2(MseSquared);
MSE = sqrt(MseSquared);
PSNR = 20*log10(255/MSE);