function clusterX = GetClusters_spectral(coords, params)

%---------------------------
% Bachelor Thesis
% Author : Ingo Bürk
% Year   : 2011/2012
%---------------------------
% CLUSTERING OPTIONS
%---------------------------

% Choose similarity graph type
% - 2 for epsilon neighborhood
% - 3 for k-Nearest neighbors
% - 4 for mutual k-Nearest neighbors
SimGraphType   = params.SimGraphType;

% Choose spectral clustering algorithm
% - 1 for unnormalized Clustering
% - 2 for normalized   Clustering (Shi and Malik)
% - 3 for normalized   Clustering (Jordan and Weiss)
ClusteringType = params.ClusteringType;

[N_points, ~ ] = size(coords);

if N_points > 200
    Paramk = 100;
else
    Paramk = round(N_points / 3);
end

ParamEps  = 0.4;

%---------------------------
% EXECUTE ALGORITHM AND PLOT
%---------------------------

% Parameter corresponding to SimGraphType (k or Eps)
switch SimGraphType
    case 2
        Param = ParamEps;
    case {3, 4}
        Param = Paramk;
end

% calculate adjacency matrix
W = SimGraph(coords', SimGraphType, Param, 1);

% compute clusters using spectral clustering
[ A, ~, ~ ] = SpectralClustering(W, params.N_clusters, params.N_clusters, ClusteringType);

clusterX = zeros(size(coords,1),1);
for i = 1:params.N_clusters
    clusterX(A(:,i) == 1) = i;
end
return