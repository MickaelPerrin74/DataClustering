function output = Reduce_dim_MDS(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get MDS
output = compute_mapping(Data, 'MDS', app.Data_struct.nDim);