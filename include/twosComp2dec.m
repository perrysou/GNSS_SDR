function intNumber = twosComp2dec(binaryNumber)
% TWOSCOMP2DEC(binaryNumber) Converts a two's-complement binary number
% BINNUMBER (in Matlab it is a string type), represented as a row vector of
% zeros and ones, to an integer. 
%
%intNumber = twosComp2dec(binaryNumber)

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Copyright (C) Darius Plausinaitis
% Written by Darius Plausinaitis
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
% $Id: twosComp2dec.m,v 1.1.2.4 2006/08/14 11:38:22 dpl Exp $

%--- Check if the input is string -----------------------------------------
if ~isstr(binaryNumber)
    error('Input must be a string.')
end

%--- Convert from binary form to a decimal number -------------------------
intNumber = bin2dec(binaryNumber);

%--- If the number was negative, then correct the result ------------------
if binaryNumber(1) == '1'
    intNumber = intNumber - 2^size(binaryNumber, 2);
end
