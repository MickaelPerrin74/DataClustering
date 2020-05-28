function reset_status_window(app)
app.string = {'Written by Mickael Perrin', '<Mickael.Perrin@empa.ch>'};
app.ListBox_status.Items = app.string;
app.N_lines = length(app.string) + 1;