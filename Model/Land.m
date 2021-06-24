function [LandingOutput] = Land(f, FM, disk_load, Nhov, VDVL, H0,...
    MTOM, TGL, PGL, DGL, rotortype)

W_TO    =   MTOM*9.8;
A       =   MTOM./disk_load; 

Hg                          =   0;
[Tg, Sg, Pg, Dg]            =   Tatmos(Hg,TGL,PGL,DGL); 
[T0, S0, P0, D0]            =   Tatmos(H0,TGL,PGL,DGL);

LandingOutput.time          =   H0./VDVL;

LandingOutput.startVelocity =   0;
LandingOutput.endVelocity   =   0;

if strcmpi(rotortype,'openrotor')
LandingOutput.startPower    =   (f.*W_TO./FM.*sqrt(f.*W_TO./(2.*D0.*A)))./Nhov./1000; % kW
LandingOutput.endPower      =   (f.*W_TO./FM.*sqrt(f.*W_TO./(2.*Dg.*A)))./Nhov./1000; % kW
end

if strcmpi(rotortype,'ductedfan')
LandingOutput.startPower    =   (f.*W_TO./(2.*FM).*sqrt(f.*W_TO./(D0.*A)))./Nhov./1000; % kW
LandingOutput.endPower      =   (f.*W_TO./(2.*FM).*sqrt(f.*W_TO./(Dg.*A)))./Nhov./1000; % kW
end
    
LandingOutput.energy        =   (LandingOutput.startPower+LandingOutput.endPower)./2 .* ...
                                LandingOutput.time./3600; % kWh
LandingOutput.startTemp     =   T0;
LandingOutput.endTemp       =   Tg;
LandingOutput.startSoS      =   S0;
LandingOutput.endSoS        =   Sg;
LandingOutput.startPress    =   P0;
LandingOutput.endPress      =   Pg;
LandingOutput.startDens     =   D0;
LandingOutput.endDens       =   Dg;

LandingOutput.range         =   0;
LandingOutput.startAlt      =   H0;
LandingOutput.endAlt        =   Hg;   

LandingOutput.numcases      =   length(LandingOutput.energy);
LandingOutput               =   structfun(@(in)expand(in,LandingOutput.numcases),...
                                LandingOutput,'UniformOutput',false);
LandingOutput.type          =   'Landing';
end