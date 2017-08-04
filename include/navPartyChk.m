function status = navPartyChk(ndat)
% This function is called to compute and status the parity bits on GPS word.
% Based on the flowchart in Figure 2-10 in the 2nd Edition of the GPS-SPS
% Signal Spec.
%
%status = navPartyChk(ndat)
%
%   Inputs: 
%       ndat        - an array (1x32) of 32 bits represent a GPS navigation
%                   word which is 30 bits plus two previous bits used in
%                   the parity calculation (-2 -1 0 1 2 ... 28 29)
%
%   Outputs: 
%       status      - the test value which equals EITHER +1 or -1 if parity
%                   PASSED or 0 if parity fails.  The +1 means bits #1-24
%                   of the current word have the correct polarity, while -1
%                   means the bits #1-24 of the current word must be
%                   inverted. 

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Written by Darius Plausinaitis, Kristin Larson
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
% $Id: navPartyChk.m,v 1.1.2.5 2006/08/14 11:38:22 dpl Exp $

% In order to accomplish the exclusive or operation using multiplication
% this program represents a '0' with a '-1' and a '1' with a '1' so that
% the exclusive or table holds true for common data operations
%
%	a	b	xor 			a	b	product
%  --------------          -----------------
%	0	0	 1			   -1  -1	   1
%	0	1	 0			   -1   1	  -1
%	1	0	 0			    1  -1	  -1
%	1	1	 1			    1   1	   1

%--- Check if the data bits must be inverted ------------------------------
if (ndat(2) ~= 1)
    ndat(3:26)= -1 .* ndat(3:26);  % Also could just negate
end

%--- Calculate 6 parity bits ----------------------------------------------
% The elements of the ndat array correspond to the bits showed in the table
% 20-XIV (ICD-200C document) in the following way:
% The first element in the ndat is the D29* bit and the second - D30*.
% The elements 3 - 26 are bits d1-d24 in the table.
% The elements 27 - 32 in the ndat array are the received bits D25-D30.
% The array "parity" contains the computed D25-D30 (parity) bits.

parity(1) = ndat(1)  * ndat(3)  * ndat(4)  * ndat(5)  * ndat(7)  * ...
            ndat(8)  * ndat(12) * ndat(13) * ndat(14) * ndat(15) * ...
            ndat(16) * ndat(19) * ndat(20) * ndat(22) * ndat(25);

parity(2) = ndat(2)  * ndat(4)  * ndat(5)  * ndat(6)  * ndat(8)  * ...
            ndat(9)  * ndat(13) * ndat(14) * ndat(15) * ndat(16) * ...
            ndat(17) * ndat(20) * ndat(21) * ndat(23) * ndat(26);

parity(3) = ndat(1)  * ndat(3)  * ndat(5)  * ndat(6)  * ndat(7)  * ...
            ndat(9)  * ndat(10) * ndat(14) * ndat(15) * ndat(16) * ...
            ndat(17) * ndat(18) * ndat(21) * ndat(22) * ndat(24);

parity(4) = ndat(2)  * ndat(4)  * ndat(6)  * ndat(7)  * ndat(8)  * ...
            ndat(10) * ndat(11) * ndat(15) * ndat(16) * ndat(17) * ...
            ndat(18) * ndat(19) * ndat(22) * ndat(23) * ndat(25);

parity(5) = ndat(2)  * ndat(3)  * ndat(5)  * ndat(7)  * ndat(8)  * ...
            ndat(9)  * ndat(11) * ndat(12) * ndat(16) * ndat(17) * ...
            ndat(18) * ndat(19) * ndat(20) * ndat(23) * ndat(24) * ...
            ndat(26);

parity(6) = ndat(1)  * ndat(5)  * ndat(7)  * ndat(8)  * ndat(10) * ...
            ndat(11) * ndat(12) * ndat(13) * ndat(15) * ndat(17) * ...
            ndat(21) * ndat(24) * ndat(25) * ndat(26);

%--- Compare if the received parity is equal the calculated parity --------
if ((sum(parity == ndat(27:32))) == 6)
    
    % Parity is OK. Function output is -1 or 1 depending if the data bits
    % must be inverted or not. The "ndat(2)" is D30* bit - the last  bit of
    % previous subframe. 
    status = -1 * ndat(2);
else
    % Parity failure
    status = 0;
end
