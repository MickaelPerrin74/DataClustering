function ClusterX = GetClusters_density(coords)

[N_traces, ~] = size(coords);

%% get distances
disp('getting pairwise distances...')
Dist = pdist2(coords,coords,'Euclidean');
idx_start = repmat(1:N_traces,N_traces,1);
idx_end = repmat((1:N_traces)',1,N_traces);

idx_start = triu(idx_start);
idx_end = triu(idx_end);

Dist_pairs = [idx_end(:) idx_start(:) Dist(:)];
Dist_pairs(Dist_pairs(:,3)==0,:) = [];

%% get rho
disp('getting rho...')
N = size(Dist_pairs,1);
percent = 2.0;

position = round(N * percent / 100);
sda = sort(Dist_pairs(:,3));
dc = sda(position);

rho = sum(exp(-(Dist/dc).*(Dist/dc)));

%% get delta
disp('getting delta...')
maxd=max(max(Dist));

[~,ordrho] = sort(rho,'descend');
delta(ordrho(1)) = -1.;
nneigh(ordrho(1)) = 0;

for ii=2:N_traces
    delta(ordrho(ii)) = maxd;
    for jj=1:ii-1
        if(Dist(ordrho(ii),ordrho(jj))<delta(ordrho(ii)))
            delta(ordrho(ii)) = Dist(ordrho(ii),ordrho(jj));
            nneigh(ordrho(ii)) = ordrho(jj);
        end
    end
end
delta(ordrho(1)) = max(delta(:));

%% plot decision plot
disp('Select a rectangle enclosing cluster centers')
h=figure;

plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
title ('Decision Graph','FontSize',15.0)
xlabel ('\rho')
ylabel ('\delta')
set(gca,'yscale','log')
figure(h)
A = drawpolygon(gca);
Poly_pos = A.Position;

%% get point in polygon
numCluster = 0;
Coords = zeros(1,2);
index = [];
for i=1:N_traces
    if inpolygon(rho(i), delta(i), Poly_pos(:,1), Poly_pos(:,2))
        numCluster = numCluster + 1;
        Coords(numCluster,:) = [rho(i) delta(i)];
        index(numCluster) = i;
    end
end

[~, idx] = sort(Coords(:,1),'descend');
Coords = Coords(idx,:);
index = index(idx);

%% make clusters
ClusterX = zeros(N_traces, numCluster); 
for j = 2:numCluster
    
    clusterX = -ones(N_traces,1);
    clusterX(index(1:j)) = index(1:j);
    
    %assignation
    for i = 1:N_traces
        if (clusterX(ordrho(i)) == -1)
            clusterX(ordrho(i)) = clusterX(nneigh(ordrho(i)));
        end
    end
    
    ClusterX(:,j-1) = sum((clusterX==index).*(1:numCluster),2);
    
    %%
end