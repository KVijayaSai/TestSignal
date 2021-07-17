%
Fs = 2e07;  %sampling frequency
Ts = 1/Fs;  %sampling period
end_time = 10^-3;
t = 0:Ts:end_time-Ts;
freq_range = [1.96e06 2e06];
t1 = 0:Ts:(end_time/2)-Ts;

%Signal
x = 1*sin(2*pi*2e06*t) +1*sin(2*pi*1.96e06*t);

%signal fft
N = length(x);
N1 = 2^nextpow2(N);
y = fft(x,N1);
x_axis = Fs*(0:(N1)-1)/N1;

p_in_dBm = 10*log10 (abs(y).^2/100*10^-3);  %inputpower in dBm

%signal ifft
x1 = ifft(y);
x1f = x1(1:N1);

%chcecking i/p signal power level with P1dB
% for i = 1: length(p_in_dBm)
%     if p_in_dBm(i) >= -20.5
%         y(i) = y(i);
%     else
%         y(i) = 0;
%     end
% end

y1f = 7.943282347*(x1f) - 427.824*(x1f.^3); %nonlinear equation(a1*x + a3*x^3)




%fft of output
 yf2 = fft(y1f,N1);
 p_out_in_dBm = 10*log10 (abs(yf2).^2/100*10^-3) ;
 
%  figure
%  plot(p_in_dBm,y11);
%  hold on
%  plot(p_in_dBm,y33);
%  legend('1:1','3:1')
%  hold off
 
 figure
 plot(x1f,y1f);xlabel('Voltage input');ylabel('voltage output');

figure
plot(x_axis/1e06,p_out_in_dBm); xlabel('Frequency in MHz');ylabel('o/p in dBm');title('FFT of output signal');

% figure(3)
% plot(p_in_dBm,p_out1_in_dBm);
% hold on
% plot(p_in_dBm,p_out3_in_dBm);xlabel('p in dBm');ylabel('p out dBm');
% legend('1:1','3:1')
% hold off
% 
%figure
%plot(t,y1f);xlabel('Time');ylabel('Amplitude');title('output signal');

figure
plot(x_axis/1e06,p_in_dBm); xlabel('Frequency in MHz');ylabel('i/p in dBm');title('FFT of input signal');
