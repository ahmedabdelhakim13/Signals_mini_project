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
    plot(t,x_expanded);
    title('Time Expanded signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    
elseif operation == 5 % Compressing the signal.
    % Ask user to enter a compressing value.
    compression = input('Enter the compressing value: ');
    % Compress the signal
    x_compressed = x( Start_time : compression : End_time);
    % Plot the original signal.
    subplot(2,1,1);
    plot(t,x);
    title('Original Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
    % Plot the compressed signal.
    subplot(2,1,2);
    plot(t(1:compression:end),x_compressed);
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
    plot(t(1:end-1),dx);
    title('First Derivative of Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;    
elseif operation == 8 % None. 
    % Perform no operation on the signal.
end