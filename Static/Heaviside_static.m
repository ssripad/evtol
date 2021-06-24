clear
close all

addpath('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Model') 

%% Initialize Heaviside
AeroProps           = readtable('heaviside_param.csv');
AeroProps.K         = 1./(4.*AeroProps.cd0.*AeroProps.LD.^2);

%% Global assumptions
mpax                = 100; %kg

%% Atmos initialization
AtmosPropsGood      = atm(1);
AtmosPropsBad       = atm(2);

%% Initialize mission
MissionProps        = readtable('heaviside_mission.csv');

%% Run the model
[Mission,~,~]       = BasicMission(AeroProps, MissionProps, AtmosPropsGood);
[Reserve,~,~]       = ReserveMission(AeroProps, MissionProps, AtmosPropsGood);

%% Flight segment times
segtimes.takeoff    = Mission.Times(2)-Mission.Times(1);
segtimes.transup    = Mission.Times(4)-Mission.Times(3);
segtimes.climb      = Mission.Times(6)-Mission.Times(5);
segtimes.cruise     = Mission.Times(8)-Mission.Times(7);
segtimes.descent    = Mission.Times(10)-Mission.Times(9);
segtimes.transdown  = Mission.Times(12)-Mission.Times(11);
segtimes.land       = Mission.Times(14)-Mission.Times(13);

%% Overall performance
results.whpm        = Mission.EnergykWh(end)*1e3/(Mission.Rangem(end)/1.6e3); %Wh/mi
results.whpm_r      = Reserve.EnergykWh(end)*1e3/(Reserve.Rangem(end)/1.6e3); %Wh/mi
results.mph         = max(Mission.Airspeedmps)*2.23694; %mi/h
results.peakp       = Mission.PowerkW(1); %kW
results.packmission = ((AeroProps.Range./1.6e3).*results.whpm)./1e3; %kWh
results.packreserve = results.packmission+(Reserve.EnergykWh(end)-Mission.EnergykWh(end));
resultscsv          = struct2table(results);
writetable(resultscsv,'heaviside_results.csv');