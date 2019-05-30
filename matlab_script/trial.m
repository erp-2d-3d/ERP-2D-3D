time_file = fopen('time_records6.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

trial_num = 200;
time_pause = 1.5;
n = 10;
l = 10;
order = randperm(n,l);

for i = 1:19
    new_order = randperm(n,l);
    while (order(end) == new_order(1))
        new_order = randperm(n,l);
    end
    order = [order,new_order];
end

S = {'fbox1','fbox2','fbox3','fbox4','fbox5','fsphere1','fsphere2','fsphere3','fsphere4','fsphere5'};


fun_selector = randperm(4,4);
for j = 1:(trial_num/4)
    new_fun = randperm(4,4);
    while (fun_selector(end) == new_fun(1))
        new_fun = randperm(4,4);
    end
    fun_selector = [fun_selector,new_fun];
end

[y,Fs] = audioread('/Users/shirleyfan/Desktop/SineWave_440Hz.wav');
testobj = audioplayer(y,Fs);     % Create audioplayer object
play(testobj);  

for m = 1:trial_num
    idx = order(m);
    model = S(idx);
    
    switch fun_selector(m)
        case 1
            disp('perform half 3d to 2d');
            fun_Half3Dto2D(model,time_file,time_pause);
            
        case 2
%             disp('perform anaglyph to 2d');
%             fun_Anato2D(model,time_file,time_pause);
%             
%         case 3
            disp('perform 3d to 2d');
            fun_3Dto2D(model,time_file,time_pause);
            
        case 3
            disp('perform 2d to half 3d');
            fun_2DtoHalf3D(model,time_file,time_pause);
            
        case 4
%             disp('perform 2d to anaglyph');
%             fun_2DtoAna(model,time_file,time_pause);
%             
%         case 6
            disp('perform 2d to 3d');
            fun_2Dto3D(model,time_file,time_pause);
            
    end
    
    ques_idx = randi(4);
    %pause(0.5);
    
    dsiURL = 'http://gdo-appsdev.dsi.ic.ac.uk:9080/section';
    options = weboptions('MediaType','application/json');
    data0 = black_screen(dsiURL,options);
    
    %3rd HTTP POST = add mask
    fprintf(time_file, 'Third post (add mask): %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
    data5 = struct('space','DO3D-depth','x','0','y','0','w','7680','h','2160');
    data5.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083');
    data5.app.states = struct('load',struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=8b8b8bff'));
    response3 = webwrite(dsiURL,data5,options);
    
    fprintf(time_file, 'Feedback post: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
    data1 = struct('space','DO3D','x','1920','y','1080','w','1920','h','1080');
    data1.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
    modelname1 = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/','question',string(ques_idx),'.jpg');
    config1 = struct('tileSources', struct('type', 'image', 'url', string(modelname1)));
    viewport1 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
    data1.app.states = struct('load',struct('config', config1, 'viewport', viewport1));
    response2 = webwrite(dsiURL,data1,options);
    
    pause(2.0);

     data2 = delete_black(strcat(dsiURL, 's/0'),options);
    
     pause(1.5);
end

fclose(time_file);
