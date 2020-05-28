function clusterX = GetClusters_GMM(coords, params)

options = statset(); % Increase number of EM iterations
params.iter = 100;
params.Sigma = 'full';
params.SharedCovariance = false;

gmfit = fitgmdist(coords, params.N_clusters, 'CovarianceType', params.Sigma,...
    'SharedCovariance', params.SharedCovariance, 'Start', 'Plus',...
    'Replicates', params.iter, 'Options', options);

clusterX = cluster(gmfit, coords);