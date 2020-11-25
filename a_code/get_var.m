% 此函数对输入的序列x计算其方差
function var = get_var(x)
    ex = mean(x);
    var = mean((x-ex).*(x-ex));
end