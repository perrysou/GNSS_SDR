function probeData(varargin)
%Function plots raw data information: time domain plot, a frequency domain
%plot and a histogram. 
%
%The function can be called in two ways:
%   probeData(settings)
% or
%   probeData(fileName, settings)
%
%   Inputs:
%       fileName        - name of the data file. File name is read from
%                       settings if parameter fileName is not provided.
%
%       settings        - receiver settings. Type of data file, sampling
%                       frequency and the default filename are specified
%                       here. 

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Copyright (C) Dennis M. Akos
% Written by Darius Plausinaitis and Dennis M. Akos
%--------------------------------------------------------------------------
%This program is free software; you can redistribute it and/or
%modify it under the terms of the GNU General Public License
%as published by the Free Software Foundation; either version 2
%of the License, or (at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program; if not, write to the Free Software
%Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
%USA.
%--------------------------------------------------------------------------

% CVS record:
% $Id: probeData.m,v 1.1.2.7 2006/08/22 13:46:00 dpl Exp $

%% Check the number of arguments ==========================================
if (nargin == 1)
    settings = deal(varargin{1});
    fileNameStr = settings.fileName;
elseif (nargin == 2)
    [fileNameStr, settings] = deal(varargin{1:2});
    if ~ischar(fileNameStr)
        error('File name must be a string');
    end
else
    error('Incorect number of arguments');
end
    
%% Generate plot of raw data ==============================================
[fid, message] = fopen(fileNameStr, 'rb');

if (fid > 0)
    % Move the starting point of processing. Can be used to start the
    % signal processing at any point in the data record (e.g. for long
    % records).
    fseek(fid, settings.skipNumberOfBytes, 'bof');    
    
    % Find number of samples per spreading code
    samplesPerCode = round(settings.samplingFreq / ...
                           (settings.codeFreqBasis / settings.codeLength));
                      
    % Read 10ms of signal
    [data, count] = fread(fid, [1, 10*samplesPerCode], settings.dataType);
    
    fclose(fid);
    
    if (count < 10*samplesPerCode)
        % The file is to short
        error('Could not read enough data from the data file.');
    end
    
    %--- Initialization ---------------------------------------------------
    figure(100);
    clf(100);
    
    timeScale = 0 : 1/settings.samplingFreq : 5e-3;    
    
    %--- Time domain plot -------------------------------------------------
    subplot(2, 2, 1);
    plot(1000 * timeScale(1:round(samplesPerCode/50)), ...
         data(1:round(samplesPerCode/50)));
     
    axis tight;
    grid on;
    title ('Time domain plot');
    xlabel('Time (ms)'); ylabel('Amplitude');
    
    %--- Frequency domain plot --------------------------------------------
    subplot(2,2,2);
    pwelch(data-mean(data), 16384, 1024, 2048, settings.samplingFreq/1e6)
    
    axis tight;
    grid on;
    title ('Frequency domain plot');
    xlabel('Frequency (MHz)'); ylabel('Magnitude');
    
    %--- Histogram --------------------------------------------------------
    subplot(2, 2, 3.5);
    hist(data, -128:128)
    
    dmax = max(abs(data)) + 1;
    axis tight;
    adata = axis;
    axis([-dmax dmax adata(3) adata(4)]);
    grid on;
    title ('Histogram'); 
    xlabel('Bin'); ylabel('Number in bin');
else
    %=== Error while opening the data file ================================
    error('Unable to read file %s: %s.', fileNameStr, message);
end % if (fid > 0)
