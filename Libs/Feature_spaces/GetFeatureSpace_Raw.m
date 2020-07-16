function [output, X_max] = GetFeatureSpace_Raw(app)

%% get maximum trace length
L = 0;
for i = 1:app.Data_struct.N_measurements
    if length(app.Data_struct.Data{i}(:,1)) > L
        L = length(app.Data_struct.Data{i}(:,1));
        X_max = app.Data_struct.Data{i}(:,1);
    end
end

%% append zeros to measurements if needed
output = zeros(app.Data_struct.N_measurements, L);
for i = 1:app.Data_struct.N_measurements
    
    if strcmp(app.YscaleDropDown.Value, 'Linear')
        output(i, 1:length(app.Data_struct.Data{i}(:,2))) = app.Data_struct.Data{i}(:,2);
    end
    if strcmp(app.YscaleDropDown.Value, 'Log')
        output(i, 1:length(app.Data_struct.Data{i}(:,2))) = log10(app.Data_struct.Data{i}(:,2));
    end
    
end
