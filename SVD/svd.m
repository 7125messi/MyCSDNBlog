%% 测试奇异值分解过程
load data.mat;%该文件是做好的一个手写体的图片
B = zeros(28,28);%将行向量重新转换成原始的图片

for i = 1:28
    j = 28*(i-1)+1;
    B(i,:) = A(1,j:j+27);
end

%进行奇异值分解
[U S V] = svd(B);

%选取前面14个非零奇异值
for i = 1:14
    for j = 1:14
        S_1(i,j) = S(i,j);
    end
end

%左奇异矩阵
for i = 1:28
    for j = 1:14
        U_1(i,j) = U(i,j);
    end
end

%右奇异矩阵
for i = 1:28
    for j = 1:14
        V_1(i,j) = V(i,j);
    end
end

B_1 = U_1*S_1*V_1';

%同时输出两个图片
subplot(121);imshow(B);
subplot(122);imshow(B_1);
