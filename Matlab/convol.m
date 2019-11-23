x = [1, 0, -1, 0, -1, 1, 1];
nx = (-3:1:3);
subplot(3,1,1);
stem(nx, x);

h = [-1, 1, 0, 1];
nh = (1:1:4);
subplot(3, 1, 2);
stem(nh, h);
n = (-2:1:7);
c = conv(x, h);
subplot(3, 1, 3);
stem(n, c);