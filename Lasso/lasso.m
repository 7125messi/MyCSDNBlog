clear all;
clc;
%% 导入数据
data = load('abalone.txt');
x = data(:,1:8);
y = data(:,9);
%% 处理数据
yMean = mean(y);
yDeal = y-yMean;
xMean = mean(x);
xVar = var(x,1);
[m,n] = size(x);
xDeal = zeros(m,n);
for i = 1:m
    for j = 1:n
        xDeal(i,j) = (x(i,j)-xMean(j))/xVar(j);
    end
end

%% 训练
runtime  = 5000;%迭代的步数
eps = 0.001;%调整步长
wResult = stageWise(xDeal, yDeal, eps, runtime);

%% 根据wResult画出收敛曲线
hold on 
xAxis = 1:runtime;
for i = 1:n
    plot(xAxis, wResult(:,i));
end
