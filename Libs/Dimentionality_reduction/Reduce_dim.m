function data = Reduce_dim(app, DR, Data)

data = [];

switch DR
    case 'None'
        data.X = Data;
    case 'PCA'
        data.X = Reduce_dim_PCA(app, Data);
    case 'tSNE'
        data.X = Reduce_dim_tSNE(app, Data);
    case 'UMAP'
        data.X = Reduce_dim_UMAP(app, Data);
    case 'k-PCA'
        data.X = Reduce_dim_k_PCA(app, Data);
    case 'Autoencoder'
        data.X = Reduce_dim_AE(app, Data);
    case 'Multi dim. scal.'
        data.X = Reduce_dim_MDS(app, Data);
    case 'SNE'
        data.X = Reduce_dim_SNE(app, Data);
    case 'Sammon'
        data.X = Reduce_dim_Sammon(app, Data); 
   case 'Custom'
        data.X = Reduce_dim_Custom(app, Data);
end
