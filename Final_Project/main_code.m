%reading the sound
[x,f_s] = audioread('gamed.mp3');
sound(x,f_s);

%time representation

N = length(x);
t=linspace(0,N/f_s,N);
figure;
plot(t,x);
xlabel('Time');
ylabel('sound');
title('Time representation')
clear sound

%frequencyrepresentation

X=fftshift(fft(x));
X_magnitude= abs(X);
X_phase = angle(X);
fvec=linspace(-f_s/2,f_s/2,N);
figure;
subplot(2,1,1)
plot(fvec,X_magnitude);
xlabel('Frequency');
ylabel('sound');
title('Frequency magnitude representation');
subplot(2,1,2)
plot(fvec,X_phase);
xlabel('Frequency ');
ylabel('sound');
title('Frequency angle representation');

%channels
channels=input('Enter the number of the channel you want to perform on the signal : \n 1)Delta function  \n 2)exp(-2pi*5000t) \n 3)exp(-2pi*1000t)\n 4)impulse response \n');  
 
if channels==1
    
elseif channels==2
elseif channels==3
elseif channels==4
end
 