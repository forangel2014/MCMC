% 使用Metropolis-Hastings算法对Potts模型进行抽样
accept_rate = [0 0 0]; %初始化接受率
lnZ = [400*log(10) 400*log(10) 400*log(10)];
global method
for method = 1:3
    for beta = 0.0025:delta:J %积分变量beta
        x(:,:,1) = unidrnd(q,K,K); %随机第一个样本
        for n = 2:iterations %在每个beta倒数温度下，迭代若干次，计算其能量期望
            x_propose = Q_potts(x(:,:,n-1)); %根据Q的设计，在x(:,:,n-1)状态下推荐下一个x
            %计算接受推荐的概率
            p = min([get_p(x_propose,beta)*Q_potts(x_propose,x(:,:,n-1))...
                /get_p(x(:,:,n-1),beta)*Q_potts(x(:,:,n-1),x_propose) 1]);
            %以p的概率接受推荐
            if (p == 1)
                xn = x_propose;
                accept_rate(method) = accept_rate(method)+1;
            else
                temp = rand();
                if (temp < p)
                    accept_rate(method) = accept_rate(method)+1;
                    xn = x_propose;
                else
                    xn = x(:,:,n-1);
                end
            end
            x(:,:,n) = xn; %赋值
        end
        %计算能量期望
        for n = 1:iterations
            u(n) = get_u(x(:,:,n));
            %p(n) = get_p(x(:,:,n),beta);
        end
        lnZ(method) = lnZ(method) - mean(u)*delta; %lnZ求和（积分）
    end
    accept_rate(method) = accept_rate(method)/(iterations-1)/((J-0.0025)/delta+1); %计算总接受率
end