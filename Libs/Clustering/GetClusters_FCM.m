function clusterX = GetClusters_FCM(coords, params)

% parameters
data.X = coords;
data = clust_normalize(data,'range');
params.iter = 100;
params.Sigma = 'full';
params.SharedCovariance = false;
params.c = params.N_clusters;
results = FCMclust(data, params);
clusterX = results.clusterX;