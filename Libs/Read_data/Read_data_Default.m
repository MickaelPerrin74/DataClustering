function app = Read_data_Default(app)

%% Initialize
app.Data_struct.Data.N_files = app.End_file.Value - app.Start_file.Value + 1;
app.Data_struct.Data = cell(app.Data_struct.N_files, 1);                                 % Preallocate cell array

%% loop through files
counter = 1;
for i = app.Start_file.Value:app.End_file.Value
    
    %% construct filename
    filename = sprintf('%s%s', app.Data_struct.filepath, app.Data_struct.FileList{i});
    
    %% get headerlines
    if ~isempty(app.HeaderEditField.Value)
        fid = fopen(filename);
        filecontent = textscan(fid,'%s','delimiter','\n');
        filecontent = filecontent{:};
        headerlines = strmatch(app.HeaderEditField.Value, filecontent);
        fclose(fid);
        
        if ~isempty(headerlines)
            headerlines = 0;
        end
    else
        headerlines = 0;
    end
    
    %% get x and y labels
    data = readtable(filename,'HeaderLines', headerlines(1), 'PreserveVariableNames',true);
    
    if i == app.Start_file.Value
        app.Data_struct.Xlabel = data.Properties.VariableNames{1};
        app.Data_struct.Ylabel = data.Properties.VariableNames{2};
        app.XlabelEditField.Value = app.Data_struct.Xlabel;
        app.YlabelEditField.Value = app.Data_struct.Ylabel;
    end
    
    %% read data
    X = data(:,1).Variables;
    
    [~, n2] = size(data);
    for j = 2:n2
        Y = data(:,j).Variables;
        app.Data_struct.Data(counter, 1) = {cat(2, X, Y)};
        counter = counter + 1;
    end
    
    %% update status windows
    if mod(i, 10) == 0
        str = sprintf('Loading %s', app.Data_struct.FileList{i});
        update_status_window(app, str, false);
    end

end

%% get total number of measurements
app.Data_struct.N_measurements = counter - 1;

return