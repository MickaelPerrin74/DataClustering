function clusterX = GetClusters_kmeans(coords, params)

clusterX = kmeans(coords, params.N_clusters);
