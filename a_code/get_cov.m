% �˺��������������x,y������Э����
function cov = get_cov(x,y)
    ex = mean(x);
    ey = mean(y);
   cov = mean((x-ex).*(y-ey));
end