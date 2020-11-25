% 此函数对给定的状态x，温度倒数J，计算其未归一化概率p
function p = get_p(x,J)
    u = get_u(x);
    p = exp(-u*J);
end