time_file = fopen('time_records7.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
time_pause=1.5;
S = {'fbox1','fbox2','fbox3','fbox4','fbox5','fsphere1','fsphere2','fsphere3','fsphere4','fsphere5'};
order = randperm(10,10);

for i = 1:1
    model = S(i);
    %fun_Half3Dto2D(model,time_file,time_pause);
    fun_3D(model,time_file,time_pause);
end
fclose(time_file);
