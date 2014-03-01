function [signal,time] = recordsignal(dur,sr)
% RECORDSIGNAL: record a signal for DUR seconds at FS Hz.
% dur........scalar input, signal duration in seconds
% sr.........scalar input, sampling rate in samples per second
% signal.....vector output, signal values
% time.......vector output, time signal samples were acquired
% ENTER YOUR CODE BETWEEN THE LINES
% Perform some actions based on the inputs DUR and FS

soundcard = audiorecorder(sr,16,1);
disp('Start Speaking');
recordblocking(soundcard,dur);
disp('Stop Speaking');
signal = getaudiodata(soundcard);
nsamp = numel(signal);
sampidx = 1:1:nsamp;
time = sampidx/sr;


end