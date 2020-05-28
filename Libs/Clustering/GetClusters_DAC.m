function ClusterX = GetClusters_DAC(image_data, params)

[N_files, ~] = size(image_data);
num_cluster = params.N_clusters;
[~, heigth, width] = size(image_data);

image_data = image_data / max(max(max(image_data)));

save('Python/DAC/image_data.mat', 'image_data','num_cluster','heigth','width');

system('C:\Users\the_r\Anaconda3\Scripts\activate.bat C:\Users\the_r\Anaconda3 && C:\Users\the_r\Anaconda3\python Python/DAC/Classify.py');

try
    ClusterX = importdata('Python/DAC/ClusterX.dat')+1;
    delete('Python/DAC/ClusterX.dat');
catch
    ClusterX = zeros(N_files, 1);
end