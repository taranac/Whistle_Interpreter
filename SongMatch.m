function [SongName,SongInd]=SongMatch(neutralTune,TuneLibrary)

%Stores the length of the SongLibrary
lenSL=length(TuneLibrary);

%Initializes variable SongName (will maintain current string if the song is
%not in the library)
SongName='Song Not Recognized';

%Initializes variable SongInd
SongInd=0;

%initializes counter to be used in the while loop
counter=1;


%Loop continues until SongName changes (assigned a different value) or
%until the value of the counter exceeds the length of SongLibrary
while strcmp(SongName,'Song Not Recognized') && counter<=lenSL
%     if length(neutralTune)-length(SongLibrary(counter).PrimTune)==0
        if isequal(TuneLibrary(counter).PrimTune,neutralTune);
            SongName=TuneLibrary(counter).Name;
            SongInd=counter;
%         end
        end
    counter=counter+1;
end
end