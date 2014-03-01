%Tonic Pitch Identifier
%This will be the last note performed and will be represented as DO

%Will received a processed musical vector, ie, one that has removed
%repeated pitch values. >>> ProcTune
%tonicPitch is the final note which will be treated as DO in additional
%functions; it will be the index into PitchFreq Structure
function tonicPitch=TonicID(ProcTune)

%To start at the end of the vector, first find out the length of the
%ProcTuen vector
lenProcTune=length(ProcTune);
if ProcTune(lenProcTune)~=109
    tonicPitch=ProcTune(lenProcTune);
else
    counter=1;
    while ProcTune(lenProcTune-counter)==109
        counter=counter+1;
    end
    tonicPitch=ProcTune(lenProcTune-counter);
end
end