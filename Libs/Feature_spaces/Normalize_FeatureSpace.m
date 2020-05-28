function [feature_space, feature_space_raw] = Normalize_FeatureSpace(app, data)

switch app.NormalizationDropDown.Value
    case 'None'
        feature_space = data.X;
    case 'Range'
        data = clust_normalize(data,'range'); feature_space = data.X; feature_space_raw = data.Xold;
    case 'Standard deviation'
        data = clust_normalize(data,'var'); feature_space = data.X; feature_space_raw = data.Xold;
end
