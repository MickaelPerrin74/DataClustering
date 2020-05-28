function clusterX = GetClusters_OPTICS(coords, params)

%% run OPTICS algorithms
[ SetOfClusters, RD, CD, order ] = cluster_optics(coords, params.minPoints, params.epsilon);

%% select most prominent peaks
clusterX = zeros(length(order), 1);
[pks,locs,w,p] = findpeaks(RD(order));

[~,idx] = sort(p, 'descend');
locs = locs(idx);
locs = locs(1:params.N_clusters-1);
locs = [1 locs length(order)];
locs = sort(locs);

%% make clusters
for i = 1:length(locs)-1
    clusterX(order(locs(i):locs(i+1))) = i;
end
