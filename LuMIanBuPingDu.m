% 定义n的取值范围
n = 0.011:0.01:2.83; % 从0.011到2.83，步长为0.01
n0 = 0.1;
Gq0 = 2.56e-4;
u = 20; % m/s
w0=10;

% 初始化数组
f = zeros(size(n));
w = zeros(size(n));
Gqf = zeros(size(n));
PLB2 = zeros(size(n));
H=zeros(size(n));
Gz=zeros(size(n));

% 循环计算每个n对应的f, Gqf, Gq1f和Gq2f
for i = 1:length(n)
    f(i) = u * n(i);
    w(i) = 2*pi*f(i);
    PLB2(i) =(w(i)/w0)^2;
    ff = f(i) * f(i);
    Gqf(i) = Gq0 * n0 * n0 * u * (1 / ff);
    H(i)=w(i)*w(i)*sqrt((1+PLB2(i))/((1-PLB2(i))*(1-PLB2(i))+PLB2(i)));
    Gz(i)=H(i)*H(i)*Gqf(i);
end

% 计算对数
Logf = log10(f);
logGqf = log10(Gqf);
logH = log10(H);
logGz = log10(Gz);

% 绘制Gqf的图像
figure; % 创建第一个图形窗口
plot(Logf, logGqf); % 绘制Logf和logGqf的图像
title('LogGqf-Logf');
xlabel('Logf');
ylabel('logGqf');
grid on; % 显示网格

% 绘制Gqf的图像
figure; % 创建第一个图形窗口
plot(Logf, H); % 绘制Logf和logH的图像
title('LogH-Logf');
xlabel('Logf');
ylabel('logH');
grid on; % 显示网格

% 绘制Gqf的图像
figure ; % 创建第一个图形窗口
plot(Logf, logGz); % 绘制Logf和logGz的图像
title('LogGz-Logf');
xlabel('Logf');
ylabel('logGz');
grid on; % 显示网格
