time_file = fopen('time_records2_ana.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

S = {'fbox1','fbox2','fbox3','fbox4','fbox5','fsphere1','fsphere2','fsphere3','fsphere4','fsphere5'};

order = importdata('ana_order2.txt');

[y,Fs] = audioread('/Users/shirleyfan/Desktop/SineWave_440Hz.wav');
testobj = audioplayer(y,Fs);     % Create audioplayer object
play(testobj);  

for m = 1:length(order)
    idx = order(m);
    i = string(idx);
    j = char(i);
    j = j(end);
    j = str2double(j)+1;
    model = S(j);
    

    if (idx > 100)
        disp('perform 2d');
        disp(model);
        
        fprintf(time_file, 'The model %s is performing 2d\n',char(model));
        fun_2D(model,time_file,time_pause);
    else
        disp('perform Anaglph');
        disp(model);
        fprintf(time_file, 'The model %s is performing Anaglph\n',char(model));
        fun_Ana(model,time_file,time_pause);
    end
    
 
end
 
    
fclose(time_file);
