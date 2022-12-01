function [auTime, sig] = readWAV(auFile, soundFlag)
%READWAV 读取声波文件 
%   auFile: 声音文件名
%   soundFlag：是否播放声音
%   auTime：时间信息
%   sig：声波振幅信息

    % === Initialization === %
    auTime  = [];
    sig     = [];
    
    % === Processing === %
    if exist(auFile, 'file')
        disp(auFile);
        [sig, Fs] = audioread(auFile);
        auTime      = (1:length(sig))/Fs;
        if soundFlag
            sound(sig, Fs);
        end
    else
        errordlg('读取的文件不存在！', 'File Error');
    end
end

