h = [0.0764 -1.1322 5.2228 -6.6959 3.5142];
t = -10:0.1:10;
x = sinc(t);
y = myconv(x, h);
plot(y);
[s, fs] = audioread("noisy.wav");
figure
plot(s);
new = myconv(s, h);
figure
plot(new);
audiowrite("new.wav",new , fs);
[st, fst] = audioread("new.wav");
sound(s, fs);
pause(10)
sound(st, fst);
