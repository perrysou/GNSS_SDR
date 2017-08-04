function result = invert(data)
% Inverts the binary input-string so that 0 becomes 1 and 1 becomes 0.
%
%result = invert(data)

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Written by Darius Plausinaitis, Kristin Larson and Dennis M. Akos
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
% $Id: invert.m,v 1.1.2.4 2006/08/14 11:38:22 dpl Exp $

dataLength = length(data);
temp(1:dataLength) = '1';

invertMask = bin2dec(char(temp));

result = dec2bin(bitxor(bin2dec(data), invertMask), dataLength);