% �˺������������״̬x�����ӱ���bond�����¾���updated���Լ�ָ���ĸ��µ�Ԫ������״̬
% ������״̬�����ݹ���ñ����������´˵�Ԫ��������ͨ��Ԫ
% �����ظ��º��״̬x�����ӱ���bond�����¾���updated
function [x_now1,bond_lines1,bond_cols1,updated1] = update_x(q,x_now,bond_lines,bond_cols,updated,i,j,state)
    [K,~] = size(x_now);
    %Ԥ��˺��������
    x_now1 = x_now;
    bond_lines1 = bond_lines;
    bond_cols1 = bond_cols;
    updated1 = updated;
    %�����˵�Ԫδ�����¹�����updated(i,j) = 0ʱ���Ըõ�Ԫ���в���
    if (updated(i,j) == 0)
        %��Ҫδ֪����״̬�������ô˺�����ΪSW�ļ������q��״̬�����һ��
        if (state == 0)
            this_state = unidrnd(q);
            x_now1(i,j) = this_state;
        %�������Ϊ��������ָ��״̬
        else
            this_state = state;
            x_now1(i,j) = state;
        end
        updated1(i,j) = 1; %���¸��¾���
        %���£��Ըõ�Ԫ(i,j)��λ���Ƿ���������ж�
        %����������ͨ�����ڵ�Ԫ
        %�������µ����ڵ�Ԫ
        if (i == 1)
            if (bond_cols(1,j) == 1)
                [x_now1,bond_lines1,bond_cols1,updated1] =...
                    update_x(q,x_now1,bond_lines1,bond_cols1,updated1,2,j,this_state);
            end
            if (bond_cols(K,j) == 1)
                [x_now1,bond_lines1,bond_cols1,updated1] =...
                    update_x(q,x_now1,bond_lines1,bond_cols1,updated1,K,j,this_state);
            end
        else
            if (i == K)
                if (bond_cols(1,j) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,1,j,this_state);
                end
                if (bond_cols(K-1,j) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,K-1,j,this_state);
                end
            else
                if (bond_cols(i,j) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i+1,j,this_state);
                end
                if (bond_cols(i-1,j) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i-1,j,this_state);
                end
            end
        end
        %�������ҵ����ڵ�Ԫ
        if (j == 1)
            if (bond_lines(i,1) == 1)
                [x_now1,bond_lines1,bond_cols1,updated1] =...
                    update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,2,this_state);
            end
            if (bond_lines(i,K) == 1)
                [x_now1,bond_lines1,bond_cols1,updated1] =...
                    update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,K,this_state);
            end
        else
            if (j == K)
                if (bond_lines(i,K) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,1,this_state);
                end
                if (bond_lines(i,K-1) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,K-1,this_state);
                end
            else
                if (bond_lines(i,j) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,j+1,this_state);
                end
                if (bond_lines(i,j-1) == 1)
                    [x_now1,bond_lines1,bond_cols1,updated1] =...
                        update_x(q,x_now1,bond_lines1,bond_cols1,updated1,i,j-1,this_state);
                end
            end
        end
    end
end