clear all, close all
dur=input('How long do you want to sample for? ');
sr=44100;
[whistleSignal,time] = recordsignal(dur,sr);
sound(whistleSignal,sr)
[amp, freq]=spectrum(whistleSignal,sr);
figure
plot(freq,amp)
xlabel('frequency')
ylabel('amplitude')
xlim([0 800])
ylim([0 0.1])
nspec=numel(freq);
threshold=0.01;

tf=false(1,nspec);
if amp(1)>amp(2) && amp(1)>threshold
    tf(1)=1;
end
for i=1:nspec-2
   if amp(i+1)>amp(i) && amp(i+1)>amp(i+2) && amp(i+1)>threshold
       tf(i+1)=1;
   end
end
ind = find(tf);
disp('Frequencies of Interest');
freq(ind)
hold on % retain current graph in current figure
plot(freq(ind),amp(ind),'ro'); % overlay local maxima with red (?r?) circles (?o?)
hold off
%sample comparison just for spectrum function. 
C=261.63; %soon to be the structure containing everything we dream of
if freq(ind)<(261.63+.2*261.63)&& freq(ind)>(261.63-.2*261.63)
    disp('C4')
end
%loop comparison in relation to structure
%Now for a comparison based over time...
%We have a time vector, so first find the elements where the amplitude...
%of the signal is more prominent than its harmonics... aka perhaps greater
%than .03?? And then reference these elements into the time vector to
%obtain/extract the time intervals where these prominent signals occurred.
%reference these times into the frequency vector (we'd have to get rid of
%the extraneous data(harmonics frequencies). perhaps run a while loop
%within a for loop (while the frequency at this time is about the same
%(within 5%) of the frequency of the time before and that of the time
%after... store that data into a matrix row by row. average the rows.
%compare to the structure. print the notes in chronological order.

