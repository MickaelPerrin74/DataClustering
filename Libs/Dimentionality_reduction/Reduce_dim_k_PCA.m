function output = Reduce_dim_k_PCA(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get k-PCA
output = kpca_train(Data, 'dims', app.Data_struct.nDim);
output = output.mappedX;
