% 本文件代码解决b问题：对Potts模型进行抽样以估计归一化常数Z
clear all, clc, close all;
%% 设定
global q
q = 10;
global K
K = 20;
J_set = [1.4 1.4065 1.413 1.4195 1.426];
delta = 0.001; %设定求和间隔
J = J_set(1); %设定温度
%lnZ = -int(U,a,b), where U = E(u(x))
iterations = 100; %迭代次数
lnZ = 400*log(10); %lnZ初值
%% 选择算法
SW();
%MH_Potts();