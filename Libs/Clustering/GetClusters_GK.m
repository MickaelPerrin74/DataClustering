function clusterX = GetClusters_GK(coords, params)

% parameters
data.X = coords;
data = clust_normalize(data,'range');
params.iter = 100;
params.Sigma = 'full';
params.SharedCovariance = false;
params.c = params.N_clusters;
results = GKclust(data, params);
clusterX = results.clusterX;