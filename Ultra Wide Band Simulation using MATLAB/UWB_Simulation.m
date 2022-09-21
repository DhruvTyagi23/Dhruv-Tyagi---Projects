%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                 (2K19-EP-032) Dhruv Tyagi & Ayush Kumar (2K19-EP-030)
%
%                   EMT Mid Term Evaluation Project
%                PPM & Link Analysis of UWB monocycle & doublet waveforms
%
%
%This m file plots the time and frequency waveforms for PPM 1st and 2nd derivative 
%equations used in UWB system analysis. Fudge factors are required to
%correct for inaccuracies in the 1st and 2nd derivative equations.
%Tail to tail on the time wave forms must be considered as the actual pulse width. 
%7*PW1 has about 99.9% of the signal power. The frequency spreads and center 
%frequencies(fc=center of the spread)are correct as you can verify(fc~1/pw1).
%Change pw(fudge factor)and t for other entered(pw1) pulse widths and
%zooming in on the waveforms.A basic correlation receiver is constructed
%showing the demodulated output information from a comparator(10101). Perfect sync
%is assumed in the correlation receiver.
%Refer SETUP and other info at end of program.
%The program is not considered to be the ultimate in UWB link analysis, but is 
%configured to show basic concepts of the new technology.
%================================================
pw1=.5e-9;%pulse width in nanosec,change to desired width
pw=pw1/2.5;%Fudge factor to compensate for inaccuracies(approx. 4-5 for 1st der. and
%approx. 2-3 for 2nd der.)
Fs=100e9;%Sample frequency
Fn=Fs/2;%Nyquist frequency (Highest frequency that can be coded at a given sampling rate)
t=-1e-9:1/Fs:20e-8;%time vector sampled at Fs Hertz. zoom in/out using (-1e-9:1/Fs:xxxx)
A=1;
%================================================ 
% EQUATIONS
%================================================

%1st derivative of Gaussian pulse=Gaussian monocycle
%y=A*(t/pw).*exp(-(t/pw).^2);

%2nd derivative of Gaussian pulse=doublet(two zero crossings)
y =A*(1 - 4*pi.*((t)/pw).^2).* exp(-2*pi.*((t)/pw).^2);

