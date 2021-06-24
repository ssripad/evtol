function [FlightOutput,L,n] = FlyMission(x)
% Rows are timesteps, columns are cases

L           =   length(x);          % Number of Mission Segments
n           =   x{1}.numcases(1);   % Number of Cases


tspan       =   nan(2*L, n);
power       =   nan(2*L, n);
energy      =   nan(2*L, n);
range       =   nan(2*L, n);
alt         =   nan(2*L, n);   
airspeed  	=   nan(2*L, n);
Temp        =   nan(2*L, n);
SoS         =   nan(2*L, n);
Press       =   nan(2*L, n);
Dens        =   nan(2*L, n);
Type        =   strings(2*L, 1);

tprev       =   zeros(1,n);
Eprev       =   zeros(1,n);
rprev       =   zeros(1,n);
% Iterate Through Mission Segments
for i = 1:L
    start               =   2*i-1; 
    ending              =   2*i;
    tspan(start,:)      =   tprev+1;
    energy(start,:)     =   Eprev;
    range(start,:)      =   rprev;
    alt(start,:)        =   x{i}.startAlt;
    airspeed(start,:) 	=   x{i}.startVelocity;
    power(start,:)      =   x{i}.startPower;
    Temp(start,:)       =   x{i}.startTemp;
    SoS(start,:)        =   x{i}.startSoS;
    Press(start,:)      =   x{i}.startPress;
    Dens(start,:)       =   x{i}.startDens;
    Type(start)         =   strcat(x{i}.type, ' start');
    
    alt(ending,:)      	=   x{i}.endAlt;
    airspeed(ending,:)	=   x{i}.endVelocity;
    power(ending,:)   	=   x{i}.endPower;
    Temp(ending,:)     	=   x{i}.endTemp;
    SoS(ending,:)       =   x{i}.endSoS;
    Press(ending,:)     =   x{i}.endPress;
    Dens(ending,:)      =   x{i}.endDens;
    Type(ending)         =   strcat(x{i}.type, ' end');
    
    tspan(ending,:)     =   tspan(start,:) + x{i}.time;
    energy(ending,:)   	=   energy(start,:)+ x{i}.energy;
    range(ending,:)   	=   range(start,:) + x{i}.range;    
    tprev               =   tspan(ending,:);
    Eprev               =   energy(ending,:);
    rprev               =   range(ending,:);
end
varNames        =   {'Segment', 'Times', 'PowerkW', 'EnergykWh', 'Rangem', ...
                    'Altitudem', 'Airspeedmps', 'TemperatureK', 'SpeedOfSoundmps',...
                    'PressurePa', 'Densitykgpm3'};
FlightOutput	=   table(Type, tspan, power, energy, range, alt, airspeed, Temp, SoS, Press, Dens, ...
                    'VariableNames',varNames);
end
