time_file = fopen('time_records1_rate.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

S = {'camera1','camera2','camera3','camera4','camera5','camera6','camera7','camera8','camera9','camera10'};

selector = randperm(10,5);

seq_3d = S(selector);
S(selector) = [];
seq_2d = S;

fid = fopen('seq_3d.txt','w');
seq_3dT = seq_3d.';
fprintf(fid,'%s\n', seq_3dT{:});
fclose(fid);

fid2 = fopen('seq_2d.txt','w');
seq_2dT = seq_2d.';
fprintf(fid2,'%s\n', seq_2dT{:});
fclose(fid2);

[y,Fs] = audioread('/Users/shirleyfan/Desktop/SineWave_440Hz.wav');
testobj = audioplayer(y,Fs);     % Create audioplayer object
play(testobj);

sequence = randperm(10,10);

for m = 1:10
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