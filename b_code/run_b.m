% ���ļ�������b���⣺��Pottsģ�ͽ��г����Թ��ƹ�һ������Z
clear all, clc, close all;
%% �趨
global q
q = 10;
global K
K = 20;
J_set = [1.4 1.4065 1.413 1.4195 1.426];
delta = 0.001; %�趨��ͼ��
J = J_set(1); %�趨�¶�
%lnZ = -int(U,a,b), where U = E(u(x))
iterations = 100; %��������
lnZ = 400*log(10); %lnZ��ֵ
%% ѡ���㷨
SW();
%MH_Potts();