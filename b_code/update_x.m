% 此函数对于输入的状态x，附加变量bond，更新矩阵updated，以及指定的更新单元及更新状态
% 更新其状态，并递归调用本函数，更新此单元的所有连通单元
% 并返回更新后的状态x，附加变量bond，更新矩阵updated
function [x_now1,bond_lines1,bond_cols1,updated1] = update_x(q,x_now,bond_lines,bond_cols,updated,i,j,state)
    [K,~] = size(x_now);
    %预设此函数的输出
    x_now1 = x_now;
    bond_lines1 = bond_lines;
    bond_cols1 = bond_cols;
    updated1 = updated;
    %仅当此单元未被更新过，即updated(i,j) = 0时，对该单元进行操作
    if (updated(i,j) == 0)
        %若要未知更新状态，即调用此函数的为SW文件，则从q个状态中随机一个
        if (state == 0)
            this_state = unidrnd(q);
            x_now1(i,j) = this_state;
        %否则更新为传递来的指定状态
        else
            this_state = state;
            x_now1(i,j) = state;
        end
        updated1(i,j) = 1; %更新更新矩阵
        %以下，对该单元(i,j)的位置是否特殊进行判断
        %更新与其连通的相邻单元
        %处理上下的相邻单元
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
        %处理左右的相邻单元
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