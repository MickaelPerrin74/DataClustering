function clusterX = GetClusters_SOM(coords, params)

%% Create a NN
% nodes_X = ceil(sqrt(N_clusters));
% nodes_Y = ceil(N_clusters/nodes_X);
nodes_X = 1;
nodes_Y = params.N_clusters;
network = [nodes_X nodes_Y];
net = selforgmap(network, 200, 3, 'hextop', params.algo);
net.trainParam.showWindow = false;

%% Train the Network
[net, ~] = train(net, coords');

%% Test the Network
outputs = net(coords');

clusterX = vec2ind(outputs)';