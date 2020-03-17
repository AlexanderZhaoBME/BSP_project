% ׼���ļ�
demo_path = 'E:\ѧϰ����\������\�źŴ���\training2017\training2017\demo';

Noise_signals = dir(fullfile(demo_path, 'Noise\', '*.mat'));
Noise_headings = dir(fullfile(demo_path, 'Noise\', '*.hea'));

Normal_signals = dir(fullfile(demo_path, 'Normal\', '*.mat'));
Normal_headings = dir(fullfile(demo_path, 'Normal\', '*.hea'));

Afib_signals = dir(fullfile(demo_path, 'AFib\', '*mat'));
Afib_headings = dir(fullfile(demo_path, 'AFib\', '*.hea'));

% ���kaise��FIR�˲���
Fs = 300;  % 300Hz����Ƶ��
fcuts = [1 4 25 28];  % ��ͨ�˲���8-25Hz��3Hz���ɴ�
mags = [0 1 0];  % ͨ���ڷŴ���1������ڷŴ���0
devs = [0.05 0.01 0.05];  % ͨ��������ڲ���

[n_order, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, Fs);
hh = fir1(n_order, Wn, ftype, kaiser(n_order + 1, beta), 'noscale');

for i = 1:15
    heading_path = fullfile(Normal_headings(i).folder, Normal_headings(i).name);
    signal_path = fullfile(Normal_signals(i).folder, Normal_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������

    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    voltage_filtered = filter(hh, 1, voltage);  % �Ե�ѹ�����˲�

    % ������λ�ӳ�
    n1 = (n_order - 1) / 2;
    voltage_filtered1 = voltage_filtered(n1: 1: end);
    time1 = 0 : 1/Fs : (t - n1 / Fs);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time1, voltage_filtered1);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Normal Filtered '+string(Normal_signals(i).name)+' .png','-dpng','-r500');

    % ����ϸ��
    time_short = 0: 1/Fs: 5;
    voltage_short = voltage_filtered(n1: 1: 1500 + n1);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time_short, voltage_short);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Normal Filtered Details '+string(Normal_signals(i).name)+' .png','-dpng','-r500');
    close all;
end

for i = 1:15
    heading_path = fullfile(Afib_headings(i).folder, Afib_headings(i).name);
    signal_path = fullfile(Afib_signals(i).folder, Afib_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������

    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    voltage_filtered = filter(hh, 1, voltage);  % �Ե�ѹ�����˲�

    % ������λ�ӳ�
    n1 = (n_order - 1) / 2;
    voltage_filtered1 = voltage_filtered(n1: 1: end);
    time1 = 0 : 1/Fs : (t - n1 / Fs);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time1, voltage_filtered1);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Afib Filtered '+string(Afib_signals(i).name)+' .png','-dpng','-r500');

    % ����ϸ��
    time_short = 0: 1/Fs: 5;
    voltage_short = voltage_filtered(n1: 1: 1500 + n1);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time_short, voltage_short);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Afib Filtered Details '+string(Afib_signals(i).name)+' .png','-dpng','-r500');
    close all;
end

for i = 1:15
    heading_path = fullfile(Noise_headings(i).folder, Noise_headings(i).name);
    signal_path = fullfile(Noise_signals(i).folder, Noise_signals(i).name);
    fid = fopen(heading_path,'r');
    tmp1 = fgetl(fid);
    tmp2 = fgetl(fid);
    info1 = sscanf(tmp1, '%*s %d %d %d',[1,3]);
    info2 = sscanf(tmp2, '%*s %d %d %d',[1,6]);
    N = info1(3);  % ��������
    gain = info2(3);  % ÿmV��Ӧ����
    zerovalue = info2(5);  % �ź����λ��
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������

    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    signal_val_zerocenter = signal_val - zerovalue;  % ������Ƶ�0ֵ��
    voltage = signal_val_zerocenter / gain;  % ��ȡ��ѹֵ
    voltage_filtered = filter(hh, 1, voltage);  % �Ե�ѹ�����˲�

    % ������λ�ӳ�
    n1 = (n_order - 1) / 2;
    voltage_filtered1 = voltage_filtered(n1: 1: end);
    time1 = 0 : 1/Fs : (t - n1 / Fs);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time1, voltage_filtered1);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Noise Filtered '+string(Noise_signals(i).name)+' .png','-dpng','-r500');

    % ����ϸ��
    time_short = 0: 1/Fs: 5;
    voltage_short = voltage_filtered(n1: 1: 1500 + n1);
    figure('Name', 'FIR Filtered(Remove Phase Delay)', 'NumberTitle', 'off');
    plot(time_short, voltage_short);
    xlabel('Time/s');
    ylabel('Voltage/mV');
    title('FIR Filtered Signal(Remove Phase Delay)');
    print('Noise Filtered Details '+string(Noise_signals(i).name)+' .png','-dpng','-r500');
    close all;
end