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
        
    tmp_X = app.Data_struct.Data{i}(:,1);
    tmp_Y = app.Data_struct.Data{i}(:,2);
    
    idx =  tmp_X > app.ROIXmin.Value & tmp_X < app.ROIXmax.Value & tmp_Y > app.ROIYmin.Value & tmp_Y < app.ROIYmax.Value;
    
    tmp_X = tmp_X(idx);
    tmp_Y = tmp_Y(idx);
    
    if sum(idx) ~= 0
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Linear')
        Histo = hist2(tmp_X, tmp_Y, X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Log')
        Histo = hist2(tmp_X, log10(tmp_Y),  X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Linear')
        Histo = hist2(log10(tmp_X), tmp_Y,  X_array, Y_array);
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Log')
        Histo = hist2(log10(tmp_X), log10(tmp_Y),  X_array, Y_array);
    end
    output(i,:) = Histo(:)';
    end
    
end
