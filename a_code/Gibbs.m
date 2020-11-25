% ʹ��Gibbs�㷨�Զ�ά��˹�ֲ����г���
x(1:2,1) = (rand(2,1)-[0.5;0.5])*4.*u + u; %���������һ������
accept_rate = 0; %��ʼ��������
num = 10000; %��������
for n = 1:num
    % �ھ�ֵ��x����������������Ƽ���x
    x1_propose = unifrnd(u(1)-5*sigma(1,1)^1/2,u(1)+5*sigma(1,1)^1/2);
    p = min([f([x1_propose; x(2,n)])/f(x(:,n)) 1]); 
    %��p�ĸ��ʽ����Ƽ�
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
    %�ڲ�����x1(n+1)�Ļ����ϣ�����x2(n+1)
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
  
    x(1:2,n+1) = [x1np1; x2np1]; %��ֵ
end
accept_rate = accept_rate/num/2; %���������
plot(x(1,:),x(2,:),'.');
index = 1;
for throw = 1:1:200
    varx = get_var(x(1,throw:end));
    vary = get_var(x(2,throw:end));
    covxy = get_cov(x(1,throw:end),x(2,throw:end));
    rho(index) = covxy/(varx*vary)^(1/2); %��������ǰthrow������������ϵ��
    index = index+1;
end
figure;
plot(rho);
xlabel('��������');
ylabel('���ϵ��');