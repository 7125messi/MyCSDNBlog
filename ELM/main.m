%% 主函数，二分类问题

%导入数据集
A = load('testSet.txt');

data = A(:,1:2);%特征
label = A(:,3);%标签

[N,n] = size(data);

L = 100;%隐层节点个数
m = 2;%要分的类别数

%--初始化权重和偏置矩阵
W = rand(n,L)*2-1;
b_1 = rand(1,L);
ind = ones(N,1);
b = b_1(ind,:);%扩充成N*L的矩阵

tempH = data*W+b;
H = g(tempH);%得到H

%对输出做处理
temp_T=zeros(N,m);
for i = 1:N
    if label(i,:) == 0
        temp_T(i,1) = 1;
    else 
        temp_T(i,2) = 1;
    end    
end
T = temp_T*2-1;

outputWeight = pinv(H)*T;

%--画出图形
x_1 = data(:,1);  
x_2 = data(:,2);  
hold on  
for i = 1 : N  
    if label(i,:) == 0  
        plot(x_1(i,:),x_2(i,:),'.g');  
    else  
        plot(x_1(i,:),x_2(i,:),'.r');  
    end  
end

output = H * outputWeight;
%---计算错误率
tempCorrect=0;
for i = 1:N
    [maxNum,index] = max(output(i,:));
    index = index-1;
    if index == label(i,:);
        tempCorrect = tempCorrect+1;
    end
end

errorRate = 1-tempCorrect./N;





