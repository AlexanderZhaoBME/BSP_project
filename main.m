% 准备数据
demo_path = 'E:\学习资料\大三上\信号处理\training2017\training2017\demo';
% 准备部分正常、噪声、Afib信号的序列与头文件
Noise_signals = dir(fullfile(demo_path, 'Noise\', '*.mat'));
Noise_headings = dir(fullfile(demo_path, 'Noise\', '*.hea'));

Normal_signals = dir(fullfile(demo_path, 'Normal\', '*.mat'));
Normal_headings = dir(fullfile(demo_path, 'Normal\', '*.hea'));

Afib_signals = dir(fullfile(demo_path, 'AFib\', '*mat'));
Afib_headings = dir(fullfile(demo_path, 'AFib\', '*.hea'));
% 对正常信号进行时域绘制，DFT，频谱中心移位与功率谱绘制
for i = 1:15
    heading_path = fullfile(Normal_headings(i).folder, Normal_headings(i).name);
    signal_path = fullfile(Normal_signals(i).folder, Normal_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % 采样频率300Hz
    N = info1(3);  % 采样点数
    gain = info2(3);  % 每mV对应点数
    zerovalue = info2(5);  % 信号零点位置
    t = N / Fs;  % 信号持续时间/s
    time = 0:(1/Fs):(t-1/Fs);  % 时间数组
    n = 0:N-1;  % 点数数组
    
    % 绘制原始信号
    signal_struct = load(signal_path);  % 返回一个struct
    signal_val = signal_struct.val(:);  % 获取信号所有取值
    signal_val_zerocenter = signal_val - zerovalue;  % 将零点移到0值上
    voltage = signal_val_zerocenter / gain;  % 获取电压值
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Normal Original '+string(Normal_signals(i).name)+' .png','-dpng','-r500');
    
    % 绘制FFT结果（幅频特性）
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Normal FFT '+string(Normal_signals(i).name)+' .png','-dpng','-r500');

    % 绘制以0为中心的幅频特性曲线与功率谱
    y_center = fftshift(y);
    powershift = abs(y_center) .^2 / N;
    f_center = Fs / N * (- N / 2 : N / 2 - 1);
    figure('Name', 'Zero Center Frequency Spectrum', 'NumberTitle', 'off');
    plot(f_center, abs(y_center));
    xlabel('Frequency/Hz');
    ylabel('Amplitude Response');
    title('Zero Center Frequency Spectrum');
    print('Normal ZeroCenterFFT '+string(Normal_signals(i).name)+' .png','-dpng','-r500');
    
    figure('Name', 'Zero Center Power Spectrum', 'NumberTitle', 'off');
    plot(f_center, powershift);
    xlabel('Frequency/Hz');
    ylabel('Power');
    title('Zero Center Power Spectrum');
    print('Normal Power '+string(Normal_signals(i).name)+' .png','-dpng','-r500');
    close all;
end
% 对Afib信号进行时域绘制，DFT，频谱中心移位与功率谱绘制
for i = 1:15
    heading_path = fullfile(Afib_headings(i).folder, Afib_headings(i).name);
    signal_path = fullfile(Afib_signals(i).folder, Afib_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % 采样频率300Hz
    N = info1(3);  % 采样点数
    gain = info2(3);  % 每mV对应点数
    zerovalue = info2(5);  % 信号零点位置
    t = N / Fs;  % 信号持续时间/s
    time = 0:(1/Fs):(t-1/Fs);  % 时间数组
    n = 0:N-1;  % 点数数组
    
    % 绘制原始信号
    signal_struct = load(signal_path);  % 返回一个struct
    signal_val = signal_struct.val(:);  % 获取信号所有取值
    signal_val_zerocenter = signal_val - zerovalue;  % 将零点移到0值上
    voltage = signal_val_zerocenter / gain;  % 获取电压值
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Afib Original '+string(Afib_signals(i).name)+' .png','-dpng','-r500');
    
    % 绘制FFT结果（幅频特性）
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Afib FFT '+string(Afib_signals(i).name)+' .png','-dpng','-r500');

    % 绘制以0为中心的幅频特性曲线与功率谱
    y_center = fftshift(y);
    powershift = abs(y_center) .^2 / N;
    f_center = Fs / N * (- N / 2 : N / 2 - 1);
    figure('Name', 'Zero Center Frequency Spectrum', 'NumberTitle', 'off');
    plot(f_center, abs(y_center));
    xlabel('Frequency/Hz');
    ylabel('Amplitude Response');
    title('Zero Center Frequency Spectrum');
    print('Afib ZeroCenterFFT '+string(Afib_signals(i).name)+' .png','-dpng','-r500');
    
    figure('Name', 'Zero Center Power Spectrum', 'NumberTitle', 'off');
    plot(f_center, powershift);
    xlabel('Frequency/Hz');
    ylabel('Power');
    title('Zero Center Power Spectrum');
    print('Afib Power '+string(Afib_signals(i).name)+' .png','-dpng','-r500');
    close all;
end
% 对噪声信号进行时域绘制，DFT，频谱中心移位与功率谱绘制
for i = 1:15
    heading_path = fullfile(Noise_headings(i).folder, Noise_headings(i).name);
    signal_path = fullfile(Noise_signals(i).folder, Noise_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % 采样频率300Hz
    N = info1(3);  % 采样点数
    gain = info2(3);  % 每mV对应点数
    zerovalue = info2(5);  % 信号零点位置
    t = N / Fs;  % 信号持续时间/s
    time = 0:(1/Fs):(t-1/Fs);  % 时间数组
    n = 0:N-1;  % 点数数组
    
    % 绘制原始信号
    signal_struct = load(signal_path);  % 返回一个struct
    signal_val = signal_struct.val(:);  % 获取信号所有取值
    signal_val_zerocenter = signal_val - zerovalue;  % 将零点移到0值上
    voltage = signal_val_zerocenter / gain;  % 获取电压值
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Noise Original '+string(Noise_signals(i).name)+' .png','-dpng','-r500');
    
    % 绘制FFT结果（幅频特性）
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Noise FFT '+string(Noise_signals(i).name)+' .png','-dpng','-r500');

    % 绘制以0为中心的幅频特性曲线与功率谱
    y_center = fftshift(y);
    powershift = abs(y_center) .^2 / N;
    f_center = Fs / N * (- N / 2 : N / 2 - 1);
    figure('Name', 'Zero Center Frequency Spectrum', 'NumberTitle', 'off');
    plot(f_center, abs(y_center));
    xlabel('Frequency/Hz');
    ylabel('Amplitude Response');
    title('Zero Center Frequency Spectrum');
    print('Noise ZeroCenterFFT '+string(Noise_signals(i).name)+' .png','-dpng','-r500');
    
    figure('Name', 'Zero Center Power Spectrum', 'NumberTitle', 'off');
    plot(f_center, powershift);
    xlabel('Frequency/Hz');
    ylabel('Power');
    title('Zero Center Power Spectrum');
    print('Noise Power '+string(Noise_signals(i).name)+' .png','-dpng','-r500');
    close all;
end