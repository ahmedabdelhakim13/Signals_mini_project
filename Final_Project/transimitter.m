[y,f_s] = audioread('gamed.mp3');
sound(y,f_s);
N = length(y);
t=linspace(0,N/f_s,N);
figure;
plot(t,y)
clear sound



f=linspace(0,f_s,1024);
Y=abs(fft(y,1024));
figure;
plot(f(1:1024), Y(1:1024));