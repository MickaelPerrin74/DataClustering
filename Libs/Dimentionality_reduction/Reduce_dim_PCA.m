function output = Reduce_dim_PCA(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get PCA
output = pca(Data, app.Data_struct.nDim);
output = output(:,1:app.Data_struct.nDim); 