% �˺���ʵ��MH�㷨�е��Ƽ�����
% ��1������������xn�����ػ���xn���Ƽ�ֵx_propose
% ��2������������x1��x2��������x1ת�Ƶ�x2����������
function value = Q_gauss(varargin)
    narginchk(1,2);
    global u
    global method
    global sigma
%    global pi
%% ����1������Ƽ�
    if (method == 1)
         if (nargin == 1)
             value = (rand(2,1)-[0.5;0.5])*10+u; %�ھ�ֵ����+-5�ķ�Χ�����һ�����Ƽ�
         end
         if (nargin == 2)
             value = 1; %ת�Ƹ��ʶԳƣ�ֱ��ȡ1
         end
    end
%% ����2������xyת���Ƽ�
    if (method == 2)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = xn + rand(2,1)-[0.5;0.5]; %��xn����+-0.5�ķ�Χ�����һ�����Ƽ�
        end
        if (nargin == 2)
            value = 1; %ת�Ƹ��ʶԳƣ�ֱ��ȡ1
        end
    end
%% ����3��ƫ���ֵ��xyת���Ƽ�
    if (method == 3)
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            value = xn + rand(2,1)-[0.5;0.5] + 0.01*(u-xn);
            %��1�Ļ����ϣ������˰����������ֵ��һ��
        end
        if (nargin == 2)
            % ����Q(x2|x1)
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
%% ����4��ƫ���ֵ�ķ���/��������Ƽ�
    if (method == 4) 
        if (nargin == 1)
            xn = varargin(1);
            xn = xn{1};
            n = u-xn;
            dis = norm(n);
            n = n/dis;
            t = [-n(2); n(1)];
            value = xn + (rand(1)-0.5)*n + (rand(1)-0.5)*t + 0.01*n; 
            %��3�Ļ����ϣ�����������Ϊ�˷��������򣨶���x��y��
        end
        if (nargin == 2)
            % ����Q(x2|x1)
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
