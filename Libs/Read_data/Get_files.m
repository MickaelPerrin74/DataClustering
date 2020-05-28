function app = Get_files(app)

switch app.Measuretype_dropdown.Value
    case 'Custom'
        app = Get_files_Custom(app);
    case 'MCBJ_Delft'
        app = Get_files_MCBJ_Delft(app);
    otherwise
        app = Get_files_Default(app);

end