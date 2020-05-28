function Make_2D_histo_GUI(app)

%% make 2D histogram of all traces
[images, X_array, Y_array] = Make_2D_histo(app);
HISTO = sum(images, 3);

%% make 2D plot
fig_raw = figure;
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

cmap = dlmread('cmap');
colormap(gca, cmap)
set(gca,'view',[0 90])
set(gca,'Fontsize',12,'Linewidth',2,'box','on')
set(gca,'clim',[0 0.1])
set(gca,'XTickMode', 'auto', 'XTickLabelMode', 'auto')
xlabel(gca, app.XlabelEditField.Value)
ylabel(gca, app.YlabelEditField.Value)
set(gcf,'color','white')

saveas(fig_raw, sprintf('%s/Data/Raw_data.png', app.Data_struct.output_path));

return