% 定义n的取值范围
n = 0.011:0.00001:2.83; % 从0.011到2.83，步长为0.01
n0 = 0.1;
Gq0 = 2.56e-4;
u = 20; % m/s
w0 = 10; % 请根据实际情况修改

% 初始化数组
f = zeros(size(n));
w = zeros(size(n));
Gqf = zeros(size(n));
PLB = zeros(size(n));
PLB2 = zeros(size(n));
H = zeros(size(n));
Gz = zeros(size(n));

% 循环计算每个n对应的f, w, PLB, PLB2, H, Gqf和Gz
for i = 1:length(n)
    f(i) = u * n(i);
    w(i) = 2*pi*f(i);
    PLB(i) = w(i) / w0;
    PLB2(i) = (w(i) / w0)^2;
    ff = f(i) * f(i);
    Gqf(i) = Gq0 * n0 * n0 * u * (1 / ff);
    H(i) = w(i) * w(i) * sqrt((1 + PLB2(i)) / ((1 - PLB2(i)) * (1 - PLB2(i)) + PLB2(i)));
    Gz(i) = H(i) * H(i) * Gqf(i);
end

x=w;
y=Gz;

% 选择拟合类型，使用三次多项式模型
ft = fittype('a*x^2 + b*x + c');

% 进行曲线拟合
[c, gof] = fit(x', y', ft);

% 提取拟合参数
a = c(1);
b = c(2);
c = c(3);

% 创建模型函数时，使用按元素求幂
model_func = @(x) a.*x.^2 + b.*x + c;

% 定义积分区间的上下限
x_min = 0.1; % x的最小值
x_max = 10;  % x的最大值

% 使用模型函数进行积分
try
    integral_result = integral(model_func, x_min, x_max);
    disp(['积分结果为: ' num2str(integral_result)]);
catch exception
    disp('积分过程中出现问题：', exception.message);
end

% 计算对数
logf = log10(f);
logw=log10(w);
logGqf = log10(Gqf);
logH = log10(H);
logGz = log10(Gz);
logPLB=log10(PLB);

% 绘制Gqf的图像
figure; % 创建第一个图形窗口
plot(logw, logGqf); % 绘制Logw和logGqf的图像
title('LogGqf-Logw');
xlabel('Logw');
ylabel('logGqf');
grid on; % 显示网格

% 绘制Gqf的图像
figure; % 创建第一个图形窗口
plot(logPLB,logH); % 绘制Logw和logPLB的图像
title('LogH-LogPLB');
xlabel('LogPLB');
ylabel('logH');
grid on; % 显示网格

% 绘制Gqf的图像
figure ; % 创建第一个图形窗口
plot(logPLB, logGz); % 绘制LogPLB和logGz的图像
title('LogGz-LogPLB');
xlabel('LogPLB');
ylabel('logGz');
grid on; % 显示网格
