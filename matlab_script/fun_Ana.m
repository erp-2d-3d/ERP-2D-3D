function [ output_args ] = fun_Ana( model,time_file,time_pause )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%POST instead of DELETE
fprintf(time_file, 'First delete: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
newURL = 'http://gdo-appsdev.dsi.ic.ac.uk:8083/sections';
options = weboptions('MediaType','application/json');
response0 = webwrite(newURL,{},options);
pause(0.5);

dsiURL = 'http://gdo-appsdev.dsi.ic.ac.uk:9080/section';

data0 = black_screen(dsiURL,options);

%1st HTTP POST
data1 = struct('space','DO3D','x','1920','y','1080','w','1920','h','1080');
data1.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
model1 = char(model);
model1 = model1(2:end);
modelname1 = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model1,'-ana','.jpg');
config1 = struct('tileSources', struct('type', 'image', 'url', string(modelname1)));
viewport1 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
data1.app.states = struct('load',struct('config', config1, 'viewport', viewport1));
response1 = webwrite(dsiURL,data1,options);

pause(2.5);

data2 = delete_black(strcat(dsiURL, 's/0'),options);

pause(time_pause);


end

