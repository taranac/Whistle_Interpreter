function [amp,freq] = spectrum(s,Fs,window)
% signal spectrum: determine the single-sided amplitude spectrum of the
% signal "s" @ sampling frequency "Fs" for display.  If FFT windowing is
% desired, users may enter a "window" vector the same size as "s"


    % check for appropriate signal
    if isempty(s) || ~isnumeric(s) || ~all(isfinite(s(:))) || ...
       ndims(s)~=2 || ~any(size(s)==1)
        error(sprintf('%s:invalidSignal',mfilename),...
            'The input "s" must be a vector of finite values.');
    end

    % signal length & sampling interval
    L = numel(s);

    % check for appropriate sampling frequency
    if isempty(Fs) || ~isnumeric(Fs) || ...
       ~isscalar(Fs) || ~isfinite(Fs) || Fs<=0
        error(sprintf('%s:invalidSamplingFrequency',mfilename),...
            'The input "Fs" must a positive scalar.');
    end
    
    % check window (optional input)
    if nargin<3 || isempty(window)
        window = ones(L,1);
    elseif ~isnumeric(window) || ~all(isfinite(window(:))) || ...
       ndims(window)~=2 || ~any(size(window)==1) || numel(window)~=L
         error(sprintf('%s:invalidWindow',mfilename),...
            ['The input "window" must be a vector of finite values, ',...
             'of the same length as the input "s"']);   
    end
       
    % transform signal/window to column vector
    s = s(:);
    window = window(:);

    % fourier transform
    NFFT = 2^nextpow2(L);
    S = fft(window.*s,NFFT)/sum(window);
    
    % number of unique points in spectrum
    nunq = (NFFT/2)+1;
    
    % single-sided amplitude spectrum
    amp = abs(S(1:nunq));
    amp(2:end-1) = 2*amp(2:end-1);
    
    % frequency vector  
    dF = Fs/NFFT;
    freq = (0:NFFT/2) * dF;
    
end