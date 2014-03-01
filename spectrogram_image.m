function [amp,F,T] = spectrogram_image(t,s,window,type)
% display signal spectrogram as image: display the amplitude spectrogram
% of the signal "s" aquired at times "t". If FFT windowing is
% desired, users may enter a "window" vector

    % check for appropriate time
    if isempty(t) || ~isnumeric(t) || ~all(isfinite(t(:))) || ...
       ndims(t)~=2 || ~any(size(t)==1) 
        error(sprintf('%s:invalidTime',mfilename),...
            'The input "t" must be a vector of finite values.');
    end  

    % signal length
    L = numel(t);
    
    % check for appropriate signal
    if isempty(s) || ~isnumeric(s) || ~all(isfinite(s(:))) || ...
       ndims(s)~=2 || ~any(size(s)==1) || numel(t)~=L
        error(sprintf('%s:invalidSignal',mfilename),...
            ['The input "s" must be a vector of finite values.',...
             'of the same length as the input "t"']);
    end       
    
    % sampling frequency
    dt = diff(t);
    if ~all(dt>0) || any(abs(dt-dt(1))>1e-8)
        error(sprintf('%s:invalidTime',mfilename),...
            'The sampling frequency is not consistent.');
    end
    Fs = 1/mean(dt);
    
    % check for appropriate window
    if ~isnumeric(window) || ~all(isfinite(window(:))) || ...
       ndims(window)~=2 || ~any(size(window)==1) 
       error(sprintf('%s:invalidWindow',mfilename),...
            ['The input "window" must be a scalar or a ',...
             'vector of finite values.']);
         
    elseif isscalar(window)
        if window<=0 || mod(window,1)~=0
            error(sprintf('%s:invalidWindow',mfilename),...
                'Scalar "window" must be a positive integer');
        end
        window = ones(1,window);
    end
    
    % check for display type
    if nargin<4 || isempty(type)
        type = 'amp';
    elseif ~ischar(type) || ~any(strcmpi(type,{'amp','dB','none'}))
        error(sprintf('%s:invalidDisplayType',mfilename),...
            'Input "type" expects [''amp''|''dB''|''none''].');
    end
    
    
    % spectrogram via builtin function
    [S,F,T] = spectrogram(s,window,0,[],Fs);
    
    % single-sided amplitude spectrum
    amp = abs(S/sum(window));
    amp(2:end-1) = 2*amp(2:end-1);    
    
    
    % display
    if ~strcmpi(type,'none')
               
        % display image & range
        if strcmpi(type,'amp')
            im = amp;
            clim = [0 max(im(:))];
            lbl = 'Amplitude';
        else
            im = 20*log10(amp);
            tf = isfinite(im);
            clim = [min(im(tf)) max(im(tf))];
            lbl = 'dB Amplitude';
        end
                
        % axes handle
        haxs = gca;

        % create image
        image(...
            'parent',haxs,...
            'cdata',im,...
            'cdatamapping','scaled',...
            'xdata',T([1 end])+t(1),...
            'ydata',F([1 end]));

        % adjust axes
        set(gca,...
            'xlim',t([1 end]),...
            'ylim',[0 Fs/2],...
            'clim',clim,...
            'layer','top',...
            'box','on');

        % create colorbar
        hcbar = colorbar('peer',haxs);
        hylbl = ylabel(hcbar,lbl);
        set(hylbl,'rotation',-90,...
            'verticalalignment','bottom');
    end