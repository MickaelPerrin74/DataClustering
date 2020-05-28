function result = GMMclust(data,param)

options = statset(); % Increase number of EM iterations

gmfit = fitgmdist(data.X,param.c,'CovarianceType',param.Sigma,...
    'SharedCovariance',param.SharedCovariance,'Start','Plus',...
    'Replicates',param.iter,'Options',options);
result.clusterX = cluster(gmfit,data.X);

result.CoM_idx = zeros(param.c,1);
for i=1:param.c
    CoM_coords(i,:) = gmfit.mu(i,:);
end

Dist = zeros(length(data.X),1);
for i=1:param.c
    CoM = CoM_coords(i,:);
    for j=1:length(CoM)
        Dist = Dist + (data.X(:,j)-CoM(j)).^2;
    end
    [~,result.CoM_idx(i)] = min(sqrt(Dist));
end

