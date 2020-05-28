function set_settings_Default_MCBJ(app)

app.XlabelEditField.Value = 'Distance (nm)';
app.YlabelEditField.Value = 'Conductance (G/G_0)';
app.PlotXbins.Value = 0;
app.PlotYbins.Value = 201;
app.PlotXmin.Value = -0.5;
app.PlotXmax.Value = 2;
app.PlotYmin.Value = 1e-6;
app.PlotYmax.Value = 10;
app.XscaleDropDown.Value = 'Linear';
app.YscaleDropDown.Value = 'Log';

app.ROIXmin.Value = 0;
app.ROIXmax.Value = 2;
app.ROIYmin.Value = 1e-6;
app.ROIYmax.Value = 10;