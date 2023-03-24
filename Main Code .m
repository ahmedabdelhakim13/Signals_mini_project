clear all;
clc;
Sampling_Frequency = input('Please enter the sampling frequency in Hz:');

while (Sampling_Frequency <= 0)
Sampling_Frequency = input('Please enter the sampling frequency in Hz:');
end



Start_time = input('Please enter the start time:');
End_time= input('Please enter the end time:');

while (End_time <= Start_time)
   disp('the End_time must be greater than the start');
         Start_time = input('Please enter the start time:');
         End_time = input('Please enter the end time:');
end
samples=(End_time-Start_time)*Sampling_Frequency;
t=linspace(Start_time,End_time,samples);

NO_Break_points = input('Please enter Number of break points:');
 %to make sure that the number of break points is a positive integer 
while (NO_Break_points < 0 || mod(NO_Break_points,1) ~= 0 )
    fprintf('number of break points must be a positive integer\n');
    NO_Break_points = input('Please enter Number of break points:');
end
   
% array that carries the start time, poisitons of break points and end time
Position=zeros(1,NO_Break_points+2);
Position(1,1) = Start_time;
Position(1,NO_Break_points+2) = End_time;

for i=2:NO_Break_points+1
    
     Position(i)=input(['Please enter the position of the break point ',num2str(i-1),' at t=:']);    
     while ( Position(i)<= Start_time || Position(i)>= End_time )
          fprintf('you entered an incorrect breakpoint\nthe break point must be between the start time and the end time\n');
          Position(i)=input(['Please enter the position of the break point ',num2str(i-1),' at t=:']);
     end
end
    
x=zeros(1,samples);

for i=1:NO_Break_points+1
    %start time will always be within the array position as we increment it by 1
    t_start = Position(1,i);
    %final time will always be the time after the start time since position
    %contains the start time followed by time of the first break point and then the second and so on...
    t_final = Position(1,i+1);
    %length of the time period of each region 
    t_part = linspace(t_start,t_final,(t_final-t_start)*Sampling_Frequency);
    
    type=input('enter the number of the specification of the signal you want:\n 1)DC \n 2)RAMP \n 3)General order polynomial \n 4)EXPONENTIAL \n 5)SINUSOIDAL \n 6)sinc \n 7)triangular pulse\n');
        if type == 1
            amp=input('enter the amplitude');
            x_part=amp*ones( 1,(t_final-t_start)*Sampling_Frequency );

        elseif type == 2
            slope=input('enter the slope');
            intercept=input('enter the intercepted part of y axis:');
            x_part=slope*t_part+intercept;

        elseif type == 3
            amp=input('\nenter the amplitude:');
            power=input('\nEnter the power: ');
            intercept=input('\nenter the intercepted part of y axis:');
            x_part=amp*(t_part.^power)+intercept;


        elseif type == 4
            amp=input('\nenter the amplitude: ');
            exponent=input('\nEnter the exponent: ');
            x_part= amp*exp(expn*t_part);
            

        elseif type == 5
            amp=input('\nenter the amplitude: ');
            freq=input('\nenter the frequency');
            phaseshift=input('\nenter the phase shift: ');
            x_part= amp*sin(2*pi*freq*t_part+phaseshift);



        elseif type == 6
            amp=input('\nenter the amplitude: ');
            phaseshift=input('\nenter the phase shift: ');
            x_part=amp*(sin(pi*(t_part+phaseshift))./(pi*(t_part+phaseshift)));



        elseif type == 7    
            amp=input('\nenter the amplitude: ');
            width=input('\nenter the width: ');
            r=width/2;
            phaseshift=input('\nenter the phase shift');
            x_part=(amp*(1-(1/r)*abs(t_part+phaseshift))).*(abs(t_part+phaseshift)<=r);




        end
        %when i =1 this means we're in the first region so we put all the remaining regions with zeros
        if i == 1 
            Region_After = End_time-Position(1,i+1);
            x_After = zeros(1,Region_After*Sampling_Frequency);
            x_total = [x_part x_After];
            x = x + x_total;
        %when i =breakpoints+1 this means we're in the last region so we put all the remaining regions with zeros
        elseif i == NO_Break_points+1
            Region_Before = Position(1,i)-Start_time;
            x_Before = zeros(1,Region_Before*Sampling_Frequency);
            x_total= [x_Before x_part];
            x = x + x_total ;
        %else means we're in a middle region so we put before and after regions with zeros
        else
            Region_Before = Position(1,i)-Start_time;
            Region_After = End_time-Position(1,i+1);
            x_Before = zeros(1,Region_Before*Sampling_Frequency);
            x_After = zeros(1,Region_After*Sampling_Frequency);
            x_total= [x_Before x_part x_After];
            x = x + x_total ;
        end
