% ׼������
demo_path = 'E:\ѧϰ����\������\�źŴ���\training2017\training2017\demo';
% ׼������������������Afib�źŵ�������ͷ�ļ�
Noise_signals = dir(fullfile(demo_path, 'Noise\', '*.mat'));
Noise_headings = dir(fullfile(demo_path, 'Noise\', '*.hea'));

Normal_signals = dir(fullfile(demo_path, 'Normal\', '*.mat'));
Normal_headings = dir(fullfile(demo_path, 'Normal\', '*.hea'));

Afib_signals = dir(fullfile(demo_path, 'AFib\', '*mat'));
Afib_headings = dir(fullfile(demo_path, 'AFib\', '*.hea'));
% �������źŽ���ʱ����ƣ�DFT��Ƶ��������λ�빦���׻���
for i = 1:15
    heading_path = fullfile(Normal_headings(i).folder, Normal_headings(i).name);
    signal_path = fullfile(Normal_signals(i).folder, Normal_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % ����Ƶ��300Hz
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������
    
    % ����ԭʼ�ź�
    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Normal Original '+string(Normal_signals(i).name)+' .png','-dpng','-r500');
    
    % ����FFT�������Ƶ���ԣ�
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Normal FFT '+string(Normal_signals(i).name)+' .png','-dpng','-r500');

    % ������0Ϊ���ĵķ�Ƶ���������빦����
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
% ��Afib�źŽ���ʱ����ƣ�DFT��Ƶ��������λ�빦���׻���
for i = 1:15
    heading_path = fullfile(Afib_headings(i).folder, Afib_headings(i).name);
    signal_path = fullfile(Afib_signals(i).folder, Afib_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % ����Ƶ��300Hz
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������
    
    % ����ԭʼ�ź�
    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Afib Original '+string(Afib_signals(i).name)+' .png','-dpng','-r500');
    
    % ����FFT�������Ƶ���ԣ�
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Afib FFT '+string(Afib_signals(i).name)+' .png','-dpng','-r500');

    % ������0Ϊ���ĵķ�Ƶ���������빦����
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
% �������źŽ���ʱ����ƣ�DFT��Ƶ��������λ�빦���׻���
for i = 1:15
    heading_path = fullfile(Noise_headings(i).folder, Noise_headings(i).name);
    signal_path = fullfile(Noise_signals(i).folder, Noise_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    Fs = 300;  % ����Ƶ��300Hz
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������
    
    % ����ԭʼ�ź�
    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    time = 0:(1/Fs):(t-1/Fs);
    figure('Name', 'Original Signal', 'NumberTitle', 'off');
    plot(time, voltage);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('Original Signal');
    print('Noise Original '+string(Noise_signals(i).name)+' .png','-dpng','-r500');
    
    % ����FFT�������Ƶ���ԣ�
    y = fft(voltage);
    f = Fs / N * (0 : N - 1);
    figure('Name', 'DFT Amplitude Spectrum', 'NumberTitle', 'off');
    plot(f, abs(y));
    xlabel('Analog Frequency/Hz');
    ylabel('Amplitude Response');
    title('DFT Amplitude Spectrum');
    print('Noise FFT '+string(Noise_signals(i).name)+' .png','-dpng','-r500');

    % ������0Ϊ���ĵķ�Ƶ���������빦����
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