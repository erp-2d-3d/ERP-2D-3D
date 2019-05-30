time_file = fopen('time_records2_rate.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

S = {'camera1','camera2','camera3','camera4','camera5','camera6','camera7','camera8','camera9','camera10','camera11','camera12','camera13','camera14','camera15','camera16','camera17','camera18','camera19','camera20'};

seq_3d = importdata('seq_3d.txt');
seq_3d = seq_3d.';

seq_2d = importdata('seq_2d.txt');
seq_2d = seq_2d.';

new_3d = {'camera11','camera12','camera13','camera14','camera15'};
new_2d = {'camera16','camera17','camera18','camera19','camera20'};

seq_3d = horzcat(seq_3d,new_3d);
seq_2d = horzcat(seq_2d,new_2d);

[y,Fs] = audioread('/Users/shirleyfan/Desktop/SineWave_440Hz.wav');
testobj = audioplayer(y,Fs);     % Create audioplayer object
play(testobj);

sequence = randperm(20,20);

for m = 1:20
    idx = sequence(m);
    model = S(idx);
    
    %POST instead of DELETE
    fprintf(time_file, 'First delete: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
    newURL = 'http://gdo-appsdev.dsi.ic.ac.uk:8083/sections';
    options = weboptions('MediaType','application/json');
    response0 = webwrite(newURL,{},options);
    pause(0.5);

    dsiURL = 'http://gdo-appsdev.dsi.ic.ac.uk:9080/section';
    
    if ismember(model,seq_3d) == 1
        disp('perform 3d');
        fprintf(time_file, 'The model %s is performing 3d\n',char(model));
        
        fun_3D_pro( model,time_file,3.0 );
    else
        disp('perform 2d');
        fprintf(time_file, 'The model %s is performing 2d\n',char(model));
        
        fun_2D_pro( model,time_file,3.0 );
    end
    
    data0 = black_screen(dsiURL,options);
    
    pause(5.0);

    data2 = delete_black(strcat(dsiURL, 's/0'),options);

end
   
fclose(time_file);