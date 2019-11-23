n = -25:25;
Y1 = exp(1i * 2 / 3 * n);
stem(n,Y1,'blue');
figure
Y2 = exp(1i * 2 * pi / 3 * n);
stem(n, Y2, 'red');
