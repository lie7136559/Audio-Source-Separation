[y,fs]=audioread('play.wav');
y_=(1:length(y))/fs;
 
figure
plot(y_,y);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Original Track')
figure
plot(abs(fftshift(fft(y,fs))));
title(' Original Spectrum');
xlabel('Frequency');
ylabel('Amplitude');
 
 
N=3;
scale=44100;
Wn1=[140/scale 190/scale];
Wn2=[290/scale 360/scale];
Wn3=[580/scale 710/scale];  
Wn4=[14000/scale 22049/scale]; 
Wn5=[1/scale 11000/scale]; %
Wn6=[5500/scale 5700/scale];
Wn7=[10500/scale 12000/scale];
Wn9=[50/scale 200/scale];
 
[B1,A1] = butter(N,Wn1);
[B2,A2] = butter(N,Wn2);
[B3,A3] = butter(N,Wn3);
[B4,A4] = butter(N,Wn4);
[B5,A5] = butter(N,Wn5);
 
Y1 = filter(B1,A1,y);
Y2 = filter(B2,A2,y);
Y3 = filter(B3,A3,y);
Y4 = filter(B4,A4,y);
Y5 = filter(B5,A5,y);
 
Fs = 44100; 
Fo = 147; 
Q = 1.4;
BW = (Fo/(Fs/2))/Q;  
[b6,a6] = iircomb(round(Fs/Fo),BW,6,'notch');
 
Y6=filter(b6,a6,y);
 
Fo=150; BW = (Fo/(Fs/2))/Q;
[b7,a7] = iircomb(round(Fs/Fo),BW,6,'notch'); 
Y7=filter(b7,a7,Y6);
 
Fo=155; BW = (Fo/(Fs/2))/Q;
[b8,a8] = iircomb(round(Fs/Fo),BW,6,'notch');
Y8=filter(b8,a8,Y7);
 
Fo=160; 
BW = (Fo/(Fs/2))/Q;
[b9,a9] = iircomb(round(Fs/Fo),BW,6,'notch');
Y9=filter(b9,a9,Y8);
Fo=176; 
BW = (Fo/(Fs/2))/Q;
[b10,a10] = iircomb(round(Fs/Fo),BW,6,'notch');
Y10=filter(b10,a10,Y9);
 
 
Y = Y4+Y10;
 
soundsc(Y,fs);
audiowrite('final_drum_track.wav',Y,fs);
y_=(1:length(Y))/fs;
 
figure
plot(y_,Y);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Final Drum Track')
figure
plot(abs(fftshift(fft(Y,fs))));
title('Final Drum Spectrum');
xlabel('Frequency');
ylabel('Amplitude');
 


