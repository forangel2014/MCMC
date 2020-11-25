% 本文件代码解决a问题：对给定的二维高斯分布进行抽样
clear all, clc, close all;
%% 设定
global u %均值
u = [5 10]';
global sigma %协方差矩阵
sigma = [1 1; 1 4];
%% 选择算法
%MH_Gauss();
Gibbs();