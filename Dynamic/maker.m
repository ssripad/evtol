function [whpm,range,packmission,peakp] = maker(mile,numPax,AeroProps,MissionProps)
% addpath('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Model') 

%% Initialize maker
% AeroProps           = readtable('maker_param.csv');
AeroProps.K         = 1./(4.*AeroProps.cd0.*AeroProps.LD.^2);

%% Global assumptions
mpax                = 100; %kg

%% FOR ANALYSIS
AeroProps.Range  = mile*1.6e3;
AeroProps.MTOM   = AeroProps.MTOM-((AeroProps.paxmax-numPax)*mpax); % kg

%% Atmos initialization
AtmosPropsGood      = atm(1);

%% Initialize mission
% MissionProps        = readtable('maker_mission.csv');

%% Run the model
[Mission,~,~]       = BasicMission(AeroProps, MissionProps, AtmosPropsGood);
% [Reserve,~,~]       = ReserveMission(AeroProps, MissionProps, AtmosPropsGood);

%% Overall performance
whpm        = Mission.EnergykWh(end)*1e3/(Mission.Rangem(end)/1.6e3); %Wh/mi
% whpm_r      = Reserve.EnergykWh(end)*1e3/(Reserve.Rangem(end)/1.6e3); %Wh/mi
range       = Mission.Rangem(end)/1.6e3;
mph         = max(Mission.Airspeedmps)*2.23694; %mi/h
peakp       = Mission.PowerkW(1); %kW
packmission = ((AeroProps.Range./1.6e3).*whpm)./1e3; %kWh
% packreserve = packmission+(Reserve.EnergykWh(end)-Mission.EnergykWh(end));

end