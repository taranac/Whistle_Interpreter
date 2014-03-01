%Returns the Note names for the pitches performed from the ProcTune

function noteNames=IndToNotes(PitchFreq, ProcTune,keySig,keyType)
%Inputs:
%PitchFreq>> The structure to pull information from
%ProcTune>> The processed song excerpt
%keySig>> The key signature of the tune (based on knowledge of the tonic)
%keyType>> Which structure to pull from

lenProcTune=length(ProcTune);

%Preallocates the cell array noteNames
noteNames=cell(1,lenProcTune);
for i=1:lenProcTune
    if strcmp(keyType, 'Sharp')
        noteNames{i}=PitchFreq(ProcTune(i)).Sharp;
    elseif strcmp(keyType, 'Flat')
        noteNames{i}=PitchFreq(ProcTune(i)).Flat;
end
end
    