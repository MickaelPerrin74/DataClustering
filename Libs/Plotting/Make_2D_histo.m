function [images, X_array, Y_array] = Make_2D_histo(app)

% make 2D histogram
if strcmp(app.YscaleDropDown.Value, 'Log')
    Y_array = linspace(log10(app.PlotYmin.Value), log10(app.PlotYmax.Value), app.PlotYbins.Value);
else
    Y_array = linspace(app.PlotYmin.Value, app.PlotYmax.Value, app.PlotYbins.Value);
end

if strcmp(app.XscaleDropDown.Value, 'Log')
    X_array = linspace(log10(app.PlotXmin.Value), log10(app.PlotXmax.Value), app.PlotXbins.Value);
else
    if app.PlotXbins.Value == 0
        X_array  = app.PlotXmin.Value : 2*mean(diff(app.Data_struct.Data{1}(:,1))) : app.PlotXmax.Value;
    else
        X_array = linspace(app.PlotXmin.Value, app.PlotXmax.Value, app.PlotXbins.Value);
    end
end

images = zeros(length(Y_array), length(X_array), app.Data_struct.N_measurements);
for i = 1:app.Data_struct.N_measurements
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Linear')
        images(:,:,i) = hist2(app.Data_struct.Data{i}(:,1), app.Data_struct.Data{i}(:,2), X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Log')
        images(:,:,i) = hist2(app.Data_struct.Data{i}(:,1), log10(app.Data_struct.Data{i}(:,2)), X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Linear')
        images(:,:,i) = hist2(log10(app.Data_struct.Data{i}(:,1)), app.Data_struct.Data{i}(:,2), X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Log')
        images(:,:,i) = hist2(log10(app.Data_struct.Data{i}(:,1)), log10(app.Data_struct.Data{i}(:,2)), X_array, Y_array);
    end
end