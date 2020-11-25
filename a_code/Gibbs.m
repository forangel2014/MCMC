% 使用Gibbs算法对二维高斯分布进行抽样
x(1:2,1) = (rand(2,1)-[0.5;0.5])*4.*u + u; %随机产生第一个样本
accept_rate = 0; %初始化接受率
num = 10000; %采样个数
for n = 1:num
    % 在均值的x分量附近随机产生推荐的x
    x1_propose = unifrnd(u(1)-5*sigma(1,1)^1/2,u(1)+5*sigma(1,1)^1/2);
    p = min([f([x1_propose; x(2,n)])/f(x(:,n)) 1]); 
    %以p的概率接受推荐
    if (p == 1)
        x1np1 = x1_propose;
        accept_rate = accept_rate+1;
    else
        temp = rand();
        if (temp < p)
            accept_rate = accept_rate+1;
            x1np1 = x1_propose;
        else
            x1np1 = x(1,n);
        end
    end
    %在产生的x1(n+1)的基础上，产生x2(n+1)
    x2_propose = unifrnd(u(2)-5*sigma(2,2)^1/2,u(2)+5*sigma(2,2)^1/2);
    p = min([f([x1np1; x2_propose])/f([x1np1; x(2,n)]) 1]);
    if (p == 1)
        x2np1 = x2_propose;
        accept_rate = accept_rate+1;
    else
        temp = rand();
        if (temp < p)
            accept_rate = accept_rate+1;
            x2np1 = x2_propose;
        else
            x2np1 = x(2,n);
        end
    end
  
    x(1:2,n+1) = [x1np1; x2np1]; %赋值
end
accept_rate = accept_rate/num/2; %计算接受率
plot(x(1,:),x(2,:),'.');
index = 1;
for throw = 1:1:200
    varx = get_var(x(1,throw:end));
    vary = get_var(x(2,throw:end));
    covxy = get_cov(x(1,throw:end),x(2,throw:end));
    rho(index) = covxy/(varx*vary)^(1/2); %计算舍弃前throw个样本后的相关系数
    index = index+1;
end
figure;
plot(rho);
xlabel('舍弃点数');
ylabel('相关系数');