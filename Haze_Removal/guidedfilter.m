function q = guidedfilter(I, p, w, epsilon)
%   �����˲�
%
%   I:����ͼ
%   p:����ͼ��
%   w:���ڿ��
%   epsilon:����ϵ��

N = boxfilter(ones(size(I)),w);
%1:
mean_I = boxfilter(I,w)./N;
mean_p = boxfilter(p,w)./N;
corr_I = boxfilter(I.*I,w)./N;
corr_Ip = boxfilter(I.*p,w)./N;
%2:
var_I = corr_I - mean_I .* mean_I;
cov_Ip = corr_Ip - mean_I .* mean_p;
%3:
a = cov_Ip ./ (var_I + epsilon);
b = mean_p - a .* mean_I;
%4:
mean_a = boxfilter(a,w)./N;
mean_b = boxfilter(b,w)./N;
%5:
q = mean_a .* I + mean_b;
end