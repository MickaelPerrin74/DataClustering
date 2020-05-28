function output = Reduce_dim_AE(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get autocoder
output = compute_mapping(Data, 'Autoencoder', app.Data_struct.nDim);
