function app = Read_data_MCBJ_Delft(app)

%% settings
Vtodconversion = 0.3e-6;      % 1000V=300um
attenuation = 5e-5;      % 1000V=300um

%% get settings from first file
fid = fopen(sprintf('%s/%s_%1.0f.dat', app.Data_struct.filepath, app.Data_struct.filename, 1));
filecontent = textscan(fid,'%s','delimiter','\n');
filecontent = filecontent{:};
piezoline = strmatch('Breaking speed 2',filecontent);
motorline = strmatch('motor speed',filecontent);
axisline = strmatch('axis position',filecontent);
startline = strmatch('@',filecontent);
fclose(fid);

if ~isempty(piezoline)
    piezo = 1;
    tmp=strsplit(filecontent{piezoline});
    speed = str2double(tmp{5})*Vtodconversion;
end

if ~isempty(motorline)
    piezo = 0;
    tmp = strsplit(filecontent{motorline});
    speed = str2double(tmp{4}) * 1e-6;
end

%% Initialize
app.Data_struct.N_files = app.End_file.Value - app.Start_file.Value + 1;
app.Data_struct.Data = cell(app.Data_struct.N_files, 1);                                 % Preallocate cell array

%% Loop though files
counter = 1;
for i = app.Start_file.Value:app.End_file.Value
    fid = fopen(sprintf('%s/%s_%1.0f.dat', app.Data_struct.filepath, app.Data_struct.filename, i));
    data = textscan(fid,'%f %f %f','HeaderLines',startline(1)+1);  %f32 for single precision
    fclose(fid);
    
    Time_breaking = data{1};
    G_breaking = data{2};
    
    %% align at breaking point
    pos = find(G_breaking > 0.5,1,'last');
    Time_breaking = Time_breaking - Time_breaking(pos);
    D_breaking = Time_breaking * speed * attenuation * 1e9;
    
    %% Store data
    app.Data_struct.Data(counter) = {cat(2, D_breaking, G_breaking)};
    
    %% update status windows
    if mod(i, 10) == 0
        str = sprintf('%s_%1.0f.dat', app.Data_struct.filename, i);
        update_status_window(app, str, false);
    end
    
    %% update counter
    counter = counter + 1;
    
end

%% get number of measurements
app.Data_struct.N_measurements = counter - 1;

return