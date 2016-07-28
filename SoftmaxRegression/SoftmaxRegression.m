clear all;
clc;

%% 导入数据
data = load('SoftInput.txt');
[m,n] = size(data);
labels = unique(data(:,3));
labelLen = length(labels);%划分的种类
dataMat(:,2:3) = data(:,1:2);
dataMat(:,1) = 1;%做好数据集，添加一列为1
labelMat(:,1) = data(:,3)+1;%分类的标签
%% 画图
figure;
hold on
for i = 1:m
    if labelMat(i,:) == 1
        plot(data(i,1),data(i,2),'.m');%粉红色
    elseif labelMat(i,:) == 2
        plot(data(i,1),data(i,2),'.b');%蓝色
    elseif labelMat(i,:) == 3
        plot(data(i,1),data(i,2),'.r');%红色
    else
        plot(data(i,1),data(i,2),'.k');%黑色
    end
end
title('原始数据集');
hold off

%% 初始化一些参数
M = m;%数据集的行
N = n;%数据集的列
K = labelLen;%划分的种类
alpha = 0.001;%学习率
weights = ones(N, K);%初始化权重

%% 利用随机梯度修改权重
weights = stochasticGradientAscent(dataMat, labelMat, M, weights, alpha);

%% 测试数据集(主要在区间里随机生成)
size = 4000;
[testDataSet, testLabelSet] = testData(weights, size, N);
%% 画出最终的分类图
figure;
hold on
for i = 1:size
    if testLabelSet(i,:) == 1
        plot(testDataSet(i,2),testDataSet(i,3),'.m');
    elseif testLabelSet(i,:) == 2
        plot(testDataSet(i,2),testDataSet(i,3),'.b');
    elseif testLabelSet(i,:) == 3
        plot(testDataSet(i,2),testDataSet(i,3),'.r');
    else
        plot(testDataSet(i,2),testDataSet(i,3),'.k');
    end
end
title('测试数据集');
hold off

