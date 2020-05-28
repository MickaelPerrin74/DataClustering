function app = Get_files_Default(app)

%% get directory content
list = dir(sprintf('%s*%s', app.Data_struct.filepath, app.fileext));
app.Data_struct.FileList = {list.name}';
app.Data_struct.N_files = length(app.Data_struct.FileList);

%% get filename
idx = regexp(app.Data_struct.filepath,'\');
app.Data_struct.filename = app.Data_struct.filepath(idx(end-1) + 1: idx(end) - 1);