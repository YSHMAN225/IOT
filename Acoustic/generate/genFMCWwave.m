function genFMCWwave(auFile, freq, duration)
%GENCWWAVE �˴���ʾ�йش˺�����ժҪ
%   auFile: ����������ļ�����
%   freq: ��Ƶ�źŵ�Ƶ��
%   sduration: �ź�ʱ��

    % === PreProcessing === %
    if length(freq) ~= 2 || freq(1)>freq(2)
        errordlg('Ƶ�����ò�����Ҫ��', 'File Error'); 
        return;
    end
    
    % === Initialization === %
    Fs          = 48000;
    sampleTime  = 0:1/48000:duration;
    fc          = (freq(2) + freq(1))/2;
    bw          = freq(2) - freq(1);
    slope       = bw/duration;
    
    sig         = [];
 for i=1:600
    sig     = [sig cos(2*pi*freq(1).*sampleTime +pi*slope*sampleTime.^2)];
%     sig     = [sig zeros(size(sampleTime))];
 end
 

    figure;
    plot(sig);
    stft(sig,48000);
    
    % === Processing === %
    if exist(auFile, 'file')
        fig = uifigure;
        selection = uiconfirm(fig,'�Ƿ񸲸��ļ�?','Warning', 'Icon','warning');
        if strcmp(selection,"OK")
            audiowrite(auFile, sig, Fs);
        end
        close(fig);
    else
        audiowrite(auFile, sig, Fs);
    end
    
end

