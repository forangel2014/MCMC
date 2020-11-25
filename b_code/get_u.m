% 此函数对给定的状态x，求其能量u
function u = get_u(x)
% 认为该模型是周期性边界条件
    global K
    x_up = [x(1:K-1,:)-x(2:K,:); x(K,:)-x(1,:)];
    x_left = [x(:,1:K-1)-x(:,2:K) x(:,K)-x(:,1)];
    u = -(sum(sum(x_up == 0)) + sum(sum(x_left == 0)));

%      x_up = [x(1:K-1,:)-x(2:K,:)];
%      x_left = [x(:,1:K-1)-x(:,2:K)];
%      u = -(sum(sum(x_up == 0)) + sum(sum(x_left == 0)));
end