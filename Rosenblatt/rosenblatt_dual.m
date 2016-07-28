%% Rosenblatt感知机的对偶解法
clear all;
clc;

%读入数据
x=[3,3;4,3;1,1];
y=[1;1;-1];
[m,n] = size(x);%取得数据集的大小

%% 画出原始的点
hold on
axis([0 5 0 5]);%axis一般用来设置axes的样式，包括坐标轴范围，可读比例等
for i = 1:m
    plot(x(i,1),x(i,2),'.');
end

%% 初始化
alpha = zeros(1,m);
b = 0;
yita = 1;%学习率
gram = zeros(m,m);

%% 计算Gram矩阵
for i = 1:m
    for j = 1:m
        gram(i,j)=x(i,:)*x(j,:)';
    end
end

%% 更新
for i = 1:m
    tmp = 0;
    for j = 1:m
        tmp = tmp + alpha(j)*y(j)*gram(i,j);
    end
    tmp = tmp + b;
    tmp = y(i)*tmp;
    if tmp <= 0
        alpha(i) = alpha(i)+yita;
        b = b + y(i);
    end
end
% 要使得数据集中没有误分类的点
flag = 0;%标志位，用于标记有没有误分类的点
i = 1;
while flag~=1
    while i <= 3
        tmp = 0;
        for j = 1:m
            tmp = tmp + alpha(j)*y(j)*gram(i,j);
        end
        tmp = tmp + b;
        tmp = y(i)*tmp;
        if tmp <= 0
            alpha(i) = alpha(i)+yita;
            b = b + y(i);
            i = 1;%重置i
            break;
        else
            i = i+1;
        end
        if i == 4
            flag = 1;
        end
    end
end

%% 重新计算w和b
for i = 1:m
    x_new(i,:) = x(i,:) * y(i);
end
w = alpha * x_new;

%% 画出分隔线
x_1 = (0:3);
y_1 = (-b-w(1,1)*x_1)./w(1,2);
plot(x_1,y_1);
