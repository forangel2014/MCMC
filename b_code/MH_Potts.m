% ʹ��Metropolis-Hastings�㷨��Pottsģ�ͽ��г���
accept_rate = [0 0 0]; %��ʼ��������
lnZ = [400*log(10) 400*log(10) 400*log(10)];
global method
for method = 1:3
    for beta = 0.0025:delta:J %���ֱ���beta
        x(:,:,1) = unidrnd(q,K,K); %�����һ������
        for n = 2:iterations %��ÿ��beta�����¶��£��������ɴΣ���������������
            x_propose = Q_potts(x(:,:,n-1)); %����Q����ƣ���x(:,:,n-1)״̬���Ƽ���һ��x
            %��������Ƽ��ĸ���
            p = min([get_p(x_propose,beta)*Q_potts(x_propose,x(:,:,n-1))...
                /get_p(x(:,:,n-1),beta)*Q_potts(x(:,:,n-1),x_propose) 1]);
            %��p�ĸ��ʽ����Ƽ�
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
            x(:,:,n) = xn; %��ֵ
        end
        %������������
        for n = 1:iterations
            u(n) = get_u(x(:,:,n));
            %p(n) = get_p(x(:,:,n),beta);
        end
        lnZ(method) = lnZ(method) - mean(u)*delta; %lnZ��ͣ����֣�
    end
    accept_rate(method) = accept_rate(method)/(iterations-1)/((J-0.0025)/delta+1); %�����ܽ�����
end