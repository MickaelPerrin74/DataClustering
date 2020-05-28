# DataClustering
 This graphical tool is designed for the clustering of univariate measurements. This allows for the use of various feature space contruction methods, dimentionality reduction methods and clustering algorithms. 
 
 Details on how to run the app: 
1.	Run the app Clustering_app_autoreflow.mlapp from Matlab.
2.	Select a predefined measurement type (the default is 'Default'). This step will adjust labels, axes etc… In all measurements, data is assumed to be in columns. The first column is the x-axis (the parameter that is varied), the remaining columns are measurements. All files in the directory will be read. Headers to skip are also possible (just add a custom header symbol). This step can also be done after step 3, except for measurement type 'MCBJ Delft' as this is a custom (different) format.
3.	Adjust measurement file range and press 'Import data'. This will also create a 2D histogram of the measurement.
4.	Adjust region of interest, plotting range, scales, etc…. if needed. Press the 'Replot' button to check it is correctly done.
5.	Select Feature space and dimensionality reduction algorithm (multiple are allowed) and press 'Create feature space'.
6.	Select the clustering algorithm (multiple are allowed) and Press 'Run clustering'.
7.	Press 'Plot clusters' to plot the feature spaces and 2D histograms of the clustered data.
8.	Enjoy!

Note 1: All analysis is saved in a \*.mat file in the output directory. It contains a structure 'Data' with as fields all the used settings. The feature space and clustering data are stored in the fields 'Feature_spaces' and 'Clustering'. If required, ASCII output of the feature spaces and clusters is also possible.
Note 2: When numbering your files, use leading zeros if the order matters. For speeds reasons, Matlab collects all files present in the directory, sorted alphabetically. Measurements labelled file1, file2… file100 will be sorted as follows: file1, file10, file100, file2. This is not the case for the 'MCBJ Delft' measurement type, but that makes generating the file list much slower. 

When using this software for publication, please cite the article '**Universal approach for unsupervised classification of univariate data**' by Maria El Abbassi, Jan Overbeck, Oliver Braun, Michel Calame, Herre S.J. van der Zant, Mickael L. Perrin. https://arxiv.org/abs/2004.14271
