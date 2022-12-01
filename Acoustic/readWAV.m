function [auTime, sig] = readWAV(auFile, soundFlag)
%READWAV ��ȡ�����ļ� 
%   auFile: �����ļ���
%   soundFlag���Ƿ񲥷�����
%   auTime��ʱ����Ϣ
%   sig�����������Ϣ

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
        errordlg('��ȡ���ļ������ڣ�', 'File Error');
    end
end

