% �˺��������������x�����䷽��
function var = get_var(x)
    ex = mean(x);
    var = mean((x-ex).*(x-ex));
end