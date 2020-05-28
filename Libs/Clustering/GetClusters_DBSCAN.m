function clusterX = GetClusters_DBSCAN(coords, params)

clusterX = dbscan(coords, params.epsilon, params.minPoints); % The default distance metric is Euclidean distance


