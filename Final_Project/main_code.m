%reading the sound
[x,f_s] = audioread('3arfeeen.mp3');
%play the sound
sound(x,f_s);
%time representation
N = length(x);  %length of x
t=linspace(0,N/f_s,N); %time 
subplot(3,1,1)
plot(t,x); %origional sound in time
xlabel('Time');
ylabel('sound');
title('Time representation')
clear sound

%frequencyrepresentation
X=fftshift(fft(x));
X_magnitude= abs(X);
X_phase = angle(X);
fvec=linspace(-f_s/2,f_s/2,N);
subplot(3,1,2)
plot(fvec,X_magnitude); %origional sound in frequency
xlabel('Frequency');
ylabel('sound');
title('Frequency magnitude representation');
subplot(3,1,3)
plot(fvec,X_phase); %origional sound in phase
xlabel('Frequency ');
ylabel('sound');
title('Frequency angle representation');

%channels
% Define the impulse responses
h1 = [1 zeros(1, N-1)]; % Delta function
h2 = exp(-2*pi*5000*t); % exp(-2pi*5000t)
h3 = exp(-2*pi*1000*t); % exp(-2pi*1000t)
h4 = zeros(size(t));
h4(t == 0) = 2;
h4(t == 1) = 1;
%implementation of the channels
figure;
subplot(2,2,1);
plot(h1);
xlabel('time');
ylabel('channel 1');
subplot(2,2,2);
plot(h2);
xlabel('time');
ylabel('channel 2');
subplot(2,2,3);
plot(h3);
subplot(2,2,4);
plot(h4);

channels=input('Enter the number of the channel you want to perform on the signal : \n 1)Delta function  \n 2)exp(-2pi*5000t) \n 3)exp(-2pi*1000t)\n 4)impulse response \n');  

if channels==1   
    y = conv(x(:)', h1(:)');
elseif channels==2
    y = conv(x(:)', h2(:)');
elseif channels==3
    y = conv(x(:)', h3(:)');
elseif channels==4
    y = conv(x(:)', h4(:)');
end

% Plot the result
figure;
subplot(2,1,1);
plot(t, x);
title('Original sound message');
xlabel('Time (s)');
ylabel('Amplitude');

t=linspace(0,length(y)/f_s,length(y));
subplot(2,1,2);
plot(t, y);
title('Convolved sound message');
xlabel('Time (s)');
ylabel('Amplitude');

 