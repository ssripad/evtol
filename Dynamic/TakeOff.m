function [TakeOffOutput] = TakeOff(f, FM, disk_load, Nhov, VC, H0,...
    MTOM, TGL, PGL, DGL, rotortype)

W_TO    =   MTOM*9.8;
A       =   MTOM./disk_load; 

Hg                          = 0;
[Tg, Sg, Pg, Dg]            = Tatmos(Hg,TGL,PGL,DGL); 
[T0, S0, P0, D0]            = Tatmos(H0,TGL,PGL,DGL);


if strcmpi(rotortype,'openrotor')
TakeOffOutput.startPower    = (f.*W_TO./FM.*sqrt(f.*W_TO./(2.*D0.*A)))./Nhov./1000; % kW
TakeOffOutput.endPower      = (f.*W_TO./FM.*sqrt(f.*W_TO./(2.*Dg.*A)))./Nhov./1000; % kW
end

if strcmpi(rotortype,'ductedfan')
TakeOffOutput.startPower    = (f.*W_TO./(2.*FM).*sqrt(f.*W_TO./(D0.*A)))./Nhov./1000; % kW
TakeOffOutput.endPower      = (f.*W_TO./(2.*FM).*sqrt(f.*W_TO./(Dg.*A)))./Nhov./1000; % kW
end
    
TakeOffOutput.time          = H0./VC;

TakeOffOutput.startVelocity = 0;
TakeOffOutput.endVelocity   = 0;

TakeOffOutput.energy        = (TakeOffOutput.startPower+TakeOffOutput.endPower)./2 .* ...
                                TakeOffOutput.time./3600; % kWh
TakeOffOutput.startTemp     = Tg;
TakeOffOutput.endTemp       = T0;
TakeOffOutput.startSoS      = Sg;
TakeOffOutput.endSoS        = S0;
TakeOffOutput.startPress    = Pg;
TakeOffOutput.endPress      = P0;
TakeOffOutput.startDens     = Dg;
TakeOffOutput.endDens       = D0;

TakeOffOutput.range         = 0;
TakeOffOutput.startAlt      = Hg;
TakeOffOutput.endAlt        = H0; 

TakeOffOutput.numcases      = length(TakeOffOutput.energy);
TakeOffOutput               = structfun(@(in)expand(in,TakeOffOutput.numcases),...
                                TakeOffOutput,'UniformOutput',false);
TakeOffOutput.type          = 'TakeOff';
end