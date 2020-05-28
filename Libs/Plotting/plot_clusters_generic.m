function fig = plot_clusters_generic(app, images, X_array, Y_array, clusterX)

%% make figure
if app.HideplotsCheckBox.Value
    fig = figure('visible','off');
else
    fig = figure('visible','on');
end

%% Initialize
N_cluster = max(clusterX);

%% set colors
cmap = dlmread('cmap');
colormap(cmap)
cmap_clusters = parula(N_cluster);
cmap_clusters = vertcat(cmap_clusters,[0 0 0]);

%% run through clusters
counter = 1;

%% partition figure
N_plots_X = ceil(sqrt(N_cluster + 1));
N_plots_Y = ceil((N_cluster + 1)/N_plots_X);

figure_size = get(0, 'screensize');
figure_size = round([100 100 figure_size(4)*0.8*N_plots_X/N_plots_Y figure_size(4)*0.8]);

set(fig,'position',figure_size)

%% loop through clusters
for index = 1:N_cluster+1
    
    % get traces
    if index == N_cluster+1
        idx = (clusterX~=0);
        Title = 'all';
    else
        idx = (clusterX==index);
        Title = sprintf('Cluster %1.0f - %1.2f%%', index, sum(clusterX==index) / app.Data_struct.N_measurements * 100);
    end
    
    HISTO = sum(images(:,:,idx),3);
    
    % plot 2D histo
    subplot(N_plots_Y, N_plots_X, counter)
    cmap = dlmread('cmap');
    colormap(cmap)
    
    % create dummy axis for proper alignement of layers
    set(gca,'ytick',[])
    set(gca,'xtick',[])
    
    ax1 = axes('position',get(gca,'Position'));
    
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Linear')
        surf(X_array, Y_array, HISTO/app.Data_struct.N_measurements,'edgecolor','interp')
        
        set(gca,'xscale','lin')
        set(gca,'xlim', [X_array(1) X_array(end)])
        %     set(gca,'xtick', linspace(X_array(1), X_array(end), 5))
        
        set(gca,'yscale','lin')
        set(gca,'ylim', [Y_array(1) Y_array(end)])
        set(gca,'ytick', linspace(Y_array(1), Y_array(end), 5))
    end
    if strcmp(app.XscaleDropDown.Value, 'Linear') && strcmp(app.YscaleDropDown.Value, 'Log')
        surf(X_array, 10.^Y_array, HISTO/app.Data_struct.N_measurements,'edgecolor','interp')
        
        set(gca,'xscale','lin')
        set(gca,'xlim', [X_array(1) X_array(end)])
        %     set(gca,'xtick', linspace(X_array(1), X_array(end), 5))
        
        set(gca,'yscale','log')
        set(gca,'ytick',10.^(-100:1:100))
        set(gca,'ylim',10.^[Y_array(1) Y_array(end)])
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Linear')
        surf(10.^X_array, Y_array, HISTO/app.Data_struct.N_measurements,'edgecolor','interp')
        
        set(gca,'xscale','log')
        set(gca,'xlim', 10.^[X_array(1) X_array(end)])
        set(gca,'xtick',10.^(-100:1:100))
        
        set(gca,'yscale','lin')
        %     set(gca,'ytick', linspace(Y_array(1), Y_array(end), 5))
        set(gca,'ylim',[Y_array(1) Y_array(end)])
    end
    if strcmp(app.XscaleDropDown.Value, 'Log') && strcmp(app.YscaleDropDown.Value, 'Log')
        surf(10.^X_array, 10.^Y_array, HISTO/app.Data_struct.N_measurements,'edgecolor','interp')
        
        set(gca,'xscale','log')
        set(gca,'xlim', 10.^[X_array(1) X_array(end)])
        set(gca,'xtick',10.^(-100:1:100))
        
        set(gca,'yscale','log')
        set(gca,'ylim',10.^[Y_array(1) Y_array(end)])
        set(gca,'ytick',10.^(-100:1:100))
    end
    
    view([0 90])
    set(ax1,'Fontsize',12,'Linewidth',2,'box','on')
    set(gcf, 'InvertHardCopy', 'off','color', 'white');
    set(ax1,'clim',[0 0.1])
    title(Title,'FontSize',14,'Color', cmap_clusters(index,:))
    xlabel(gca, app.XlabelEditField.Value)
    ylabel(gca, app.YlabelEditField.Value)
    
    counter = counter + 1;
end

cbar = colorbar('position',[0.91 0.2 0.02 0.6]);
y_lim = get(cbar,'ylim');
set(cbar,'ytick',[y_lim(1) mean(y_lim) y_lim(2)],'yticklabel',{'low','medium','high'})

return