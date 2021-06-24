function [AtmosProps] = atm(n)
if n == 1
    AtmosProps.TGL 	= 288.15;   % Ground Temperature    [K]
    AtmosProps.PGL	= 101325;   % Ground Pressure       [Pa]
    AtmosProps.DGL 	= 1.225;    % Ground Density        [kg/m^3]
elseif n==2
    AtmosProps.TGL 	= 300;      % Ground Temperature    [K]
    AtmosProps.PGL 	= 101325;   % Ground Pressure       [Pa]
    AtmosProps.DGL 	= 0.974;    % Ground Density        [kg/m^3]
else
    error('Select 1 or 2')
end
end