function [ FinalData,reconData ] = PCA( dataSet, k )
    [m,n] = size(dataSet);

   %% 去除平均值
    %取平均值
    dataSetMean = mean(dataSet);
    %减去平均值
    dataSetAdjust = zeros(m,n);
    for i = 1 : m
        dataSetAdjust(i , :) = dataSet(i , :) - dataSetMean;
    end

    %% 计算协方差矩阵
    dataCov = cov(dataSetAdjust);

    %% 计算协方差矩阵的特征值与特征向量
    [V, D] = eig(dataCov);
    
    % 将特征值矩阵转换成向量
    d = zeros(1, n);
    for i = 1:n
        d(1,i) = D(i,i);
    end
    
    %% 对特征值排序
    [maxD, index] = sort(d);
    
    %% 选取前k个最大的特征值
    % maxD_k = maxD(1, (n-k+1):n);
    index_k = index(1, (n-k+1):n);
    % 对应的特征向量
    V_k = zeros(n,k);
    for i = 1:k
        V_k(:,i) = V(:,index_k(1,i));
    end
    
    %% 转换到新的空间
    FinalData = dataSetAdjust*V_k;
    
    % 在原图中找到这些点
    reconData = FinalData * V_k';
    for i = 1 : m
        reconData(i , :) = reconData(i , :) + dataSetMean;
    end
end

