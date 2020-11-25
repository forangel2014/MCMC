% 此函数对输入的序列x,y计算其协方差
function cov = get_cov(x,y)
    ex = mean(x);
    ey = mean(y);
   cov = mean((x-ex).*(y-ey));
end