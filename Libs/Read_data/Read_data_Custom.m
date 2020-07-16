function app = Read_data_Custom(app)

%% Initialize
app.Data_struct.N_files = app.End_file.Value - app.Start_file.Value + 1;
app.Data_struct.Data = cell(app.Data_struct.N_files, 1);                                 % Preallocate cell array

%% Loop though files
counter = 1;
for i = app.Start_file.Value:app.End_file.Value
    
    data = readtable(sprintf('%s%s%1.0f.dat', app.Data_struct.filepath, app.Data_struct.filename, i));
    data = data(:,1:2);
    data = data.Variables;
    
    data = [NaN NaN; data; NaN NaN];
    
    startline = find(isnan(data(:,1)));
    
    for j = 1:length(startline)-1
        
        D_breaking = data(startline(j)+1:startline(j+1)-1, 1);
        G_breaking = data(startline(j)+1:startline(j+1)-1, 2);
        
        %% Store data
        app.Data_struct.Data(counter) = {cat(2, D_breaking, G_breaking)};
        counter =counter+1;
        
        %% update status windows
        if mod(i, 10) == 0
            str = sprintf('%s_%1.0f.dat', app.Data_struct.filename, i);
            update_status_window(app, str, false);
        end
        
    end
end

%% get number of measurements
app.Data_struct.N_measurements = counter - 1;

return