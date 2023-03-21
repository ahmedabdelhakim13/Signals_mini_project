promp1= 'Please enter the sampling frequency in KHz:';
Sampling_Frequency = input(promp1);

promp2='Please enter the start and end time scale';
Start_time = input(promp2);
End_time= input(promp2);
if (End_time <Start_time)
    while (End_time <Start_time)
    disp('the time inputs are wrong please insert again');
          Start_time = input(promp2);
         End_time = input(promp2);
    end
end

promp3='Please enter Number of break points';
Break_points = input(promp3);

for (Break_points;Break_points>0;Break_points-1)
promp4 ='Please enter the position\s of the break point\s';
Position=input(promp4);
