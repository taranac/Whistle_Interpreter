function [PitchFreq]=PitchStruct()
%Script to create a library of pitches in a structure
%This structure is named 'PitchFreq'

%Structure has the following fields:
%   'Index' is the number assigned to each pitch
%   'Sharp' which is the note name in sharp keys
%   'Flat' which is the note name in flat keys
%   'Oct' which octave the note is in
%   'Freq' which is the frequency of the pitch in Hertz
%   'Min' which is the minimum acceptable frequency associated with the
%   pitch; This attributes for error in pitch accuracy up to 2^octave/4 below the desired pitch,
%   thus accepting 25% error
%   'Max' is the maximum acceptable frequency associated with the pitch;
%   This attributes for error in pitch accuracy up to 2^octave/4 above the
%  intended pitch, thus accepting 50% error

%To initialize the structure and allocate memory
PitchFreq(108).Index=108;
PitchFreq(108).Sharp='B';
PitchFreq(108).Flat='B';
PitchFreq(108).Oct=8;
PitchFreq(108).Freq=7902;
PitchFreq(108).Min=PitchFreq(108).Freq-(PitchFreq(108).Oct)^2/2;
PitchFreq(108).Max=PitchFreq(108).Freq+(PitchFreq(108).Oct)^2/2;

%The names in frequencies in octave0 starting from C and ending on B
PitchFreq(1).Sharp='C';
PitchFreq(1).Flat='C';
PitchFreq(1).Oct=0;
PitchFreq(1).Freq=16.3515;

PitchFreq(2).Sharp='C Sharp';
PitchFreq(2).Flat='D Flat';
PitchFreq(2).Oct=0;
PitchFreq(2).Freq=17.324;

PitchFreq(3).Sharp='D';
PitchFreq(3).Flat='D';
PitchFreq(3).Oct=0;
PitchFreq(3).Freq=18.354;

PitchFreq(4).Sharp='D Sharp';
PitchFreq(4).Flat='E Flat';
PitchFreq(4).Oct=0;
PitchFreq(4).Freq=19.4455;

PitchFreq(5).Sharp='E';
PitchFreq(5).Flat='E';
PitchFreq(5).Oct=0;
PitchFreq(5).Freq=20.6015;

PitchFreq(6).Sharp='F';
PitchFreq(6).Flat='F';
PitchFreq(6).Oct=0;
PitchFreq(6).Freq=21.827;

PitchFreq(7).Sharp='F Sharp';
PitchFreq(7).Flat='G Flat';
PitchFreq(7).Oct=0;
PitchFreq(7).Freq=23.1245;

PitchFreq(8).Sharp='G';
PitchFreq(8).Flat='G';
PitchFreq(8).Oct=0;
PitchFreq(8).Freq=24.4995;

PitchFreq(9).Sharp='G Sharp';
PitchFreq(9).Flat='A Flat';
PitchFreq(9).Oct=0;
PitchFreq(9).Freq=25.9565;

PitchFreq(10).Sharp='A';
PitchFreq(10).Flat='A';
PitchFreq(10).Oct=0;
PitchFreq(10).Freq=27.50;

PitchFreq(11).Sharp='A Sharp';
PitchFreq(11).Flat='B Flat';
PitchFreq(11).Oct=0;
PitchFreq(11).Freq=29.135;

PitchFreq(12).Sharp='B';
PitchFreq(12).Flat='B';
PitchFreq(12).Oct=0;
PitchFreq(12).Freq=30.858;

%calculates the minimum and maximum pitch error for each pitch in the first
%octave
for pitch=1:12
    Freq=PitchFreq(pitch).Freq;
    Min=Freq-(1/4);
    Max=Freq+(1/4);
    PitchFreq(pitch).Min=Min;
    PitchFreq(pitch).Max=Max;  
end

%Loops through to create the other 8 octaves of pitches
%establishes each value for the 6 fields associated with each pitch
for oct=1:8
for pitch=1:12
    PitchFreq(12*oct+pitch).Sharp=PitchFreq(pitch).Sharp;
    PitchFreq(12*oct+pitch).Flat=PitchFreq(pitch).Flat;
    PitchFreq(12*oct+pitch).Oct=oct;
    Freq=(PitchFreq(pitch).Freq)*2^oct;
    PitchFreq(12*oct+pitch).Freq=Freq;
end
end

%assigns appropriate index
for i=1:108
    PitchFreq(i).Index=i;
end

PitchFreq(1).Min=15.5;
PitchFreq(1).Max=17.074;

for pitch=2:107
    Freq=PitchFreq(pitch).Freq;
    LowFreq=PitchFreq(pitch-1).Freq;
    HighFreq=PitchFreq(pitch+1).Freq;
    PitchFreq(pitch).Min=Freq-(Freq-LowFreq)/2;
    PitchFreq(pitch).Max=Freq-(Freq-HighFreq)/2;
end


%Establishing values for RESTing, which is at index 109
PitchFreq(109).Index=109;
PitchFreq(109).Sharp='Rest';
PitchFreq(109).Flat='Rest';
PitchFreq(109).Oct='None';
PitchFreq(109).Freq=0;
PitchFreq(109).Min=0;
PitchFreq(109).Max=0;


end