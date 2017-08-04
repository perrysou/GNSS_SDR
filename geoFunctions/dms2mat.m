function matOutput = dms2mat(dmsInput,n)
%DMS2MAT  Splits a real a = dd*100 + mm + s/100 into[dd mm s.ssss] 
%         where n specifies the power of 10, to which the resulting seconds
%         of the output should be rounded. E.g.: if a result is 23.823476
%         seconds, and n = -3, then the output will be 23.823.   

% Written by Kai Borre
% January 7, 2007
% Updated by Darius Plausinaitis

neg_arg = false;
if dmsInput < 0
	% Only positive numbers should be used while spliting into deg/min/sec
    dmsInput = -dmsInput;
    neg_arg = true;
end

%%% Split degrees minutes and seconds
int_deg = floor(dmsInput/100);
mm      = floor(dmsInput - 100*int_deg);
%we assume n<7; hence %2.10f is sufficient to hold ssdec
ssdec   = sprintf('%2.10f', (dmsInput-100*int_deg-mm)*100); 

%%% Check for overflow
if ssdec == 60 
    mm      = mm+1;
    ssdec   = 0;
end
if mm == 60
    int_deg = int_deg+1;
    mm      = 0;
end

%%% Corect the sign
if neg_arg == true
    int_deg = -int_deg;
end

%%% Compose the output
matOutput(1) = int_deg;
matOutput(2) = mm;
matOutput(3) = str2double(ssdec(1:-n+3));
%%%%%%%%%%%%%%%%%%% end dms2mat.m %%%%%%%%%%%%%%%%