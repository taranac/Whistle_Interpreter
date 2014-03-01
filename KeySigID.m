%Identifies the Key Signature based on the Tonic
function [keySig,keyType]=KeySigID(tonicPitch)

%keyImg >> add this output in order to show an image in the GUI


%neutralTonic is used for the switch statement; 12 is subtracted to remove
%the octave but maintain the note

neutralTonic=tonicPitch;
while neutralTonic>12
    neutralTonic=neutralTonic-12;
end

switch neutralTonic
    case 1
        keySig='C Major';
        keyType='Sharp';
    case 2
        keySig='D Flat Major';
        keyType='Flat';
    case 3
        keySig='D Major';
        keyType='Sharp';
    case 4
        keySig='E Flat Major';
        keyType='Flat';
    case 5
        keySig='E Major';
        keyType='Sharp';
    case 6
        keySig='F Major';
        keyType='Flat';
    case 7
        keySig='F Sharp Major';
        keyType='Sharp';
    case 8
        keySig='G Major';
        keyType='Sharp';
    case 9
        keySig='A Flat Major';
        keyType='Flat';
    case 10
        keySig='A Major';
        keyType='Sharp';
    case 11
        keySig='B Flat Major';
        keyType='Flat';
    case 12
        keySig='B Major';
        keyType='Sharp';
end
end