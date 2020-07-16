function app = Read_data_Custom(app)

%% Initialize

app.Data_struct.N_files = app.End_file.Value - app.Start_file.Value + 1;
app.Data_struct.Data = cell(app.Data_struct.N_files, 1);                                 % Preallocate cell array

%% run through files
counter = 1;
for i = app.Start_file.Value:app.End_file.Value
    
    %% Place here custom loading routine
    
    
    %% update status windows
    if mod(i, 10) == 0
        str = sprintf('Loading %s', app.Data_struct.FileList{i});
        update_status_window(app, str, false);
    end
    
    %% update counter
    counter = counter + 1;
    
end

app.Data_struct.N_measurements = counter - 1;

return