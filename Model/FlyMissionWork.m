function [whpm,mph,energy] = FlyMissionWork(milerange)
% clear
% close all

%% Atmos initialization
AtmosPropsGood        = atm(1);
AtmosPropsBad         = atm(2);

%% Mass Range stuff
% milerange             = 150; %miles
MassRangeProps.numPax = 4; % Number of Passengers
MassRangeProps.Mpay   = 100 * MassRangeProps.numPax; % kg
MassRangeProps.MTOM   = 4800/2.2; % kg
MassRangeProps.Range  = milerange*1.6*1e3; % m 
MassRangeProps.eE     = 300; % Wh/kg pack

%% Aero params
% %Joby
% AeroProps.f           = 1.03;
% AeroProps.cd0         = 0.015;
% AeroProps.FM          = 0.6;
% AeroProps.LD          = 18;
% AeroProps.K           = 0.55*1./(4.*AeroProps.cd0.*AeroProps.LD.^2); % I can prove this
% AeroProps.we_wmax     = 0.55;
% AeroProps.area_load   = 100;
% AeroProps.disk_load   = 100;
% AeroProps.Nprop       = 0.9;
% AeroProps.Nmech       = 0.9;

% %KHH
% AeroProps.f           = 1.03;
% AeroProps.cd0         = 0.015;
% AeroProps.FM          = 0.8;
% AeroProps.LD          = 16;
% AeroProps.K           = 0.55*1./(4.*AeroProps.cd0.*AeroProps.LD.^2); % I can prove this
% AeroProps.we_wmax     = 0.55;
% AeroProps.area_load   = 75;
% AeroProps.disk_load   = 80;
% AeroProps.Nprop       = 0.92;
% AeroProps.Nmech       = 0.9;

% %Lilium
AeroProps.f           = 1.03;
AeroProps.cd0         = 0.015;
AeroProps.FM          = 0.6;
AeroProps.LD          = 18;
AeroProps.K           = 0.55*1./(4.*AeroProps.cd0.*AeroProps.LD.^2); % I can prove this
AeroProps.we_wmax     = 0.55;
AeroProps.area_load   = 100;
AeroProps.disk_load   = 1000;
AeroProps.Nprop       = 0.9;
AeroProps.Nmech       = 0.9;

%% Mission Params
% Assign Vertical Climb Variables
MissionProps.VC     =   0.5; % Vertical Climb Velocity (m/s) NASA
MissionProps.H0     =   15;  % Vertical Take-Off AGL  NASA
% Assign Hover / Transition from Vertical Variables
MissionProps.tup    =   90; % Hover Up Time (s) 90 vahana, 120 mi
% Assign Aircraft Climb Variables
MissionProps.Vv     =   4.3; % Climb Rate (m/s) NASA paper
% Assign Cruise Variables
MissionProps.Hc     =   450; % Cruise AGL
% Assign Descent Variables
MissionProps.VD     =   1.4; % Aircraft Descent Rate (m/s)
% Assign Hover / Transition from Aircraft Flight Variables
MissionProps.tdn    =   120; % Hover Down Time (s) 90 vahana, 120 mit
% Assign Vertical Descent Variables
MissionProps.VDVL   =   0.4; % Vertical Descent Velocity (m/s) NASA
% Assign Reserve Variables
MissionProps.Hr     =   300; % Reserve AGL
MissionProps.tr     =   45*60;% Reserve time [s] FAR 23  

%%

% [Reserve,~,~] = ReserveMission(AeroBaseProps, MissionBaseProps, MassRangeBaseProps, AtmosPropsGood)
[Mission,~,~] = BasicMission(AeroProps, MissionProps, MassRangeProps, AtmosPropsGood);

whpm = Mission.EnergykWh(end)*1e3/(Mission.Rangem(end)/1.6e3);
mph = max(Mission.Airspeedmps)*2.23694;
energy = max(Mission.EnergykWh);


% t_i = Mission.Times(:);
% p_i = Mission.PowerkW(:);
% a_i = Mission.Altitudem(:);
% 
% t_f = linspace(t_i(1),t_i(end),t_i(end));
% p_f = interpn(t_i,p_i,t_f);
% a_f = interpn(t_i,a_i,t_f);
% 
% buffer = 500;
% 
% t_fa = t_f(1:round(Mission.Times(7)+buffer,0));
% p_fa = p_f(1:round(Mission.Times(7)+buffer,0));
% a_fa = a_f(1:round(Mission.Times(7)+buffer,0));
% 
% t_fb = t_f(round(Mission.Times(8)-buffer,0):end);
% p_fb = p_f(round(Mission.Times(8)-buffer,0):end);
% a_fb = a_f(round(Mission.Times(8)-buffer,0):end);
% 
% t = horzcat(t_fa,t_fb);
% p = horzcat(p_fa,p_fb);
% a = horzcat(a_fa,a_fb);
% 
% figure()
% for n=2:length(t)
% subplot(2,1,1)
% plot(t(1:n),p(1:n),'linewidth',2)
% xlim([0, Mission.Times(end)])
% ylim([0, Mission.PowerkW(end)])
% ylabel('Power')
% 
% subplot(2,1,2)
% plot(t(1:n),a(1:n),'linewidth',2)
% xlim([0, Mission.Times(end)])
% ylim([0, 1.2*max(Mission.Altitudem(:))])
% ylabel('Altitude')
% 
% pause(0.001)
% end

end
