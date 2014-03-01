%Creating the comparison for it
%Use a structure with different vector lengths

%Source for songs: http://www.stonewallbrigadeband.com/UnisonSongsTrumpet.pdf


%structure is named SongLibrary
%Fields:
%   Name >> The name of the song (A string)
%   PrimTune >> A vector which can be compared to neutralTune
function TuneLibrary=SongLibrary()

TuneLibrary(1).Name='Hot Crossed Buns';
TuneLibrary(1).PrimTune=[4 2 0 4 2 0 0 0 0 0 2 2 2 2 4 2 0];
TuneLibrary(1).Composer='Traditional';

TuneLibrary(2).Name='Lightly Row';
TuneLibrary(2).PrimTune=[7 4 4 5 2 2 0 2 4 5 7 7 7 7 4 4 5 2 2 0 4 7 7 0 2 2 2 2 2 4 5 4 4 4 4 4 5 7 7 4 4 5 2 2 0 4 7 7 0];
TuneLibrary(2).Composer='Traditional';


TuneLibrary(3).Name='Mary Had a Little Lamb';
TuneLibrary(3).PrimTune=[4 2 0 2 4 4 4 2 2 2 4 7 7 4 2 0 2 4 4 4 2 2 4 2 0];
TuneLibrary(3).Composer='Traditional';

TuneLibrary(4).Name='Jingle Bells';
TuneLibrary(4).PrimTune=[4 4 4 4 4 4 4 4 7 0 2 4 5 5 5 5 5 4 4 4 4 2 2 4 2 7 4 4 4 4 4 4 4 7 0 2 4 5 5 5 5 5 4 4 4 7 7 5 2 0]; 
TuneLibrary(4).Composer='James Pierpont';


TuneLibrary(5).Name='Yankee Doodle';
TuneLibrary(5).PrimTune=[0 0 2 4 0 4 2 -5 0 0 2 4 0 -5 0 0 2 4 5 4 2 0 -1 -5 -3 -1 0 0];
TuneLibrary(5).Composer='Traditional';


TuneLibrary(6).Name='Old MacDonald Had a Farm';
TuneLibrary(6).PrimTune=[0 0 0 -5 -3 -3 -5 4 4 2 2 0 -5 0 0 0 -5 -3 -3 -5 4 4 2 2 0 -5 0 0 0 -5 0 0 0 -5 0 -5 0 -5 0 -5 0 0 0 0 0 -5 -3 -3 -5 4 4 2 2 0];
TuneLibrary(6).Composer='Traditional';


TuneLibrary(7).Name='London Bridges';
TuneLibrary(7).PrimTune=[7 8 7 5 4 5  7 2 4 5 4 5 7 7 8 7 5 4 7 2 7 4 0];
TuneLibrary(7).Composer='Traditional';

TuneLibrary(8).Name='Twinkle Twinkle Little Star';
TuneLibrary(8).PrimTune=[0 0 7 7 8 8 7 5 5 4 4 2 2 0 7 7 5 5 4 4 2 7 7 5 5 4 4 2 0 0 7 7 8 8 7 5 5 4 4 2 2 0];
TuneLibrary(8).Composer='Wolfgang Amadeus Mozart';

TuneLibrary(9).Name='Good Night Ladies';
TuneLibrary(9).PrimTune=[4 0 -5 0 4 0 2 2 4 0 5 5 5 4 4 2 2 0];
TuneLibrary(9).Composer='Traditional';

TuneLibrary(10).Name='Pop Goes the Weasel';
TuneLibrary(10).PrimTune=[0 0 2 2 4 7 2 0 -5 0  0 2 2 4 0 -5 0 0 2 2 4 7 4 0 -3 2 5 4 0];
TuneLibrary(10).Composer='Traditional';

TuneLibrary(11).Name='The Farmer in the Dell';
TuneLibrary(11).PrimTune=[-5 0 0 0 0 0 2 4 4 4 4 4 7 7 8 7 4 0 2 4 4 2 2 0];
TuneLibrary(11).Composer='Traditional';

TuneLibrary(12).Name='Oh Where, Oh Where has my Little Dog Gone';
TuneLibrary(12).PrimTune=[4 7 4 0 -1 0 2 -1 -5 7 8 7 5 4 2 7 4 5 7 4 0 -1 0 4 -1 -5 7 8 7 5 4 2 0];
TuneLibrary(12).Composer='James Bland';


end


    