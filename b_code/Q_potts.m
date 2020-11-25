% 此函数实现MH算法中的推荐矩阵
% 对1个参数的输入xn，返回基于xn的推荐值x_propose
% 对2个参数的输入x1，x2，返回由x1转移到x2的条件概率
function value = Q_potts(varargin)
    global K q method
    narginchk(1,2);
%% 方案1：随机推荐
    if (method == 1) 
        if (nargin == 1)
            value = unidrnd(q,K,K);
        end
        if (nargin == 2)
            value = 1;
        end
    end
%% 方案2：小幅变化推荐
    if (method == 2)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = zeros(K,K);
            for i = 1:K
                for j = 1:K
                    temp = rand();
                    if (temp < 0.25)
                        value(i,j) = xn(i,j)-1;
                    else
                        if (temp > 0.75)
                            value(i,j) = xn(i,j)+1;
                        else
                            value(i,j) = xn(i,j);
                        end
                    end
                end
            end
            value(find(value == 0)) = 10;
            value(find(value == 11)) = 1;
        end
        if (nargin == 2)
            value = 1;
        end
    end
%% 方案3：平滑推荐
    if (method == 3)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = zeros(K,K);
            for i = 1:K
                for j = 1:K
                    if (i == 1)
                        up = xn(K,j);
                    else
                        up = xn(i-1,j);
                    end
                    if (i == K)
                        down = xn(1,j);
                    else
                        down = xn(i+1,j);
                    end
                    if (j == 1)
                        left = xn(i,K);
                    else
                        left = xn(i,j-1);
                    end
                    if (j == K)
                        right = xn(i,1);
                    else
                        right = xn(i,j+1);
                    end
                    ave = (up+down+left+right)/4;
                    value(i,j) = ave+unidrnd(5)-3;
                end
            end
            value(find(value == -2)) = 8;
            value(find(value == -1)) = 9;
            value(find(value == 0)) = 10;
            value(find(value == 11)) = 1;
            value(find(value == 12)) = 2;
            value(find(value == 13)) = 3;
        end
        if (nargin == 2)
            x1 = varargin(1);
            x1 = x1{1};
            x2 = varargin(2);
            x2 = x2{1};
            ex1 = mean(mean(x1));
            ex2 = mean(mean(x2));
            var1 = mean(mean(x1-ex1).^2);
            var2 = mean(mean(x2-ex2).^2);
            value = var1/var2;
        end      
    end
end