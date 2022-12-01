%%%%%实验收取信号
fpath   = "C:\Users\yangshenghao\Desktop\最近实验\111实验\119\119物体静止\1米\";
fname   = "1191米静止.wav";
aufile  = strcat(fpath, fname);
soundFlg= 0;
[time,sigRx] = readWAV(aufile, soundFlg);
sigRx=sigRx(:,1);
% x2=sigRx(:,2);%选取声道

%%%%%%原信号
fpath   = "C:\Users\yangshenghao\Desktop\重要\实验结果\Matlab\daima\Acoustic\data\";
fname   = "1025最新复现FMCW.wav";
aufile  = strcat(fpath, fname);
soundFlg= 0;
[time2,sigTx] = readWAV(aufile, soundFlg);
IF=sigRx(1:2880000).*sigTx(1:2880000);  %混频后获取中频信号
IF=IF.';

%产生一个长度一样的cos信号频率为中心频率，产生一个长度一样的sin信号，x1*cos,x1*sin，得到一个复数，x2同理，得到的复数进行混频，混频之后求相邻两个采样点的相位差
%根据论文里的公式求频差
c=[];
for i=0:599
%%%巴特沃斯低通滤波器
I=IF(1+i*4800:4800*(i+1));
Wp = [750 11000]/24000; 
% 通带减个150
Ws = [700 11050]/24000;
% 小于900 1200/1400
Rp = 0.1;
Rs = 30;
[n,Wn] = buttord(Wp,Ws,Rp,Rs);
[b,a]=butter(1,Wn);
y2 = filter(b,a,I);

%%%傅里叶变换
y=fft(y2);
P2 = (y/4800);
P1 = P2(1:4800/2+1);
P1(2:end-1) = 2*P1(2:end-1);
c=[c;P2];
end
C=340;%声速
figure;
f = 48000*(0:(4800/2))/4800;
r=f.*C/(2*10000/0.1);
rge=(1:4800);
h=(0.1:0.1:60);
[e,g]=meshgrid(h,rge);

%%%%%相位
A=c.';
B=c;

%%1.除的列（第二强度）相位
% Ah=A(:,1:end-1);
% Bh=A(:,2:end);
% Ch=(Bh./Ah).';
% Dh=Ch(:,143);

%%2.原来的横（一个chirp ）相位
% Dh=B(100,:);
% plot(abs(Ch));
Ah=A(283,:);
Bh=A(341,:);
Ch=(Bh./Ah).';
theta = angle(Ch);
plot(abs(theta));
% Q = unwrap(theta);
% stem(h,theta)

% xlabel 'Frequency (Hz)' 
% ylabel 'Phase '
% plot(abs(Ch));

%%%做三维图（距离时间能量）
% mesh(e,g,abs(c.'));
% % ylim([0,5]);
% xlabel('chirp脉冲数')
% ylabel('距离（频率）')
% title('距离维FTF结果')








% n=0;
% h=linspace(0.1,60,600);
% Fs=48000;
% L=4800;
% C=340;
% f = Fs*(0:(L/2))/L;
% R=(C*600*f)/(20000);
% % f = fs*(0:(4800/2))/4800;
% c=c.';
% s=pcolor(h,R,c);
% s.FaceColor = 'interp';
% figure;
% % xlabel('时间')
% % ylabel('fft纵轴参数')
% % title("图解")
% plot(abs(c));
% end
% y1=fft(y);
% subplot(2,1,2)
% plot(y);


% xk=fft(y,N);
% plot(abs(xk));
% [pks,locs] = findpeaks(y,'MinPeakDistance',0.00036);
% plot(findpeaks(pks))
% plot(year,avSpots,year(locs),pks,'or')
% xlabel('时间')
% ylabel('幅度')
% title('最高峰')
% axis tight
% plot(time,y)
%     Fs          = 48000;
%     sampleTime  = 0:1/Fs:max(time); 
%     sigTx         = cos(2*pi*freq*time);
%    mixedsig=sigRx'.*sigTx;
%     mixedsig=mixedsig'; 

% if ~isempty(ts)
% %     figure;
% %     subplot(3,1,1);
% %     plot(time, x2);
% %     subplot(3,1,2);
% %     plot(time, x1);
% %     figure;
% %     timestamp =  [1:size(sigRx,1)]/Fs;
% %     plot(Xk);
% %     findpeaks(sigRx,48000, 'MinPeakDistance' ,0.2)
% %     subplot(3,1,3);
% %     plot(time, y);
% end



