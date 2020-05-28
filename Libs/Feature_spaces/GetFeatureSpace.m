function Data = GetFeatureSpace(app, FS)

switch FS
    case 'Raw'
        Data = GetFeatureSpace_Raw(app);
    case 'M x N'
        Data = GetFeatureSpace_MxN(app);
    case 'Lemmers et al.'
        Data = GetFeatureSpace_Lemmers(app);
    case 'Custom'
        Data = GetFeatureSpace_Custom(app);
end