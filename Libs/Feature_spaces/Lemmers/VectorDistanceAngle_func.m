function [theta, ham_dist, dX] = VectorDistanceAngle_func(G,Ref)
% gives the angle theta in rad and the norm of the distance vector
% Input is the normalised current vectors

%% Preallocate variables for speed

N_files = length(G);              % Number of current vectors
dX = zeros(N_files,1);            % Preallocate Norm
theta = zeros(N_files,1);             % Preallocate angle
ham_dist = zeros(N_files,1);                            % Preallocate Hamming Matrix

%% Calculate theangle between each Yi and the vector from average to ref

for i = 1:N_files
    fprintf('analyzing vectors %1.0f-%1.0f\n', i, N_files);
    Conductance = G{i};
    
    try
        ref = Ref(1:length(Conductance));
        
        %%
        
        %     ref=Ref;
        %     cut_off_G1=3e-6;        % cutoff data
        %     cut_off_G2=3.00001e-6;        % cutoff reference
        
        %     strom(strom<log10(cut_off_G1))=log10(cut_off_G1);
        %     ref(ref<log10(cut_off_G2))=log10(cut_off_G2);
        
        %% vector length and angle
        Y = (Conductance - ref)/numel(ref);
        %     Y = (Conductance - ref);
        dX(i) = norm(Y);                             % Calculate norm of distance vector
        dot_product = (-Y'*ref);                     % Calculate dot product (-Y because vector points towards the reference point)
        
        theta(i) = acos(dot_product/dX(i)/norm(ref));  % Inverse cosine in rad
        
        %% hamming distance
        Y_binary = (Y./abs(Y));                         % Binary Vectors: Y is the distance vector between Reference Vector and I(s) vector (Note: Not really binary, 3 states possible)
        tmp = cat(2,ref./abs(ref),Y_binary);     % Concatenate ith I(s) vector with reference vector
        ham_dist(i) = pdist(real(tmp)','hamming');          % For each binary distance vector calculate the distance to binary reference vector
    end
end

end
