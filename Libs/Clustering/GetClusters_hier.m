function clusterX = GetClusters_hier(Z, params)

clusterX = cluster(Z, 'maxclust', params.N_clusters);
