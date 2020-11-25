% ʹ��Swendsen�CWang�㷨��Pottsģ�ͽ��г���
for beta = 0.001:delta:J %���ֱ���beta %�����ּ���趨Ϊ0.0065�����ʼֵ�趨Ϊ0.0025
    if (abs(beta-J) < delta/5)
        iterations = 10*iterations; %�������¶Ȳ�10�������Ի�������ֱ��ͼ
    end
    x(:,:,1) = unidrnd(q,K,K); %�����һ������
    p0 = 1 - exp(-beta); %�趨δ����ֹ��bond����Ϊ1�ĸ���
    bond_lines = unidrnd(2,K,K)-1; %��ʼ�����е�bond
    bond_cols = unidrnd(2,K,K)-1; %��ʼ�����е�bond
    for n = 2:iterations
        % ˢ��bond���������ӵĵ�Ԫ״̬��ͬ��bond��ֹ����ֵ-1��
        bond_lines = zeros(K,K); 
        bond_cols = zeros(K,K);
        bond_lines(find(x(:,:,n-1) ~= [x(:,2:K,n-1) x(:,1,n-1)])) = -1;
        bond_cols(find(x(:,:,n-1) ~= [x(2:K,:,n-1); x(1,:,n-1)])) = -1;
        % �����ӵĵ�Ԫ״̬��ͬ��bond���Ը���p��Ϊ1
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
        updated = zeros(K,K); %��ʼ�����¾������Ա�Ǹ���Ԫ�Ƿ񱻸��¹�
        x_now(:,:) = x(:,:,n-1); %������ǰx�ĸ��������Ե�������
        % ��ÿ����Ԫ���и��£����������update_x������
        for i = 1:K
            for j = 1:K
                [x_now,bond_lines,bond_cols,updated] = update_x(q,x_now,bond_lines,bond_cols,updated,i,j,0);
            end
        end
        x(:,:,n) = x_now(:,:); %�����º��x������һʱ��
    end
    %������������
    for n = 1:iterations
        u(n) = get_u(x(:,:,n));
        %p(n) = get_p(x(:,:,n),beta);
    end
    if (abs(beta-J) < delta/5)
        lnZ = lnZ - mean(u(1:iterations/10))*delta; %lnZ��ͣ����֣�
    else
        lnZ = lnZ - mean(u)*delta;
    end
end
figure;
histogram(u/K); %��������ֱ��ͼ
tu = tabulate(u);
[f i] = max(tu(:,2));
un = find(u == tu(i,1),1);
sample = x(:,:,un); %��ȡ��������
imshow(sample/10);