% 此函数实现MH算法中的推荐矩阵
% 对1个参数的输入xn，返回基于xn的推荐值x_propose
% 对2个参数的输入x1，x2，返回由x1转移到x2的条件概率
function value = Q_gauss(varargin)
    narginchk(1,2);
    global u
    global method
    global sigma
%    global pi
%% 方案1：随机推荐
    if (method == 1)
         if (nargin == 1)
             value = (rand(2,1)-[0.5;0.5])*10+u; %在均值附近+-5的范围内随机一个点推荐
         end
         if (nargin == 2)
             value = 1; %转移概率对称，直接取1
         end
    end
%% 方案2：均匀xy转移推荐
    if (method == 2)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = xn + rand(2,1)-[0.5;0.5]; %在xn附近+-0.5的范围内随机一个点推荐
        end
        if (nargin == 2)
            value = 1; %转移概率对称，直接取1
        end
    end
%% 方案3：偏向均值的xy转移推荐
    if (method == 3)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = xn + rand(2,1)-[0.5;0.5] + 0.01*(u-xn);
            %在1的基础上，增加了按比例趋向均值的一项
        end
        if (nargin == 2)
            % 计算Q(x2|x1)
            x1 = varargin(1);
            x1 = x1{1};
            x2 = varargin(2);
            x2 = x2{1};
            delta = x2-x1-0.01*(u-x1);
            if (abs(delta(1)) < 0.5 && abs(delta(2)) < 0.5)
                value = 1;
            else
                value = 0.1;
            end
        end
    end
%% 方案4：偏向均值的法向/切向均匀推荐
    if (method == 4) 
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            n = u-xn;
            dis = norm(n);
            n = n/dis;
            t = [-n(2); n(1)];
            value = xn + (rand(1)-0.5)*n + (rand(1)-0.5)*t + 0.01*n; 
            %在3的基础上，将随机方向改为了法向与切向（而非x和y）
        end
        if (nargin == 2)
            % 计算Q(x2|x1)
            x1 = varargin(1);
            x1 = x1{1};
            x2 = varargin(2);
            x2 = x2{1};
            n = u-x1;
            dis = norm(n);
            n = n/dis;
            t = [-n(2); n(1)];
            delta = x2-x1-0.01*n;
            deltan = delta'*n;
            deltat = delta'*t;
             if (abs(deltan) < 0.5 && abs(deltat) < 0.5)
                 value = 1;
             else
                 value = 0.1;
             end
        end
    end
end
