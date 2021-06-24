function [CruiseOutput] = Cruise(cd0, K, area_load, Ncru, speed, LD, ...
    Hc, Range, MTOM, TGL, PGL, DGL)

W_TO                       = MTOM*9.8;
S                          = MTOM./area_load;

[Tc, Sc, Pc, Dc]           = Tatmos(Hc,TGL,PGL,DGL);

if speed<=sqrt(2.*W_TO./Dc./S.*sqrt(K./cd0))
CruiseOutput.startVelocity = sqrt(2.*W_TO./Dc./S.*sqrt(K./cd0)); %for max range
CruiseOutput.endVelocity   = CruiseOutput.startVelocity;

CruiseOutput.startPower    = W_TO ./(LD) .* CruiseOutput.startVelocity./ Ncru ./1000; % Kw 
CruiseOutput.endPower      = W_TO ./(LD) .* CruiseOutput.endVelocity./ Ncru ./1000; % Kw 
else
CruiseOutput.startVelocity = speed;
CruiseOutput.endVelocity   = CruiseOutput.startVelocity;

CruiseOutput.startPower    = W_TO ./(0.85*LD) .* CruiseOutput.startVelocity./ Ncru ./1000; % Kw 
CruiseOutput.endPower      = W_TO ./(0.85*LD) .* CruiseOutput.endVelocity./ Ncru ./1000; % Kw 
end

CruiseOutput.startTemp     = Tc;
CruiseOutput.endTemp       = Tc;
CruiseOutput.startSoS      = Sc;
CruiseOutput.endSoS        = Sc;
CruiseOutput.startPress    = Pc;
CruiseOutput.endPress      = Pc;
CruiseOutput.startDens     = Dc;
CruiseOutput.endDens       = Dc;
CruiseOutput.startAlt      = Hc;
CruiseOutput.endAlt        = Hc;   
if Range > 0
    CruiseOutput.time          = Range./ CruiseOutput.startVelocity;
    CruiseOutput.energy        = (CruiseOutput.startPower+CruiseOutput.endPower)./2 .* ...
                                CruiseOutput.time./3600; % kWh
    CruiseOutput.range         = Range;
    CruiseOutput.numcases      = length(CruiseOutput.energy);
else
    CruiseOutput.numcases      = length(CruiseOutput.startPower);
end


CruiseOutput               = structfun(@(in)expand(in,CruiseOutput.numcases),...
                               	CruiseOutput,'UniformOutput',false);
CruiseOutput.type          = 'Cruise';
end
    