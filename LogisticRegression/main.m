%----start-----
data = load('testSet.txt');%导入数据
[m,n] = size(data);%行和列
o = ones(m,1);
dataX = data(:,1:2);
X = [o,dataX];
Y = data(:,3);

%--experiments--
weights = gradient(X,Y);

%% plot the pic
Ypic = X * weights;
x_1 = X(:,2);
x_2 = X(:,3);
hold on
for i = 1 : 100
    if Y(i,:) == 0
        plot(x_1(i,:),x_2(i,:),'.g');
    else
        plot(x_1(i,:),x_2(i,:),'.r');
    end
end
x = -3.0:0.1:3;
y = (-weights(1)-weights(2)*x)/weights(3);
plot(x,y);
