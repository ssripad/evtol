function [ClimbOutput] = AeroClimb(cd0, K, area_load, Ncli,...
    H0, Vv, Hc, MTOM, TGL, PGL, DGL)

W_TO                        =   MTOM*9.8;
S                           =   MTOM./area_load;

[T0, S0, P0, D0]            =   Tatmos(H0,TGL,PGL,DGL); 
[Tc, Sc, Pc, Dc]            =   Tatmos(Hc,TGL,PGL,DGL);

K                           =   4*K/3; %New K to account for L/D correction

ClimbOutput.startVelocity   =   sqrt(2.*W_TO./D0./S.*sqrt(K./3./cd0)); 
ClimbOutput.endVelocity     =   sqrt(2.*W_TO./Dc./S.*sqrt(K./3./cd0));
ClimbOutput.time            =   (Hc-H0)./Vv;
ClimbOutput.startPower      =   (W_TO.*Vv+(1/2).*D0.*ClimbOutput.startVelocity.^3.*S.*cd0 + ...
                                ( (K.*W_TO.^2) ./ ((1/2).*D0.*ClimbOutput.startVelocity.*S))) ...
                                ./ Ncli./1000; % Kw 
ClimbOutput.endPower        =    (W_TO.*Vv+(1/2).*Dc.*ClimbOutput.endVelocity.^3.*S.*cd0 + ...
                                ( (K*W_TO.^2) ./ ((1/2).*Dc.*ClimbOutput.endVelocity.*S))) ...
                                ./ Ncli./1000; % Kw 
ClimbOutput.energy          =   (ClimbOutput.startPower+ClimbOutput.endPower)./2 .* ...
                                ClimbOutput.time./3600; % kWh
                         
ClimbOutput.startHorizontalVelocity     =   sqrt(ClimbOutput.startVelocity.^2 + Vv.^2); 
ClimbOutput.endHorizontalVelocity       =   sqrt(ClimbOutput.endVelocity.^2 + Vv.^2); 

ClimbOutput.range           =   (ClimbOutput.startHorizontalVelocity+ClimbOutput.endHorizontalVelocity)./2 ...
                                .*ClimbOutput.time;                               
                            
ClimbOutput.startTemp       =   T0;
ClimbOutput.endTemp         =   Tc;
ClimbOutput.startSoS        =   S0;
ClimbOutput.endSoS          =   Sc;
ClimbOutput.startPress      =   P0;
ClimbOutput.endPress        =   Pc;
ClimbOutput.startDens       =   D0;
ClimbOutput.endDens         =   Dc;
ClimbOutput.startAlt        =   H0;
ClimbOutput.endAlt          =   Hc;       

ClimbOutput.numcases        =   length(ClimbOutput.energy);
ClimbOutput              	=   structfun(@(in)expand(in,ClimbOutput.numcases),...
                               	ClimbOutput,'UniformOutput',false);

ClimbOutput.type            =   'Climb';
end