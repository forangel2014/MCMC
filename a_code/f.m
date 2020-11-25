% 二维高斯分布的密度函数
function p = f(x)
    global u
    global sigma
    p = 1/(2*pi*det(sigma)^(1/2))*exp(-1/2*(x-u)'*inv(sigma)*(x-u));
end

