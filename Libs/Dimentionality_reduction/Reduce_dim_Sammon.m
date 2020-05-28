function output = Reduce_dim_Sammon(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get Sammon
output = compute_mapping(Data, 'Sammon', app.Data_struct.nDim);