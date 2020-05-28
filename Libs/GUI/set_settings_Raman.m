function set_settings_Default_Raman(app)

app.XlabelEditField.Value = 'Raman shift (cm^{-1})';
app.YlabelEditField.Value = 'Intensity';

app.PlotXbins.Value = 0;
app.PlotYbins.Value = 201;
app.PlotXmin.Value = 0;
app.PlotXmax.Value = 3000;
app.PlotYmin.Value = 0;
app.PlotYmax.Value = 100;
app.XscaleDropDown.Value = 'Linear';
app.YscaleDropDown.Value = 'Linear';

app.ROIXmin.Value = 0;
app.ROIXmax.Value = 3000;
app.ROIYmin.Value = 0;
app.ROIYmax.Value = 100;