%reading the sound
[y,f_s] = audioread('gamed.mp3');
sound(y,f_s);
%time representation
N = length(y);
t=linspace(0,N/f_s,N);
subplot(2,1,1);
plot(t,y);
xlabel('Time');
ylabel('sound');
title('Time representation')
clear sound
%frequencyrepresentation
Y=fftshift(fft(y));
subplot(2,1,2);
plot(Y);
xlabel('Frequency');
ylabel('sound');
title('Frequency representation');