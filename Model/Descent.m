function [DescentOutput] = Descent(cd0, K, area_load, Ncli,...
    H0, VD, Hc, MTOM, TGL, PGL, DGL)

W_TO                        =   MTOM*9.8;
S                           =   MTOM./area_load;

[T0, S0, P0, D0]            =   Tatmos(H0,TGL,PGL,DGL); 
[Tc, Sc, Pc, Dc]            =   Tatmos(Hc,TGL,PGL,DGL);

K                           =   4*K/3; %New K to account for L/D correction

DescentOutput.startVelocity	=   sqrt(2.*W_TO./Dc./S.*sqrt(K./3./cd0));
DescentOutput.endVelocity 	=   sqrt(2.*W_TO./D0./S.*sqrt(K./3./cd0));
DescentOutput.time         	= 	(Hc-H0)./VD;
DescentOutput.startPower   	=   (W_TO.*-VD+(1/2).*Dc.*DescentOutput.startVelocity.^3.*S.*cd0 + ...
                                ( (K*W_TO.^2) ./ ((1/2).*Dc.*DescentOutput.startVelocity.*S))) ...
                                ./ Ncli./1000; % Kw 
DescentOutput.endPower     	=  	(W_TO.*-VD+(1/2).*D0.*DescentOutput.endVelocity.^3.*S.*cd0 + ...
                                ( (K*W_TO.^2) ./ ((1/2).*D0.*DescentOutput.endVelocity.*S))) ...
                                ./ Ncli./1000; % Kw 
DescentOutput.energy      	=  	(DescentOutput.startPower+DescentOutput.endPower)./2 .* ...
                                DescentOutput.time./3600; % kWh

DescentOutput.startTemp     =   Tc;
DescentOutput.endTemp       =   T0;
DescentOutput.startSoS      =   Sc;
DescentOutput.endSoS        =   S0;
DescentOutput.startPress    =   Pc;
DescentOutput.endPress      =   P0;
DescentOutput.startDens     =   Dc;
DescentOutput.endDens       =   D0;
DescentOutput.startAlt      =   Hc;
DescentOutput.endAlt        =   H0; 

DescentOutput.range         =   0;

DescentOutput.numcases   	=   length(DescentOutput.energy);
DescentOutput              	=   structfun(@(in)expand(in,DescentOutput.numcases),...
                               	DescentOutput,'UniformOutput',false);

DescentOutput.type          =   'Descent';
end