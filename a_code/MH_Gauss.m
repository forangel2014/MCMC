% 使用Metropolis-Hastings算法对二维高斯分布进行抽样
x(1:2,1) = (rand(2,1)-[0.5;0.5])*4.*u + u; %随机产生第一个样本
accept_rate(1:4) = [0 0 0 0]; %初始化接受率
num = 50000; %采样个数
global method
for method = 1:4
    for n = 1:num
        x_propose = Q_gauss(x(:,n)); %根据Q的设计，在x(:,n)状态下推荐下一个x
        p = min([f(x_propose)*Q_gauss(x_propose,x(:,n))... %计算接受推荐的概率
            /f(x(:,n))*Q_gauss(x(:,n),x_propose) 1]);      
        %以p的概率接受推荐
        if (p == 1)
            xnp1 = x_propose; 
            accept_rate(method) = accept_rate(method)+1;
        else
            temp = rand();
            if (temp < p)
                accept_rate(method) = accept_rate(method)+1;
                xnp1 = x_propose;
            else
                xnp1 = x(:,n);
            end
        end
        x(1:2,n+1) = xnp1; %赋值 
    end
    accept_rate(method) = accept_rate(method)/num; %计算接受率
    figure;
    plot(x(1,:),x(2,:),'.');
    index = 1;
    for throw = 1:1:1000
        varx = get_var(x(1,throw:end));
        vary = get_var(x(2,throw:end));
        covxy = get_cov(x(1,throw:end),x(2,throw:end));
        rho(method,index) = covxy/(varx*vary)^(1/2); %计算舍弃前throw个样本后的相关系数
        index = index+1;
    end
end
figure;
plot(rho');
xlabel('舍弃点数');
ylabel('相关系数');
legend('方案1','方案2','方案3','方案4');