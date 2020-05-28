function ClusterX = GetClusters(app, CA, fieldname_reduc)

%% initialize
feature_space = app.Data_struct.Feature_spaces.(fieldname_reduc).data;
N_clusters = length(app.Data_struct.Clusters);
ClusterX = zeros(app.Data_struct.N_measurements, N_clusters);

%% get clusters
switch CA
    
    case 'k-means'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_kmeans(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'k-mediods'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_kmedoids(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Gust.-Kessel'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_GK(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Gath-Geva'
        
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_GG(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Fuzzy c-means'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_FCM(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'SOM'
        param.algo = 'linkdist';
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_SOM(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'GMM'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_GMM(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'OPTICS'
        param.minPoints = 50;
        param.epsilon = 0.02;
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_OPTICS(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Hierarchical'
        Z = linkage(feature_space, app.hierarchicalDropDown.Value);
        for l=1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            ClusterX(:,l) = GetClusters_hier(Z, param);
        end
        
    case 'Spectral (S&M)'
        param.ClusteringType = 2;
        param.SimGraphType = 3;
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_spectral(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Spectral (J&W)'
        param.ClusteringType = 3;
        param.SimGraphType = 3;
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_spectral(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Graph av. link.'
        for l = 1:N_clusters
            param.method = 'average';
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_GAC(feature_space, param); catch LE; disp(LE); end
        end
        
    case 'Graph deg. link'
        for l = 1:N_clusters
            param.method = 'degree';
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_GAC(feature_space, param); catch LE; disp(LE); end
        end   
     
    case 'Custom'
        for l = 1:N_clusters
            param.N_clusters = app.Data_struct.Clusters(l);
            try ClusterX(:,l) = GetClusters_Custom(feature_space, param); catch LE; disp(LE); end
        end
        
%     case 'Hier. Max. Like.'
%         for l = 1:N_clusters
%             param.N_clusters = app.Data_struct.Clusters(l);
%             try ClusterX(:,l) = GetClusters_HML(feature_space, param); catch LE; disp(LE); end
%         end
        
%     case 'CURE'
%         param.c = 5;
%         param.alpha = 1;
%         for l = 1:N_clusters
%             param.N_clusters = app.Data_struct.Clusters(l);
%             try ClusterX(:,l) = GetClusters_CURE(feature_space, param); catch LE; disp(LE); end
%         end
%         
%     case 'Affinity propagation'
%         param.type = 1; % Euclidean distance for similarity matrix
%         for l = 1:N_clusters
%             param.N_clusters = app.Data_struct.Clusters(l);
%             try ClusterX(:,l) = GetClusters_AP(feature_space, param); catch LE; disp(LE); end
%         end
        
    case 'Density'
        ClusterX = GetClusters_density(feature_space);
end