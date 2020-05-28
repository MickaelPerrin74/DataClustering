function app = Read_data(app)

switch app.Measuretype_dropdown.Value
    case 'Custom'
        app = Read_data_Custom(app);
    case 'MCBJ_Delft'
        app = Read_data_MCBJ_Delft(app);
    otherwise
        app = Read_data_Default(app);

end