% y=y.*sin((2*pi*t*4.5e9).^2)%spectrum notches(multipath)
%================================================
%==================================================
% 1ST DERIVATIVE MONOCYCLE(PPM WITH 5 PULSES)
%==================================================
%yp=y+ ...
%A*((t-2.5e-9-.2e-9)/pw).*exp(-((t-2.5e-9-.2e-9)/pw).^2)+A*((t-5e-9)/pw).*exp(-((t-5e-9)/pw).^2)+ ...
%A*((t-7.5e-9-.2e-9)/pw).*exp(-((t-7.5e-9-.2e-9)/pw).^2)+A*((t-10e-9)/pw).*exp(-((t-10e-9)/pw).^2);
%==================================================
% 2ND DERIVATIVE DOUBLET(PPM WITH 5 PULSES)
%==================================================
%modulated doublet
yp=y+ ...
A*(1-4*pi.*((t-2.5e-9-.2e-9)/pw).^2).*exp(-2*pi.*((t-2.5e-9-.2e-9)/pw).^2)+ ...
A*(1-4*pi.*((t-5.0e-9)/pw).^2).*exp(-2*pi.*((t-5.0e-9)/pw).^2)+ ...
A*(1-4*pi.*((t-7.5e-9-.2e-9)/pw).^2).*exp(-2*pi.*((t-7.5e-9-.2e-9)/pw).^2)+ ...
A*(1-4*pi.*((t-10e-9)/pw).^2).*exp(-2*pi.*((t-10e-9)/pw).^2);
%unmodulated doublet
B=1;%This shows how the anplitude matching of templet and modulated signal
%plays an important part. Would require AGC on first LNA to hold modulated
%sig constant within an expected multipath range.(B=.4 to .5 causes errors).  
yum=B*y+ ...
B*(1-4*pi.*((t-2.5e-9)/pw).^2).*exp(-2*pi.*((t-2.5e-9)/pw).^2)+ ...
B*(1-4*pi.*((t-5.0e-9)/pw).^2).*exp(-2*pi.*((t-5.0e-9)/pw).^2)+ ...
B*(1-4*pi.*((t-7.5e-9)/pw).^2).*exp(-2*pi.*((t-7.5e-9)/pw).^2)+ ...
B*(1-4*pi.*((t-10e-9)/pw).^2).*exp(-2*pi.*((t-10e-9)/pw).^2);
yc=yp.*yum;%yc(correlated output)=yp(modulated)times yum(unmodulated) doublet.
% SO the correlator output is basically the modulated*unmodulated doublet
%This is where the correlation occurs in the receiver and would be the
%first mixer in the receiver. 
%==================================================
% FFT %Discrete Fourier Transform
%==================================================
%new FFT for modulated doublet
y=yp;%y=modulated doublet
NFFY=2.^(ceil(log(length(y))/log(2)));
FFTY=fft(y,NFFY);%pad with zeros
NumUniquePts=ceil((NFFY+1)/2); 
FFTY=FFTY(1:NumUniquePts);
MY=abs(FFTY);
MY=MY*2;
MY(1)=MY(1)/2;
MY(length(MY))=MY(length(MY))/2;
MY=MY/length(y);
f=(0:NumUniquePts-1)*2*Fn/NFFY;
%new fft for unmodulated doublet
y1=yum;%unmodulated doublet
NFFY1=2.^(ceil(log(length(y1))/log(2)));
FFTY1=fft(y1,NFFY1);%pad with zeros
NumUniquePts=ceil((NFFY1+1)/2); 
FFTY1=FFTY1(1:NumUniquePts);
MY1=abs(FFTY1);
MY1=MY1*2;
MY1(1)=MY1(1)/2;
MY1(length(MY1))=MY1(length(MY1))/2;
MY1=MY1/length(y1);
f=(0:NumUniquePts-1)*2*Fn/NFFY1;
%new fft for correlated yc
y2=yc;%y2 is the time domain signal output of the multiplier
%(modulated times unmodulated) in the correlation receiver. Plots 
%in the time domain show that a simple comparator instead of high speed A/D's 
%could be used to recover the 10101 signal depending on integrator design. 
%We have not included an integrator in the program but it would be a properly 
%constructed low pass filter in an actual receiver.
NFFY2=2.^(ceil(log(length(y2))/log(2)));
FFTY2=fft(y2,NFFY2);%pad with zeros
NumUniquePts=ceil((NFFY2+1)/2); 
FFTY2=FFTY2(1:NumUniquePts);
MY2=abs(FFTY2);
MY2=MY2*2;
MY2(1)=MY2(1)/2;
MY2(length(MY2))=MY2(length(MY2))/2;
MY2=MY2/length(y2);
f=(0:NumUniquePts-1)*2*Fn/NFFY2;
%===================================================
% PLOTS
%===================================================
%plots for modulated doublet
figure(1)
subplot(2,2,1); plot(t,y);xlabel('TIME');ylabel('AMPLITUDE');
title('Modulated pulse train');
grid on;
axis([-1e-9,10e-9 -1 1])
subplot(2,2,2); plot(f,MY);xlabel('FREQUENCY');ylabel('AMPLITUDE(A)');
title('Waveform (Amplitude vs Frequency)');
%axis([0 10e9 0 .1]);%zoom in/out
grid on;
subplot(2,2,3); plot(f,20*log10(MY));xlabel('FREQUENCY');ylabel('20Log(A)=DB');
title('PSD Profile (Normalized Power vs Frequency)');
%axis([0 20e9 -120 0]);
grid on;
%plots for unmodulated doublet
figure(2)
subplot(2,2,1); plot(t,y1);xlabel('TIME');ylabel('AMPLITUDE');
title('Unmodulated pulse train');
grid on;
axis([-1e-9,10e-9 -1 1])
subplot(2,2,2); plot(f,MY1);xlabel('FREQUENCY');ylabel('AMPLITUDE');
title('Waveform (Amplitude vs Frequency)');
%axis([0 10e9 0 .1]);%zoom in/out
grid on;
subplot(2,2,3); plot(f,20*log10(MY1));xlabel('FREQUENCY');ylabel('20Log(A)=DB');
title('PSD Profile (Normalized Power vs Frequency)')
%axis([0 20e9 -120 0]);
grid on;
%plots for correlated yc
figure(3)
subplot(2,2,1); plot(t,y2);xlabel('TIME');ylabel('AMPLITUDE');
title('Receiver correlator output');
grid on;
axis([-1e-9,10e-9 -1 1])
subplot(2,2,2); plot(f,MY2);xlabel('FREQUENCY');ylabel('AMPLITUDE');
title('Waveform (Amplitude vs Frequency)');
axis([0 7e10 0 .025]);%zoom in/out
grid on;
subplot(2,2,3); plot(f,20*log10(MY2));xlabel('FREQUENCY');ylabel('20Log(A)=DB');
title('PSD Profile (Normalized Power vs Frequency)')
%axis([0 20e9 -120 0]);
grid on;
%================================================
%Comparator
%================================================
pt=.5;%sets level where threshhold device comparator triggers
H=5;%(volts)
L=0;%(volts)
LEN=length(y2);
for ii=1:LEN;
    if y2(ii)>=pt;%correlated output(y2) going above pt threshold setting
        pv(ii)=H;%pulse voltage
    else;
        pv(ii)=L;
    end;
