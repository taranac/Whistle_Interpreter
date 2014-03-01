close all
clear all
%let user choose whether to create own melody or to compare to our database
choice=input('Press 1 if you want to create a melody or 2 if you want to identify a song:  ');% Later change this to push or radio buttons for GUI

%This error check not working 
while choice~=1 && choice~=2
    choice=input('Error, Please press 1 you want to create a melody or 2 if you want to identify a song:  ');
end
%establish duration for recording time ("dur")
dur=input('How long do you want to record?  ');
sr = 44100; % sampling rate. #samples/second
%"soundcard" stores the recording
soundcard = audiorecorder(sr,16,1);
disp('Start Singing');
%stop recording after "dur" seconds
recordblocking(soundcard,dur);
disp('Stop Singing');
%extract data from soundcard (signal)
signal = getaudiodata(soundcard);
%play back sound so user can listen to what just happened
sound(signal,sr);
%number of samples in recording
nsamp = numel(signal);
%sample #...
sampidx = 1:1:nsamp;
%samples divided by samples/time gets time
time = sampidx/sr;

% if choice==1
%     %direct to function to musical note structure
% end

% if choice==2
%     disp('You must sing the entire song')% If we are letting them pick how long then how can they sing the entire song?
%     
%     %direct to function to in music library
% end

% [amp, freq]=spectrum(signal, sr);
% nspec=numel(amp);
% tf=false(1,nspec);
% threshold=.015;
% 
% for i=2:nspec-1
%     if amp(i)>amp(i-1) && amp(i)>amp(i+1) && amp(i)>threshold
%         tf(i)=true;
%     end
% end
% 
% ind=find(tf);
% disp('Frequencies of Interest');
% freq(ind)
% hold on
% plot(freq(ind),amp(ind),'ro');
% hold off
chunk_dur=0.05;
chunk_nsamp=chunk_dur*sr;
%call spectrogram_image functino to get a frequency(column
%vector) and T time elements/chunks based on chunk duration (row vector)
[amp, freq, T]=spectrogram_image(time,signal,chunk_nsamp);
%amp gives a matrix with dimensions length(T) by length(freq)
%freq gives a column vector of frequencies
%T gives a row vector of time chunks

%Running PitchStruct to create the library within this script
[PitchFreq]=PitchStruct();

%preallocate maxamp row vector T elements long. stores index of max
%amplitudes used to find corresponding frequency (in order to get the
%frequencies we care about)
maxampind=zeros(1,length(T));
%locates the actual values of the maximum amplitudes at each time chunk
maxampmag=zeros(1,length(T));
lfreq=zeros(1,length(T));


%for loop isolates maximum amplitudes at each time and where that happens.
%index into frequency vector to isolate important frequencies at these time
%intervals.
for i=1:length(T)
   [maxampmag(i),maxampind(i)]=max(amp(:,i));
   lfreq(i)=freq(maxampind(i));
end
%isolates real maximum aplitude of speech signal
rmax=max(maxampmag);
%Will replace all irrelevant amplitudes with 0
for i=1:length(T)-2
   if maxampmag(i)<.1*rmax
       maxampmag(i)=0;
   end
   if maxampmag(i)==0 && maxampmag(i+2)==0
       maxampmag(i+1)=0;
   end
end
maxampmag(1)=0;

%Will use an index vector to find zeros in maxampmag then set corresponding
%freqencies in pfreq to be 0.
zind=find(maxampmag==0);
lfreq(zind)=0;

%where does lfreq fit into our structure?
%preallocate perfect frequencies
pfreq=zeros(1,length(T));

%pfreqind indices of the significant frequency vector
pfreqind=zeros(1,length(T));

%finds significant frequency by comparing it to the min and max values in
%our structure
for i=1:length(T)
    counter=0;
    while pfreq(i)==0 && counter<numel(PitchFreq)
        counter=counter+1;
        if lfreq(i)==0
            pfreqind(i)=109;
        elseif lfreq(i)>PitchFreq(counter).Min && lfreq(i)<PitchFreq(counter).Max
            pfreq(i)=PitchFreq(counter).Freq;
            pfreqind(i)=counter; 
        end
        
    end
end

%Removing repetitive notes played consecutively
for i=1:length(pfreqind)-1
    if abs(pfreqind(i)-pfreqind(i+1))<=1
        tf(i)=1;
        
    end
end
repind=find(tf==1);
pfreqind(repind)=[];
ProcTune=pfreqind;

% indentifying the notes using the structure, determine if flat or sharp 
tonicPitch=TonicID(ProcTune)
[keySig,keyType]=KeySigID(tonicPitch)
neutralTune=NeutralTranspose(tonicPitch,ProcTune)
noteNames=IndToNotes(PitchFreq, ProcTune,keySig,keyType)




