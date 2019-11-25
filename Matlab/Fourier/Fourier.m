Fs=60;
t=-20:1/Fs:20-1/Fs;
axis ([0 20 -20 10])
% Fourier Series
a0=0;
Fy=zeros(size(t));
N=50;
for n=0:1:N
Fy=Fy+(sin(2*pi*n/3)*cos(n*2*pi/3*t) / (n * pi)  );
end
%ak = a-k
Fy = 2 * Fy;
% a0
 Fy = Fy + 2 / 3;
hold on,
plot(t,Fy,'r')
legend(' Square ','Fourier Approx');