end ;
po=pv;%pulse out=pulse voltage
%figure(4)
%plot(t,po);
axis([-1e-9 11e-9 -1 6])
title('Comparator output');
xlabel('Frequency');
ylabel('Voltage');
grid on;
%===================================================
%SETUP and INFO
%===================================================
%Enter desired pulse width in pw1(.5e-9).
%Change t=-1e-9:1/Fs:(xxxx) to 1e-9.
%Press F5 or run.
%With waveform in plot 2,2,1, set pulse width with fudge factor to .5e-9
%using #s corresponding to chosen waveform. Set from tail to tail.
%Change t=-1e-9:1/Fs:(xxx) to something like 20e-9.Zoom out.
%Press F5 and observe waveforms. Print waveforms to compare with next set of
%wave forms.
%Pick another waveform by commenting out existing waveform and repeat as above.
%When comparing the waveforms we see that the second derivative
%doublet has a center frequency in the spread twice that of the first
%derivative monocycle.
%This is expected on a second derivative. Picking a doublet waveform
%for transmission (by choice of UWB antenna design) pushes the fc center frequency 
%spread out by (two) allowing relief from the difficult design of narrower pulse
%generating circuits in transmitters and receivers. If a monocycle is choosen, we would
%need to design our pulse circuits with a much narrower(factor of two)pulse width to
%meet the tough FCC spectral mask from ~3 to 10GHz at-40Dbm. A
%pulse width of ~ 0.4 to 0.45 nanosec using a doublet at the proper amplitude(A) 
%could meet the requirements. The antenna choice at the receiver could
%integrate the doublet to a monocycle so a wave form for the modulated
%monocycle is included. Also an unmodulated monocycle template could correlate with a
%modulated doublet extracting the information but the proper sense of the
%monocycle would be required along with proper information delay setup in
%the equations.
 
%Users can zoom in on the waveforms of plot 2,2,1 to see the PPM
%delays generating 10101. Use axis on plot 2,,2,1 for better
%zooming.Comment in the axis.
%Processing gains of greater than 20DB can be achieved by selection of the
%PRF and integrator using high information bit rates. This, when doing a 
%link budget, should give enough link margin for multipath conditions with
%a fixed transmitter power at ranges of 3 to 10 meters.
%I didn't include BER checking with noise in the program because I beleive many more
%pulses would be required to get the true picture.
%Perfect sync is assumed in the correlation receiver. You could delay the
%unmodulated doublet waveform and check the correlation properties of the 
%waveforms at the receiver and observe how the S/N(or output signal since no noise has been
%added to the program) degrades when not in perfect sync.
%Potential Things that could be added:
%A.more pulses
%B.integrator
%C.noise
%D.BER