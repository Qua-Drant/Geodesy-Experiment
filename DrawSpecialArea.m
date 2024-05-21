% 设置调试模式，如果出错则停止
dbstop if error

% 加载数据和设置参数
load('test.mat');
grid_data = grid_data_grace(:,:,1) * 100;
% 实际应用使这里请改为自己的数据~

title_string = 'TitleString';
colorbar_value = 20;
colorbar_unit = 'cm';

lon = 0.5:359.5;
lat = 89.5:-1:-89.5;

fpni = 'liuyu_new.bln'; % .bln 文件路径
Bound = read_bln(fpni);
boux = Bound(:,1); bouy = Bound(:,2); % 获取经度和纬度信息

% 设置图形窗口位置和大小
set(gcf,'position',[0 0 1440 780]);

% 创建经纬度网格
[LON, LAT] = meshgrid(lon, lat);

% 设置地图投影和显示范围
m_proj('Mercator', 'lon', [100 120], 'lat', [16 30]);

buffer_distance = 1; % 根据需要调整此值

% 创建膨胀后的边界
[boux_expanded, bouy_expanded] = expand_polygon(boux, bouy, buffer_distance);

% 判断每个网格点是否在膨胀后的多边形内
[in_expanded, on_expanded] = inpolygon(LON, LAT, boux_expanded, bouy_expanded);

% 设置多边形和周围的点为有效值，其他点设置为 NaN
grid_data(~in_expanded) = NaN;

% 绘制颜色图
m_pcolor(LON, LAT, grid_data);
shading flat;

% 绘制多边形轮廓线
hold on;
m_plot(boux, bouy, 'k', 'LineWidth', 2);

% 设置网格和颜色条
m_grid('xtick', 6, 'ytick', 6, 'tickdir', 'in', 'xlabeldir', 'middle', ...
    'TickLength', 0.008, 'LineWidth', 1., 'FontName', 'Helvetica', 'FontSize', 15, 'fontweight', 'bold');
clim([-colorbar_value, colorbar_value]);
colormap('jet');

% 添加标题
title(title_string, 'fontsize', 20, 'FontName', 'Helvetica', 'fontweight', 'bold');
