function [AtmosProps] = Atmospheric(mission,n)
% Hg: ground
% H0: hover altitude
% Hc: cruise altitude
% Hr: reserve altitude
if n==1
    
    g                           = 9.80665;  % Gravity               (m/s^2)
    heatRatio                   = 1.4;      % Specific Heat Ratio
    characteristicGasConstant   = 287.0531; % Air Gas Constant      (J/kg-K)
    lapseRate                   = 0.0065;   % Lapse Rate            (K/m)
    heightTroposphere           = 11000;    % Troposphere height    (m)
    heightTropopause            = 20000;    % Tropopause Altitude   (m)
    density0                    = 1.225;    % Ground Density
    pressure0                   = 101325;   % Ground Pressure       (Pa)
    temperature0                = 288.15;   % Ground Temperature    (K) 
    
    H       =   [0 mission.H0 mission.Hc mission.Hr];
    
    [Temp, SoS, Press, Dens] = atmoslapse(H, g, heatRatio, ...
    characteristicGasConstant, lapseRate, heightTroposphere, ...
    heightTropopause, density0, pressure0, temperature0);  
    
    AtmosProps.Tg   =   Temp(1);
    AtmosProps.T0   =   Temp(2);
    AtmosProps.Tc   =   Temp(3);
    AtmosProps.Tr   =   Temp(4);
    
    AtmosProps.Sg   =   SoS(1);
    AtmosProps.S0   =   SoS(2);
    AtmosProps.Sc   =   SoS(3);
    AtmosProps.Sr   =   SoS(4);
    
    AtmosProps.Pg   =   Press(1);
    AtmosProps.P0   =   Press(2);
    AtmosProps.Pc   =   Press(3);
    AtmosProps.Pr   =   Press(4);
    
    AtmosProps.Dg   =   Dens(1);
    AtmosProps.D0   =   Dens(2);
    AtmosProps.Dc   =   Dens(3);
    AtmosProps.Dr   =   Dens(4);
elseif n==2
    
    g                           = 9.80665;  % Gravity               (m/s^2)
    heatRatio                   = 1.4;      % Specific Heat Ratio
    characteristicGasConstant   = 287.0531; % Air Gas Constant      (J/kg-K)
    lapseRate                   = 0.0065;   % Lapse Rate            (K/m)
    heightTroposphere           = 11000;    % Troposphere height    (m)
    heightTropopause            = 20000;    % Tropopause Altitude   (m)
    density0                    = 1.225;    % Ground Density
    pressure0                   = 101325;   % Ground Pressure       (Pa)
    temperature0                = 288.15;   % Ground Temperature    (K) 
    
    densitylow                 = 0.974;    % Ground Density
    temperaturehigh             = 300;      % Ground Temperature    (K) 
    
    H       =   [0 mission.H0 mission.Hc mission.Hr];
    
    [Temp, SoS, Press, Dens] = atmoslapse(H, g, heatRatio, ...
    characteristicGasConstant, lapseRate, heightTroposphere, ...
    heightTropopause, density0, pressure0, temperature0);  
    
    [Tempbad, SoSbad, Pressbad, Densbad] = atmoslapse(H, g, heatRatio, ...
    characteristicGasConstant, lapseRate, heightTroposphere, ...
    heightTropopause, densitylow, pressure0, temperaturehigh);  
    
    AtmosProps.Tg   =   [Temp(1) Tempbad(1)];
    AtmosProps.T0   =   [Temp(2) Tempbad(2)];
    AtmosProps.Tc   =   [Temp(3) Tempbad(3)];
    AtmosProps.Tr   =   [Temp(4) Tempbad(4)];
    
    AtmosProps.Sg   =   [SoS(1) SoSbad(1)];
    AtmosProps.S0   =   [SoS(2) SoSbad(2)];
    AtmosProps.Sc   =   [SoS(3) SoSbad(3)];
    AtmosProps.Sr   =   [SoS(4) SoSbad(4)];
    
    AtmosProps.Pg   =   [Press(1) Pressbad(1)];
    AtmosProps.P0   =   [Press(2) Pressbad(2)];
    AtmosProps.Pc   =   [Press(3) Pressbad(3)];
    AtmosProps.Pr   =   [Press(4) Pressbad(4)];
    
    AtmosProps.Dg   =   [Dens(1) Densbad(1)];
    AtmosProps.D0   =   [Dens(2) Densbad(2)];
    AtmosProps.Dc   =   [Dens(3) Densbad(3)];
    AtmosProps.Dr   =   [Dens(4) Densbad(4)];   
else
    error('n must be either 1 or 2')
end
end