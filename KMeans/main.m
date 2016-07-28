%% input the data
A = load('testSet.txt');

%% 计算质心
centroids = kMeans(A, 4);
