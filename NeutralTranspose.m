%Transpose Function
%Takes a vector of musical note indexes and moves it to a musical key
%The final pitch performed will be DO which will equal 0
%Pitches will be compared relative to this pitch in order to compare it to
%known musical bits also in a neutral key
%DO1=0
%RE1=3
%MI1=5
%FA1=6
%SO1=8
%LA1=10
%TI1=12
%DO2=13


function neutralTune=NeutralTranspose(tonicPitch,ProcTune)
%Output: neutralTune is the stepwise tune relative to the Tonic, DO, which
%equals zero. Each integer step is a musical half step; every two integer
%steps sums to a musical whole step

%Input: tonicPitch is DO for the particular tune performed
%ProcTune is the processed tune (without repeated pitches)
neutralTune=ProcTune-tonicPitch;
end