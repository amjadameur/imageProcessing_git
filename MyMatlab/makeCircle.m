function circle = makeCircle(size, x0, y0, radius)

[X, Y] = meshgrid(-size/2 : size/2);

circle = ((X - x0).^2 + (Y - y0).^2) <= radius^2;

circle = uint8(circle);


