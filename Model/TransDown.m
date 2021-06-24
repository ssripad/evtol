function [TransitionDownOutput] = TransDown(f, cd0, FM, K, area_load, disk_load, Ncli, Nhov, ...
 H0, tdn, VD, MTOM, TGL, PGL, DGL)

W_TO                                =   MTOM*9.8;
A                                   =   MTOM./disk_load; 
S                                   =   MTOM./area_load;

[T0, S0, P0, D0]                    =   Tatmos(H0,TGL,PGL,DGL);

TransitionDownOutput.startVelocity  =   sqrt(2.*W_TO./D0./S.*sqrt(K./3./cd0));
TransitionDownOutput.endVelocity    =   0;
TransitionDownOutput.time           =   tdn;
TransitionDownOutput.endPower       = 	(f.*W_TO./FM.*sqrt(f.*W_TO./(2.*D0.*A)))./Nhov./1000; % kW
TransitionDownOutput.startPower     =  	(W_TO.*-VD+(1/2).*D0.*TransitionDownOutput.startVelocity.^3.*S.*cd0 + ...
                                        ((K*W_TO.^2)./((1/2).*D0.*TransitionDownOutput.startVelocity.*S))) ...
                                        ./ Ncli./1000; % Kw  
TransitionDownOutput.energy         =  	(TransitionDownOutput.startPower+TransitionDownOutput.endPower)./2 .* ...
                                        TransitionDownOutput.time./3600; % kWh
                            
TransitionDownOutput.startTemp      =   T0;
TransitionDownOutput.endTemp        =   T0;
TransitionDownOutput.startSoS       =   S0;
TransitionDownOutput.endSoS         =   S0;
TransitionDownOutput.startPress     =   P0;
TransitionDownOutput.endPress       =   P0;
TransitionDownOutput.startDens      =   D0;
TransitionDownOutput.endDens        =   D0;

TransitionDownOutput.range          =   0;
TransitionDownOutput.startAlt       =   H0;
TransitionDownOutput.endAlt         =   H0;

TransitionDownOutput.numcases    	=   length(TransitionDownOutput.energy);
TransitionDownOutput              	=   structfun(@(in)expand(in,TransitionDownOutput.numcases),...
                                        TransitionDownOutput,'UniformOutput',false);

TransitionDownOutput.type           =   'TransitionDown';
end


% TransitionDownOutput.range          =   (TransitionDownOutput.startVelocity+TransitionDownOutput.endVelocity)./2 ...
%                                         .*TransitionDownOutput.time;