function output = Reduce_dim_tSNE(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get t-SNE
options = statset('MaxIter', 1000);
output = tsne(Data, 'Algorithm', 'barneshut', 'Distance', app.tSNEUMAPDistanceDropDown.Value, 'NumDimensions', app.Data_struct.nDim, 'verbose', 2, 'LearnRate', 1000, 'options', options);