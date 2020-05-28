function set_settings(app)

value = app.Measuretype_dropdown.Value;

switch value
    
    case 'Default'
        set_settings_Default(app)
        
    case 'Custom'
        set_settings_Custom(app)
        
    case {'MCBJ', 'MCBJ_Delft'}
        set_settings_MCBJ(app)
        
    case 'Raman'
        set_settings_Raman(app)
        
end