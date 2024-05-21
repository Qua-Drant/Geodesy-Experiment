% 函数：扩展多边形
function [boux_expanded, bouy_expanded] = expand_polygon(boux, bouy, buffer_distance)
    % 计算多边形顶点数
    num_points = length(boux);
    
    % 初始化扩展后的边界坐标
    boux_expanded = zeros(size(boux));
    bouy_expanded = zeros(size(bouy));
    
    % 循环计算每个顶点的扩展位置
    for i = 1:num_points
        % 当前点
        x0 = boux(i);
        y0 = bouy(i);
        
        % 前一个点
        if i == 1
            x_prev = boux(end);
            y_prev = bouy(end);
        else
            x_prev = boux(i - 1);
            y_prev = bouy(i - 1);
        end
        
        % 后一个点
        if i == num_points
            x_next = boux(1);
            y_next = bouy(1);
        else
            x_next = boux(i + 1);
            y_next = bouy(i + 1);
        end
        
        % 计算法线向量（平均前后两条边的法线）
        dx1 = x0 - x_prev;
        dy1 = y0 - y_prev;
        dx2 = x_next - x0;
        dy2 = y_next - y0;
        
        % 法线向量
        nx1 = -dy1;
        ny1 = dx1;
        nx2 = -dy2;
        ny2 = dx2;
        
        % 平均法线向量
        nx = (nx1 + nx2) / 2;
        ny = (ny1 + ny2) / 2;
        
        % 规范化法线向量
        norm_factor = sqrt(nx^2 + ny^2);
        nx = nx / norm_factor;
        ny = ny / norm_factor;
        
        % 计算扩展后的坐标
        boux_expanded(i) = x0 + buffer_distance * nx;
        bouy_expanded(i) = y0 + buffer_distance * ny;
    end
end