% 定义n的取值范围
n = 0.011:0.01:2.83; % 从0.011到2.83，步长为0.01
n0 = 0.1;
Gq0 = 2.56e-4;
u = 20; % m/s

% 初始化数组
f = zeros(size(n));
Gqf = zeros(size(n));
Gq1f = zeros(size(n));
Gq2f = zeros(size(n));

% 循环计算每个n对应的f, Gqf, Gq1f和Gq2f
for i = 1:length(n)
    f(i) = u * n(i);
    if f(i) ~= 0
        ff = f(i) * f(i);
        Gqf(i) = Gq0 * n0 * n0 * u * (1 / ff);
        Gq1f(i) = 4 * pi * pi * Gq0 * n0 * n0 * f(i);
        Gq2f(i) = 16 * pi * pi * pi * Gq0 * n0 * n0 * u * ff;
    else
        error('f cannot be zero at n = %f', n(i));
    end
end

% 计算对数
Logf = log10(f);
logGqf = log10(Gqf);
logGq1f = log10(Gq1f);
logGq2f = log10(Gq2f);

% 绘制Gqf的图像
figure1 = figure; % 创建第一个图形窗口
plot(Logf, logGqf); % 绘制Logf和logGqf的图像
title('LogGqf-Logf');
xlabel('Logf');
ylabel('logGqf');
grid on; % 显示网格

% 绘制Gq1f的图像
figure2 = figure; % 创建第二个图形窗口
plot(Logf, logGq1f); % 绘制Logf和logGq1f的图像
title('LogGq1f_Logf');
xlabel('Logf');
ylabel('logGq1f');
grid on; % 显示网格

% 绘制Gq2f的图像
figure3 = figure; % 创建第三个图形窗口
plot(Logf, logGq2f); % 绘制Logf和logGq2f的图像
title('LogGq2f_Logf');
xlabel('Logf');
ylabel('logGq2f');
grid on; % 显示网格
