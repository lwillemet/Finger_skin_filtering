function [fporte] = porte(x,Ts,m)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% if (abs(x-m)<=Ts/2)
%     fporte = 1;
% else
%     fporte = 0;
% end
% fporte = 1.*(abs(x-m)<=Ts/2) +0.*not(abs(x-m)<=Ts/2);
fporte = heaviside(abs(x-m)+Ts/2)-heaviside(abs(x-m)-Ts/2);
% fporte = rectangularPulse(m-Ts/2,m+Ts/2,x);
end

