function fig = plot_feature_space(app, clusterX, feature_space)

%% make figure
if app.HideplotsCheckBox.Value
    fig = figure('visible','off');
else
    fig = figure('visible','on');
end

figure_size = get(0, 'screensize');
figure_size = round([100 100 figure_size(4)*0.8 figure_size(4)*0.8]);
set(gcf,'color','white')
set(fig,'position',figure_size)

%% set colormap
colormap(parula);

%% make scatter plot
[~, nDim] = size(feature_space);
if nDim > 3
    feature_space = pca(feature_space, 3);
end

subplot(2,2,1)
scatter3(feature_space(:,1), feature_space(:,2), feature_space(:,3), 10, categorical(clusterX), 'filled')
set(gca,'Fontsize',20,'Linewidth',2,'box','on')
set(gca,'xcolor',[0 0 0])
set(gca,'ycolor',[0 0 0])
xlabel('Dimension 1')
ylabel('Dimension 2')
zlabel('Dimension 3')
view([0 0])

subplot(2,2,2)
scatter3(feature_space(:,1), feature_space(:,2), feature_space(:,3), 10, categorical(clusterX), 'filled')
set(gca,'Fontsize',20,'Linewidth',2,'box','on')
set(gca,'xcolor',[0 0 0])
set(gca,'ycolor',[0 0 0])
xlabel('Dimension 1')
ylabel('Dimension 2')
zlabel('Dimension 3')
view([90 0])

subplot(2,2,3)
scatter3(feature_space(:,1), feature_space(:,2), feature_space(:,3), 10, categorical(clusterX), 'filled')
set(gca,'Fontsize',20,'Linewidth',2,'box','on')
set(gca,'xcolor',[0 0 0])
set(gca,'ycolor',[0 0 0])
xlabel('Dimension 1')
ylabel('Dimension 2')
zlabel('Dimension 3')
view([90 90])

subplot(2,2,4)
scatter3(feature_space(:,1), feature_space(:,2), feature_space(:,3), 10, categorical(clusterX), 'filled')
set(gca,'Fontsize',20,'Linewidth',2,'box','on')
set(gca,'xcolor',[0 0 0])
set(gca,'ycolor',[0 0 0])
xlabel('Dimension 1')
ylabel('Dimension 2')
zlabel('Dimension 3')

