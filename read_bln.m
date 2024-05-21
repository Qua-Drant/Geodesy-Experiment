function boundaries = read_bln(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('无法打开文件: %s', filename);
    end
    boundaries = {};
    
    while ~feof(fid)
        % 读取头部信息行并转换为数字
        header = fgetl(fid);
        numPoints = str2double(strtok(header));
        
        % 检查numPoints是否为有效数字
        if isnan(numPoints)
            continue; % 如果无效，跳过该段
        end
        
        % 读取点数据
        data = fscanf(fid, '%f %f', [2, numPoints]);
        
        % 检查是否正确读取了所有点数据
        if size(data, 2) == numPoints
            boundaries = data';
        end
        
        % 跳过剩余部分
        fgetl(fid);
    end
    
    fclose(fid);
end
