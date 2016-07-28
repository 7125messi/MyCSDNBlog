%读入数据
x=[3,3;4,3;1,1];
y=[1;1;-1];

%--初始化w和b
w = [0,0];
b = 0;
a = 1;%步长

%--选择未能初始化的点
flag = 0;

i = 1;
while flag~=1
    while i <= 3
        t = y(i)*(w*x(i,:)'+b);
        if t <= 0
            w = w + a*y(i,:)*x(i,:);
            b = b + a*y(i,:);
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
%画出分隔线
hold on
axis([0 5 0 5]);%axis一般用来设置axes的样式，包括坐标轴范围，可读比例等
for j = 1:3
    plot(x(j,1),x(j,2),'.');
    m(1,j) = (-b-w(1)*j)./(w(2));
end
j = 1:3;
plot(j,m);

