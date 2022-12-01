function genFMCWwave(auFile, freq, duration)
%GENCWWAVE 此处显示有关此函数的摘要
%   auFile: 保存的声波文件名称
%   freq: 单频信号的频率
%   sduration: 信号时长

    % === PreProcessing === %
    if length(freq) ~= 2 || freq(1)>freq(2)
        errordlg('频率设置不满足要求！', 'File Error'); 
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
        selection = uiconfirm(fig,'是否覆盖文件?','Warning', 'Icon','warning');
        if strcmp(selection,"OK")
            audiowrite(auFile, sig, Fs);
        end
        close(fig);
    else
        audiowrite(auFile, sig, Fs);
    end
    
end

