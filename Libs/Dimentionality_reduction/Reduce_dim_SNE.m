function output = Reduce_dim_SNE(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get SNE
output = compute_mapping(Data, 'SNE', app.Data_struct.nDim);