end

%Cases of operations.

% Operations on the signals according to the user's input.

% Taking the input from the user for the desired operation.
operation=input('Enter the number of the operation you want to perform on the signal : \n 1)Amplitude Scaling \n 2)Time Reversal \n 3)Time Shift \n 4)Expanding the signal \n 5)Compressing the signal \n 6)Clipping the signal \n 7)The first derivative of the signal \n 8)None \n ');

% Cases to perform the selected operation on the signal and display both original and new signals. 

if operation == 1 % Amplitude Scaling.
    % Take the value of the scale from the user.
    scale = input('Enter the scale value');
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot Amplitude Scaled signal.
    subplot(2,1,2);
    plot(t,scale*x);
    title('Amplitude Scaled Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 2 % Time Reversed Signal.
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the shifted signal.
    subplot(2,1,2);
    plot(-t,x);
    title('Time Reversed Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;

elseif operation == 3 % Time Shifting.
    % Taking the shift value from the user.
    shift = input('Enter the shift value: ');
    % Shift the signal.
    t_new= t + shift; 
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the shifted signal.
    subplot(2,1,2);
    plot(t_new,x);
    title('Time Shifted signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 4  % Expanding the signal.
    % Ask the user for the expanding value.
    expansion = input('Enter the expansion value: ');

    % Compute the new sample rate
    x_new=resample(x,expansion,1);
    t_new=linspace(Start_time * expansion , End_time *expansion ,(End_time * expansion - Start_time * expansion)*Sampling_Frequency);
    % Plot the original and expanded signals
    subplot(2,1,1);
    plot(t, x);
    title('Original Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    subplot(2,1,2);
    plot(t_new, x_new );
    title('Expanded Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 5 % Compressing the signal.
    % Ask user to enter a compressing value.
    compression = input('Enter the compressing value: ');
	% Compression
    x_new = downsample( x , compression );
    t_new=linspace(Start_time / compression , End_time / compression ,(End_time / compression - Start_time / compression)*Sampling_Frequency);
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the compressed signal.
    subplot(2,1,2);
    plot(t_new,x_new);
    title('Compressed Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 6 % Clipping the signal.
    % Ask user to enter upper and lower clipping values.
    upper = input('Enter the upper clipping value: ');
    lower = input('Enter the lower clipping value: ');
    % Clipping the signal.
    x_clipped = x;
    x_clipped(x_clipped > upper) = upper;
    x_clipped(x_clipped < lower) = lower;
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the clipped signal.
    subplot(2,1,2);
    plot(t,x_clipped);
    title('Clipped Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
elseif operation == 7 % First derivative of the signal.   
    % Calculate the first derivative of the signal
    ts = 1/Sampling_Frequency;
    dx = diff(x)/ts;
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot first derivatve of the signal.
    subplot(2,1,2);
    plot(t( 1 : end - 1 ),dx); 
    title('First Derivative of Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;    
elseif operation == 8 % None. 
    % Perform no operation on the signal.
	% Plot the original signal without any change.
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
	
end