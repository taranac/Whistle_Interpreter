close all
clear all
dur=input('How long do you want to record?')
sr = 44100; % Hz
soundcard = audiorecorder(sr,16,1);
disp('Start Speaking');
recordblocking(soundcard,dur);
disp('Stop Speaking');
signal = getaudiodata(soundcard);
sound(signal,sr);
nsamp = numel(signal);
sampidx = 1:1:nsamp;
time = sampidx/sr;
figure
plot(time, signal)
xlabel('time');
ylabel('signal');
title('Lab 4.2')
clear all
close all
[signal,sr]=wavread('peaks.wav');
nsamp=sr;
sampidx=1:nsamp;
time=sampidx/sr;
figure
[amp, freq]=spectrum(signal, sr);
plot(freq,amp);
ylabel('Amplitude');
xlabel('Frequency');
xlim([0 1000]);
title('Mystery Signal Spectrum');
nspec=numel(amp);
tf=false(1,nspec);
threshold=.015;
for i=2:nspec-1
    if amp(i)>amp(i-1) && amp(i)>amp(i+1) && amp(i)>threshold
        tf(i)=true;
    end
end
ind=find(tf);
disp('Frequencies of Interest');
freq(ind)
hold on
plot(freq(ind),amp(ind),'ro');
hold off
freqbase=[16.35 17.32 18.35 19.45 20.6 21.83 23.12 24.5 25.96 27.5 29.14 30.87];