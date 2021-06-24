function [TransitionUpOutput] = TransUp(f, cd0, FM, K, area_load, disk_load, Nhov, Ncli, ...
    H0, tup, Vv, MTOM, TGL, PGL, DGL)
W_TO                                =   MTOM*9.8;
A                                   =   MTOM./disk_load; 
S                                   =   MTOM./area_load;

[T0, S0, P0, D0]                    =   Tatmos(H0,TGL,PGL,DGL);

TransitionUpOutput.endVelocity      =   sqrt(2.*W_TO./D0./S.*sqrt(K./3./cd0));
TransitionUpOutput.startVelocity    =   0;
TransitionUpOutput.time             =   tup;
TransitionUpOutput.startPower       =   (f.*W_TO./FM.*sqrt(f.*W_TO./(2.*D0.*A)))./Nhov./1000; % kW
TransitionUpOutput.endPower         =    (W_TO.*Vv+(1/2).*D0.*TransitionUpOutput.endVelocity.^3.*S.*cd0 + ...
                                        ( (K*W_TO.^2) ./ ((1/2).*D0.*TransitionUpOutput.endVelocity.*S))) ...
                                        ./ Ncli./1000; % Kw  
TransitionUpOutput.energy           =   (TransitionUpOutput.startPower+TransitionUpOutput.endPower)./2 .* ...
                                        TransitionUpOutput.time./3600; % kWh
                            
TransitionUpOutput.startTemp        =   T0;
TransitionUpOutput.endTemp          =   T0;
TransitionUpOutput.startSoS         =   S0;
TransitionUpOutput.endSoS           =   S0;
TransitionUpOutput.startPress       =   P0;
TransitionUpOutput.endPress         =   P0;
TransitionUpOutput.startDens        =   D0;
TransitionUpOutput.endDens          =   D0;

TransitionUpOutput.range            =   0;
TransitionUpOutput.startAlt         =   H0;
TransitionUpOutput.endAlt           =   H0;

TransitionUpOutput.numcases         =   length(TransitionUpOutput.energy);
TransitionUpOutput                  =   structfun(@(in)expand(in,TransitionUpOutput.numcases),...
                                        TransitionUpOutput,'UniformOutput',false);

TransitionUpOutput.type         =   'TransitionUp';
end

% TransitionUpOutput.range            =   (TransitionUpOutput.startVelocity+TransitionUpOutput.endVelocity)./2 ...
%                                         .*TransitionUpOutput.time;