% 使用Swendsen–Wang算法对Potts模型进行抽样
for beta = 0.001:delta:J %积分变量beta %若积分间隔设定为0.0065，则初始值设定为0.0025
    if (abs(beta-J) < delta/5)
        iterations = 10*iterations; %对最终温度采10倍样本以绘制能量直方图
    end
    x(:,:,1) = unidrnd(q,K,K); %随机第一个样本
    p0 = 1 - exp(-beta); %设定未被禁止的bond被设为1的概率
    bond_lines = unidrnd(2,K,K)-1; %初始化行中的bond
    bond_cols = unidrnd(2,K,K)-1; %初始化列中的bond
    for n = 2:iterations
        % 刷新bond，并将连接的单元状态不同的bond禁止（赋值-1）
        bond_lines = zeros(K,K); 
        bond_cols = zeros(K,K);
        bond_lines(find(x(:,:,n-1) ~= [x(:,2:K,n-1) x(:,1,n-1)])) = -1;
        bond_cols(find(x(:,:,n-1) ~= [x(2:K,:,n-1); x(1,:,n-1)])) = -1;
        % 对连接的单元状态相同的bond，以概率p设为1
        for i = 1:K
            for j = 1:K
                if (bond_lines(i,j) ~= -1)
                    num = rand(1);
                    if (num < p0)
                        bond_lines(i,j) = 1;
                    else
                        bond_lines(i,j) = 0;
                    end
                end
                if (bond_cols(i,j) ~= -1)
                    num = rand(1);
                    if (num < p0)
                        bond_cols(i,j) = 1;
                    else
                        bond_cols(i,j) = 0;
                    end
                end
            end
        end
        updated = zeros(K,K); %初始化更新矩阵，用以标记各单元是否被更新过
        x_now(:,:) = x(:,:,n-1); %创建当前x的副本，用以迭代更新
        % 对每个单元进行更新（具体操作见update_x函数）
        for i = 1:K
            for j = 1:K
                [x_now,bond_lines,bond_cols,updated] = update_x(q,x_now,bond_lines,bond_cols,updated,i,j,0);
            end
        end
        x(:,:,n) = x_now(:,:); %将更新后的x赋给下一时刻
    end
    %计算能量期望
    for n = 1:iterations
        u(n) = get_u(x(:,:,n));
        %p(n) = get_p(x(:,:,n),beta);
    end
    if (abs(beta-J) < delta/5)
        lnZ = lnZ - mean(u(1:iterations/10))*delta; %lnZ求和（积分）
    else
        lnZ = lnZ - mean(u)*delta;
    end
end
figure;
histogram(u/K); %绘制能量直方图
tu = tabulate(u);
[f i] = max(tu(:,2));
un = find(u == tu(i,1),1);
sample = x(:,:,un); %获取典型样本
imshow(sample/10);