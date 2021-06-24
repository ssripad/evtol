function [TimedCruiseOutput] = TimedCruise(cd0, K, area_load, Ncru, ...
    LD, Hr, tr, MTOM,TGL,PGL,DGL)

W_TO                            =   MTOM*9.8;
S                               =   MTOM./area_load;

[Tr, Sr, Pr, Dr]               	=   Tatmos(Hr,TGL,PGL,DGL);

TimedCruiseOutput.startVelocity	=   sqrt(2.*W_TO./Dr./S.*sqrt(K./cd0));
TimedCruiseOutput.endVelocity  	=   TimedCruiseOutput.startVelocity;
TimedCruiseOutput.time          =   tr;
TimedCruiseOutput.startPower   	=   W_TO ./LD .* TimedCruiseOutput.startVelocity./ Ncru ./1000; % Kw 
TimedCruiseOutput.endPower   	= 	W_TO ./LD .* TimedCruiseOutput.endVelocity./ Ncru ./1000; % Kw 
TimedCruiseOutput.energy      	=   (TimedCruiseOutput.startPower+TimedCruiseOutput.endPower)./2 .* ...
                                    TimedCruiseOutput.time./3600; % kWh
TimedCruiseOutput.range         =   TimedCruiseOutput.startVelocity .* TimedCruiseOutput.time;
                                
TimedCruiseOutput.startTemp     =   Tr;
TimedCruiseOutput.endTemp       =   Tr;
TimedCruiseOutput.startSoS      =   Sr;
TimedCruiseOutput.endSoS        =   Sr;
TimedCruiseOutput.startPress    =   Pr;
TimedCruiseOutput.endPress      =   Pr;
TimedCruiseOutput.startDens     =   Dr;
TimedCruiseOutput.endDens       =   Dr;
TimedCruiseOutput.startAlt      =   Hr;
TimedCruiseOutput.endAlt        =   Hr;   

TimedCruiseOutput.numcases  	=   length(TimedCruiseOutput.energy);
TimedCruiseOutput           	=   structfun(@(in)expand(in,TimedCruiseOutput.numcases),...
                                        TimedCruiseOutput,'UniformOutput',false);
TimedCruiseOutput.type          =   'TimedCruise';
end