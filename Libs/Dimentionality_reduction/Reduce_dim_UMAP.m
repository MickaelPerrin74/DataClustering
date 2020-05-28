function output = Reduce_dim_UMAP(app, Data)

%% remove empty dimensions
Data(:,sum(Data)==0)=[];

%% get UMAP
inData = Data;
p=parseArguments();
parse(p,'');
args=p.Results;

umap = UMAP;

umap.metric = app.tSNEUMAPDistanceDropDown.Value;
umap.n_neighbors = args.n_neighbors;
umap.min_dist = args.min_dist;

umap.verbose=~strcmpi(args.verbose, 'none');
umap.random_state=~args.randomize;

if args.label_column==0 || args.label_column>C
    reduction = umap.fit_transform(inData);
else
    reduction = umap.fit_transform(inData, labels);
    if ~isempty(reduction)
        if ~isempty(labelMap)
            umap.setSupervisors(labels, labelMap, curAxes);
        end
    end
end

umap = UMAP;
umap.n_components = app.Data_struct.nDim;

output = umap.fit_transform(Data);

    function ok=validateParameterNames(x)
        ok=false;
        if iscell(x)
            N=length(x);
            if N>0
                for i=1:N
                    if ~ischar(x{i})
                        ok=false;
                        return;
                    end
                end
                ok=true;
            end
        end
    end

    function p=parseArguments(varargin)
        p = inputParser;
        defaultMetric = 'euclidean';
        expectedMetric = {'euclidean', 'cosine', 'cityblock', 'seuclidean',...
            'squaredeuclidean', 'correlation', 'jaccard', 'spearman', 'hamming'};
        defaultVerbose= 'graphic';
        expectedVerbose = {'graphic','text','none'};
        defaultMethod='Java';
        expectedMethod={'Java', 'C', 'C vectorized', 'MatLab', 'MatLab vectorized'};
        addOptional(p,'csv_file_or_data',[],@(x) ischar(x) || isnumeric(x));
        addParameter(p,'ask_to_save_template', false, @islogical);
        addParameter(p,'randomize', false, @islogical);
        addParameter(p,'template_file',[], @ischar);
        addParameter(p,'n_neighbors', 30, @(x) isnumeric(x) && x>2 && x<200);
        addParameter(p,'min_dist', .3, @(x) isnumeric(x) && x>.05 && x<.8);
        addParameter(p,'metric', defaultMetric, ...
            @(x) any(validatestring(x,expectedMetric)));
        addParameter(p,'verbose',defaultVerbose,...
            @(x) any(validatestring(x,expectedVerbose)));
        addParameter(p,'method',defaultMethod,...
            @(x) any(validatestring(x,expectedMethod)));
        addParameter(p, 'parameter_names', {}, @validateParameterNames);
        addParameter(p, 'progress_callback', ...
            @(javaObject)progress_report(javaObject), @validateCallback);
        addParameter(p,'label_column',0,@(x) isnumeric(x) && x>0);
        addParameter(p,'label_file',[], @ischar);
    end
end
