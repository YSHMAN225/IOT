fpath   = "C:\Users\yangshenghao\Desktop\实验结果\Matlab\daima\Acoustic\data\";
fname   = "1025最新复现FMCW.wav";
aufile  = strcat(fpath, fname);

freq    = [1000 11000];
% freq = 1;
duration= 0.1;
sigType = "FMCW";
switch sigType
    case "CW"
        genCWwave(aufile, freq, duration);
    case "FMCW"
        genFMCWwave(aufile, freq, duration);
    case "pulse"
        gengauspuls(aufile, freq, duration);
    otherwise
        disp("There is no input type");
end