% ʹ��Metropolis-Hastings�㷨�Զ�ά��˹�ֲ����г���
x(1:2,1) = (rand(2,1)-[0.5;0.5])*4.*u + u; %���������һ������
accept_rate(1:4) = [0 0 0 0]; %��ʼ��������
num = 50000; %��������
global method
for method = 1:4
    for n = 1:num
        x_propose = Q_gauss(x(:,n)); %����Q����ƣ���x(:,n)״̬���Ƽ���һ��x
        p = min([f(x_propose)*Q_gauss(x_propose,x(:,n))... %��������Ƽ��ĸ���
            /f(x(:,n))*Q_gauss(x(:,n),x_propose) 1]);      
        %��p�ĸ��ʽ����Ƽ�
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
        x(1:2,n+1) = xnp1; %��ֵ 
    end
    accept_rate(method) = accept_rate(method)/num; %���������
    figure;
    plot(x(1,:),x(2,:),'.');
    index = 1;
    for throw = 1:1:1000
        varx = get_var(x(1,throw:end));
        vary = get_var(x(2,throw:end));
        covxy = get_cov(x(1,throw:end),x(2,throw:end));
        rho(method,index) = covxy/(varx*vary)^(1/2); %��������ǰthrow������������ϵ��
        index = index+1;
    end
end
figure;
plot(rho');
xlabel('��������');
ylabel('���ϵ��');
legend('����1','����2','����3','����4');