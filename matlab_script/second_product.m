time_file = fopen('time_records2_pro.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

S = {'camera1','camera2','camera3','camera4','camera5','camera6','camera7','camera8','camera9','camera10'};

order = importdata('product_order2.txt');

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
        fun_2D_pro(model,time_file,time_pause);
    else
        disp('perform 3d');
        disp(model);
        fprintf(time_file, 'The model %s is performing 3d\n',char(model));
        fun_3D_pro(model,time_file,time_pause);
   
    end
    
end


fclose(time_file);
