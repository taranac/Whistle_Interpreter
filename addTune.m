%Function to add "new" songs from the user to TuneLibrary
function [SongName,Composer]=addTune(neutralTune,TuneLibrary)

%Stores the original length of the SongLibrary
lenSL=length(TuneLibrary);

%The index one beyond the current structure where the new song will be
%placed
Index=lenSL+1;

%For the benefit of the workspace
SongName=input('What is the name of this song?','s');

TuneLibrary(Index).Name=SongName;

%Is this information correct?
%If so (YES) then save the information in the structure
%If not (NO) then request input again

%If invalid information is entered


TuneLibrary(Index).PrimTune=neutralTune;

Composer=input('Who composed this song?','s');

TuneLibrary(Index).Composer=Composer;

%Adds the variable to the saved file for future use
save('TuneLibrary.mat','TuneLibrary');
end