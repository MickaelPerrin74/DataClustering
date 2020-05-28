function clusterX = GetClusters_kmedoids(coords, params)

clusterX = kmedoids(coords, params.N_clusters);
