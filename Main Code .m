%
Sampling_Frequency = input('Please enter the sampling frequency in Hz:');

while Sampling_Frequency==0
Sampling_Frequency = input('Please enter the sampling frequency in Hz:');
end

ts=1/Sampling_Frequency;

Start_time = input('Please enter the start time:');
End_time= input('Please enter the end time:');

while (End_time <= Start_time)
   disp('the End_time must be greater than the start\n');
         Start_time = input('Please enter the start time:');
         End_time = input('Please enter the end time:');
end

t=Start_time:ts:End_time;

NO_Break_points = input('Please enter Number of break points:');


if NO_Break_points>0
    
      Position=zeros(1,NO_Break_points);

      for i=1:NO_Break_points+1

        Position(i)=input(['Please enter the position of the break point',num2str(i),'at t=:']);

        while ( Position(i)<= Start_time || Position(i)>= End_time )
            Position(i)=input('you entered an incorrect breakpoint\nthe break point must be between the start time and the end time');
        end

        mm=[Start_time Position End_time ]; % array stores the start time and the end time and the break points

      end
    
else
       mm=[Start_time End_time ];
end

x=zeros(1,length(t));

for i=1:NO_Break_points+1
    
     t_start=find( ( ( t-mm(i) )>=0 ),1 );
    
    if i==(NB+1)
        t_finalf=find( ( ( t-mm(i+1) )<=0),1,'last');
    else
        t_final=find( ( ( t-mm(i+1) )<0),1,'last');
    end
    
    
    t_part=t(t_start:t_final); % this expresses the part of the time of each region
   
    type=input('enter the number of the specification of the signal you want:\n 1)DC \n 2)RAMP \n 3)General order polynomial \n 4)EXPONENTIAL \n 5)SINUSOIDAL \n 6)sinc \n 7)triangular pulse\n');
        if type == 1
            amp=input('enter the amplitude');
            x(t_start:t_final)=amp*ones( 1,length(t_part) );

        elseif type == 2
            slope=input('enter the slope');
            intercept=input('enter the intercepted part of y axis:');
            x(t_start:t_final)=slope*t_part+intercept;

        elseif type == 3
            amp=input('\nenter the amplitude:');
            power=input('\nEnter the power: ');
            intercept=input('\nenter the intercepted part of y axis:');
            x(t_start:t_final)=amp*(t_part.^power)+intercept;


        elseif type == 4
            amp=input('\nenter the amplitude: ');
            exponent=input('\nEnter the exponent: ');
            x(t_start:t_final)= amp*exp(expn*t_part);
            

        elseif type == 5
            amp=input('\nenter the amplitude: ');
            freq=input('\nenter the frequency: ');
            phaseshift=input('\nenter the phase shift: ');
            x(t_start:t_final)= amp*sin(2*pi*freq*t_part+phaseshift);



        elseif type == 6
            amp=input('\nenter the amplitude: ');
            x(t_start:t_final)=amp*sinc(t_part);



        elseif type == 7    




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
    x_shifted = circshift( x , shift); 
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the shifted signal.
    subplot(2,1,2);
    plot(t,x_shifted);
    title('Time Shifted signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 4  % Expanding the signal.
    % Ask the user for the expanding value.
    expanding = input('Enter the expanding value: ');
    % Expand the signal.
    ts_new = ts * expanding;
    t_new = Start_time : ts_new : End_time;
    x_expanded = interp( x , expanding);
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the expanded signal.
    subplot(2,1,2);
    plot(t_new,x_expanded);
    title('Time Expanded signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 5 % Compressing the signal.
    % Ask user to enter a compressing value.
    compression = input('Enter the compressing value: ');
	t_new = t / compression ;
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the compressed signal.
    subplot(2,1,2);
    plot(t_new,x);
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
    dx = diff(x)./diff(t);
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot first derivatve of the signal.
    subplot(2,1,2);
    plot(t,dx); % if there is error replace t( Start_time: End_time - 1 ) >> t
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