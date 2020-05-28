function app = Get_files_MCBJ_Delft(app)

%% get filename
app.Data_struct.filename = app.file;
idx = regexp(app.Data_struct.filename, '_');
app.Data_struct.filename = app.Data_struct.filename(1:idx(end)-1);

%% check number of files
check = 2;
i = 1;
while check == 2
    check = exist(sprintf('%s/%s_%1.0f.dat', app.Data_struct.filepath, app.Data_struct.filename, i), 'file');
    i = i + 1;
end

app.Data_struct.N_files = i-2;
