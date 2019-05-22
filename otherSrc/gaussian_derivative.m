function [Gx, Gy]= gaussian_derivative(sigma)


a = ceil(3*sigma)
[X, Y] = meshgrid(-a:a);

Gx = X*exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma^4); 
Gy = transpose(Gx);

end