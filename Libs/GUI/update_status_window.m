function update_status_window(app, string, newLine)
app.string{app.N_lines} = string;
app.ListBox_status.Items = app.string;
app.ListBox_status.scroll('bottom')

if newLine
    app.N_lines = app.N_lines + 1;    
end

drawnow