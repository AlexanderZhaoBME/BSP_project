% ׼������
file_path = 'E:\ѧϰ����\������\�źŴ���\training2017\raw_signals';
signals = dir(fullfile(file_path, '*.mat'));

% ���kaise��FIR�˲���
Fs = 300;  % 300Hz����Ƶ��
fcuts = [3 6 25 28];  % ��ͨ�˲���8-25Hz��3Hz���ɴ�
mags = [0 1 0];  % ͨ���ڷŴ���1������ڷŴ���0
devs = [0.05 0.01 0.05];  % ͨ��������ڲ���

[n_order, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, Fs);
hh = fir1(n_order, Wn, ftype, kaiser(n_order + 1, beta), 'noscale');

for i = 1:500
    signal_path = fullfile(signals(i).folder, signals(i).name);
    signal_struct = load(signal_path);  % ����һ��struct
    signal_val = signal_struct.val(:);  % ��ȡ�ź�����ȡֵ
    
    N = length(signal_val);  % ��������
    t = N / Fs;  % �źų���ʱ��/s
    time = 0:(1/Fs):(t-1/Fs);  % ʱ������
    n = 0:N-1;  % ��������
    
    voltage = signal_val / 1000;  % ��ȡ��ѹֵ
    voltage_filtered = filter(hh, 1, voltage);  % �Ե�ѹ�����˲�

    n1 = (n_order - 1) / 2;
    val = voltage_filtered(n1: 1: end);
    save(signals(i).name, 'val');
end
