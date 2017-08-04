function word = checkPhase(word, D30Star)
%Checks the parity of the supplied 30bit word.
%The last parity bit of the previous word is used for the calculation.
%A note on the procedure is supplied by the GPS standard positioning
%service signal specification.
%
%word = checkPhase(word, D30Star)
%
%   Inputs:
%       word        - an array with 30 bit long word from the navigation
%                   message (a character array, must contain only '0' or
%                   '1'). 
%       D30Star     - the last bit of the previous word (char type).
%
%   Outputs:
%       word        - word with corrected polarity of the data bits
%                   (character array). 

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
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
% $Id: checkPhase.m,v 1.1.2.4 2006/08/14 11:38:22 dpl Exp $

if D30Star == '1'
    % Data bits must be inverted
    word(1:24) = invert(word(1:24));
end
