% ��ά��˹�ֲ����ܶȺ���
function p = f(x)
    global u
    global sigma
    p = 1/(2*pi*det(sigma)^(1/2))*exp(-1/2*(x-u)'*inv(sigma)*(x-u));
end

