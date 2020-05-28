function output = GetFeatureSpace_MxN(app)

%% make MxN histo per trace
output = zeros(app.Data_struct.N_measurements, app.N.Value * app.M.Value);

if strcmp(app.YscaleDropDown.Value, 'Log')
    Y_array = linspace(log10(app.ROIYmin.Value), log10(app.ROIYmax.Value), app.M.Value);
else
    Y_array = linspace(app.ROIYmin.Value, app.ROIYmax.Value, app.M.Value);
end

if strcmp(app.XscaleDropDown.Value, 'Log')
    X_array = linspace(log10(app.ROIXmin.Value), log10(app.ROIXmax.Value), app.N.Value);
else
    X_array = linspace(app.ROIXmin.Value, app.ROIXmax.Value, app.N.Value);
end

for i = 1:app.Data_struct.N_measurements
        
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Linear')
        tmp = hist2(app.Data_struct.Data{i}(:,1), app.Data_struct.Data{i}(:,2),  X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Log')
        tmp = hist2(app.Data_struct.Data{i}(:,1), log10(app.Data_struct.Data{i}(:,2)),  X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Linear')
        tmp = hist2(log10(app.Data_struct.Data{i}(:,1)), app.Data_struct.Data{i}(:,2),  X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Log')
        tmp = hist2(log10(app.Data_struct.Data{i}(:,1)), log10(app.Data_struct.Data{i}(:,2)),  X_array, Y_array);
    end
    output(i,:) = tmp(:)';
    
end
