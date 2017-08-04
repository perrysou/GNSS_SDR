function [tau1, tau2] = calcLoopCoef(LBW, zeta, k)
%Function finds loop coefficients. The coefficients are used then in PLL-s
%and DLL-s.
%
%[tau1, tau2] = calcLoopCoef(LBW, zeta, k)
%
%   Inputs:
%       LBW           - Loop noise bandwidth
%       zeta          - Damping ratio
%       k             - Loop gain
%
%   Outputs:
%       tau1, tau2   - Loop filter coefficients 
 
%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Copyright (C) Darius Plausinaitis and Dennis M. Akos
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

%CVS record:
%$Id: calcLoopCoef.m,v 1.1.2.2 2006/08/14 11:38:22 dpl Exp $

% Solve natural frequency
Wn = LBW*8*zeta / (4*zeta.^2 + 1);

% solve for t1 & t2
tau1 = k / (Wn * Wn);
tau2 = 2.0 * zeta / Wn;
