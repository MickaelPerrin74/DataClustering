function clusterX = GetClusters_GAC(coords, params)

dist_mat = sqdist_pw(coords', coords');
clusterX = gac_cluster(dist_mat, params.N_clusters, params.method);

