function varargout = untitled(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for untitled
handles.output = hObject;

handles.fs = 44100;
handles.recordobject = audiorecorder(handles.fs,16,1);

% Update handles structure
guidata(hObject,handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.keybox,'Visible', 'off' )
set(handles.songbox,'Visible', 'off')
set(handles.snamebox,'Visible', 'off' )
set(handles.combox2,'Visible', 'off')
set(handles.combox,'Visible', 'off')
set(handles.yesb,'Visible', 'off' )
set(handles.nob,'Visible', 'off')
set(handles.saveq,'Visible', 'off')

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')==1
    set(hObject,'String', 'Get Ready')
    pause(2)
    set(hObject,'String', 'Stop Recording')
    tic
    record(handles.recordobject);
else 
    stop(handles.recordobject)
    T=toc;
    set(hObject,'String', 'Record')
    signal = getaudiodata(handles.recordobject);
    sound(signal,handles.fs)
    dur=round(T);
    sr=44100;

    %number of samples in recording
    nsamp = numel(signal);
    %sample #...
    sampidx = 1:1:nsamp;
    %samples divided by samples/time gets time
    time = sampidx/sr;
    chunk_dur=0.2;
    chunk_nsamp=chunk_dur*sr;
    %call spectrogram_image functino to get a frequency(column
    %vector) and T time elements/chunks based on chunk duration (row vector)

    [amp, freq, T]=spectrogram_image(time,signal,chunk_nsamp,'none');
    %amp gives a matrix with dimensions length(T) by length(freq)
    %freq gives a column vector of frequencies
    %T gives a row vector of time chunks

    %Running PitchStruct to create the library within this script
    [PitchFreq]=PitchStruct();
ishandle(handles.figure1)
drawnow,pause(1)
    %preallocate maxamp row vector T elements long. stores index of max
    %amplitudes used to find corresponding frequency (in order to get the
    %frequencies we care about)
    maxampind=zeros(1,length(T));
    %locates the actual values of the maximum amplitudes at each time chunk
    maxampmag=zeros(1,length(T));
    lfreq=zeros(1,length(T));


    %for loop isolates maximum amplitudes at each time and where that happens.
    %index into frequency vector to isolate important frequencies at these time
    %intervals.
    for i=1:length(T)
       [maxampmag(i),maxampind(i)]=max(amp(:,i));
       lfreq(i)=freq(maxampind(i));
    end
    %isolates real maximum aplitude of speech signal
    rmax=max(maxampmag);
    %Will replace all irrelevant amplitudes with 0
    for i=1:length(T)-2
       if maxampmag(i)<.05*rmax
           maxampmag(i)=0;
       end
       if maxampmag(i)==0 && maxampmag(i+2)==0
           maxampmag(i+1)=0;
       end
    end
    maxampmag(1)=0;

    %Will use an index vector to find zeros in maxampmag then set corresponding
    %freqencies in pfreq to be 0.
    zind=find(maxampmag==0);
    lfreq(zind)=0;

    %where does lfreq fit into our structure?
    %preallocate perfect frequencies
    pfreq=zeros(1,length(T));

    %pfreqind indices of the significant frequency vector
    pfreqind=zeros(1,length(T));

    %finds significant frequency by comparing it to the min and max values in
    %our structure
    for i=1:length(T)
        counter=0;
        while pfreq(i)==0 && counter<numel(PitchFreq)
            counter=counter+1;
            if lfreq(i)==0
                pfreqind(i)=109; 
            elseif lfreq(i)>PitchFreq(counter).Min && lfreq(i)<PitchFreq(counter).Max
                pfreq(i)=PitchFreq(counter).Freq;
                pfreqind(i)=counter; 
            end

        end
    end

    %Removing repetitive notes played consecutively
    tf=false;
    for i=1:length(pfreqind)-1
        if abs(pfreqind(i)-pfreqind(i+1))<=1
            tf(i)=1;

        end
    end
    repind=find(tf==1);
    pfreqind(repind)=[];
    ProcTune=pfreqind;
    save('neutralTune.mat','neutralTune')


    % indentifying the notes using the structure, determine if flat or sharp 
    tonicPitch=TonicID(ProcTune);
    [keySig,keyType]=KeySigID(tonicPitch);
    neutralTune=NeutralTranspose(tonicPitch,ProcTune);
    noteNames=IndToNotes(PitchFreq, ProcTune,keySig,keyType);
buf=sprintf('%s, ', noteNames{:});
    handles.notes=buf;
get(handles.figure1)
 guidata(handles.figure1,handles);
set(handles.hnotetext,'String', handles.notes)  

buf2=sprintf('Key Signature: %s ', keySig);
    handles.key=buf2;
   guidata(handles.figure1,handles);

set(handles.keybox,'String', handles.key)
set(handles.keybox,'Visible', 'on')

%Matching Song with the songs in the library
TuneLibrary=SongLibrary();
[SongName,SongInd]=SongMatch(neutralTune,TuneLibrary);

buf3=sprintf('Song Name: %s ', SongName);
    handles.song=buf3;
   guidata(handles.figure1,handles);

set(handles.songbox,'String', handles.song)
set(handles.songbox,'Visible', 'on')

   
end

 set(handles.yesb,'Visible', 'on' )
    set(handles.nob,'Visible', 'on')
   set(handles.saveq,'Visible', 'on')


% --- Executes on button press in nob.

%sets visibility of yesb and nob off
function nob_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==1
    set(handles.yesb,'Visible', 'off' )
    set(handles.nob,'Visible', 'off')
    set(handles.saveq,'Visible', 'off')
    set(handles.snamebox,'Visible', 'off' )
    set(handles.combox2,'Visible', 'off')
    set(handles.combox,'Visible', 'off')
else
    set(handles.yesb,'Visible', 'off' )
    set(handles.nob,'Visible', 'off')
    set(handles.saveq,'Visible', 'off')
    set(handles.snamebox,'Visible', 'off' )
    set(handles.combox2,'Visible', 'off')
    set(handles.combox,'Visible', 'off')
end
    
    



% --- Executes on button press in yesb.
function yesb_Callback(hObject, eventdata, handles)
% hObject    handle to yesb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yesb
if get(hObject,'Value')==1
    set(hObject,'String', 'Save')
    set(handles.snamebox,'Visible', 'on' )
    set(handles.combox2,'Visible', 'on')
    set(handles.combox,'Visible', 'on')
else
    set(handles.snamebox,'Visible', 'off' )
    set(handles.combox2,'Visible', 'off')
    set(handles.combox,'Visible', 'off')
    set(handles.yesb,'Visible', 'off' )
    set(handles.nob,'Visible', 'off')
    set(handles.saveq,'Visible', 'off')
    editsong=get(handles.snamebox,'String');
    editcomp=get(handles.combox2,'String');
    load('neutralTune.mat')
    load('TuneLibrary.mat')
        TuneLibrary(length(TuneLibrary)+1).Name=editsong;
        TuneLibrary(length(TuneLibrary)+1).Composer=editcomp;
        TuneLibrary(length(TuneLibrary)+1).PrimTune=neutralTune;
        save('TuneLibrary.mat','TuneLibrary')
    end
   
    
