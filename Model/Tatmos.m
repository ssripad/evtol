%% Syntax, to leave input argument at default ISA pass "NaN"

% [Temp, SoS, Press, Dens] = Tatmos(h);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0, density0);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0, density0,...
%         lapseRate);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0, density0,...
%         lapseRate, characteristicGasConstant);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0, density0,...
%         lapseRate, characteristicGasConstant, heatRatio);

% [Temp, SoS, Press, Dens] = Tatmos(h, temperature0, pressure0, density0,...
%         lapseRate, characteristicGasConstant, heatRatio, g);
%%
% [K, m/s, Pa, kg/m^3] = Tatmos([m], [K], [Pa], [kg/m^3], [K/m], [j/kg-K], [], [m/s^s])
function [Temp, SoS, Press, Dens] = Tatmos(varargin)
% Based on http://www.dept.aoe.vt.edu/~cdhall/courses/aoe2104/Standard%20Atmosphere.pdf
H   =   varargin{1};
extraArgs   =   [nan nan nan nan nan nan nan];
if nargin > 1
    for n=2:(nargin)
        extraArgs(n-1) = varargin{n};
    end
end
T0          =   extraArgs(1);
P0          =   extraArgs(2); 
D0        	=   extraArgs(3);
lapseRate 	=   extraArgs(4);
Rair      	=   extraArgs(5);
heatRatio  	=   extraArgs(6);
g           =   extraArgs(7);
if isnan(T0)
     T0 = 288.15;
end
if isnan(P0)
     P0 = 101325;
end
if isnan(D0)
     D0 = 1.225;
end
if isnan(lapseRate)
     lapseRate  =   0.0065;     % [K/m]
end
if isnan(Rair)
    Rair        =   287.0531;	% [J/kg-K]
end
if isnan(heatRatio)
    heatRatio       =   1.4;   	% []
end
if isnan(g)
    g             	=   9.80665; % [m/s^s]
end
Temp    =   T0 - lapseRate.*H;                      % [K]
SoS     =   sqrt(heatRatio.*Rair.*Temp);            % [m/s]
Press   =   P0.*(Temp/T0).^(g/(Rair*lapseRate));    % [Pa]
Dens    =   D0.*(Temp/T0).^(g/(Rair*lapseRate)-1);  % [kg/m^3]
end