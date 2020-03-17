% 准备数据
file_path = 'E:\学习资料\大三上\信号处理\training2017\raw_signals';
signals = dir(fullfile(file_path, '*.mat'));

% 设计kaise窗FIR滤波器
Fs = 300;  % 300Hz采样频率
fcuts = [3 6 25 28];  % 带通滤波，8-25Hz，3Hz过渡带
mags = [0 1 0];  % 通带内放大倍数1，阻带内放大倍数0
devs = [0.05 0.01 0.05];  % 通带与阻带内波纹

[n_order, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, Fs);
hh = fir1(n_order, Wn, ftype, kaiser(n_order + 1, beta), 'noscale');

for i = 1:500
    signal_path = fullfile(signals(i).folder, signals(i).name);
    signal_struct = load(signal_path);  % 返回一个struct
    signal_val = signal_struct.val(:);  % 获取信号所有取值
    
    N = length(signal_val);  % 采样点数
    t = N / Fs;  % 信号持续时间/s
    time = 0:(1/Fs):(t-1/Fs);  % 时间数组
    n = 0:N-1;  % 点数数组
    
    voltage = signal_val / 1000;  % 获取电压值
    voltage_filtered = filter(hh, 1, voltage);  % 对电压进行滤波

    n1 = (n_order - 1) / 2;
    val = voltage_filtered(n1: 1: end);
    save(signals(i).name, 'val');
end
