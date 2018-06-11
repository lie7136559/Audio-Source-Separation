clear
clc
close all
[Original,fs]=audioread('Rolling in the Deep.wav');
ts=1/fs;                            
N=length(Original)-1;    
t=0:1/fs:N/fs;                
Nfft=N;
df=fs/Nfft;  
 
taa=(1:length(Original))/fs;
 
plot(taa,Original);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Original Song')
xlim([0,35]);
figure
plot(abs(fftshift(fft(Original,fs))));
title(' Original Spectrum');
xlabel('Original Song Frequency');
ylabel('Amplitude');
 
fk=(-Nfft/2:Nfft/2-1)*df;
 
a1=1;
a2=-1;
b1=1;
b2=-1;
 
SoundLeft=Original(:,1);
SoundRight=Original(:,2);
SoundLeft_f=ts*fftshift(fft(SoundLeft,N));
SoundRight_f=ts*fftshift(fft(SoundRight,N));  
 
%figure(1)
%subplot(411)
%plot(t,SoundLeft);
%subplot(412)
%plot(t,SoundRight);
%subplot(413)
%f_range=[-3000,3000,0,0.06];
%plot(fk,SoundLeft_f);
%axis(f_range);
%subplot(414)
%plot(fk,SoundRight_f);
%axis(f_range);
 
%Sound=SoundLeft-SoundRight;
 
 
NewLeft=a1*SoundLeft+a2*SoundRight;
NewRight=b1*SoundLeft+b2*SoundRight;
 
Sound(:,1)=NewLeft;
Sound(:,2)=NewRight;
Sound_Left_f=ts*fftshift(fft(NewLeft,N));
Sound_Right_f=ts*fftshift(fft(NewRight,N));
 
%figure
%plot(t,NewLeft);
%figure
%plot(t,NewRight);
%f_range=[-3000,3000,0,0.06];
%figure
%plot(fk,Sound_Left_f);
%title('Frequency of Left Channel')
%axis(f_range);
%figure
%plot(fk,Sound_Right_f);
%title('Frequency of Right Channel')
%axis(f_range);
 
 
BP=fir1(300,[500,2000]/(fs/2));    
CutDown=filter(BP,1,Sound);     
Sound_Final=Sound-0.6*abs(CutDown);
Sound_Final_f=ts*fftshift(fft(Sound_Final,N));
 
figure
plot(taa,Sound_Final);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Final Sound')
xlim([0,35]);
figure
plot(abs(fftshift(fft(Sound_Final,fs))));
title('Final Sound');
xlabel('Frequency');
ylabel('Amplitude');
 
 
 
audiowrite('finalvoice.wav',Sound_Final,fs);
