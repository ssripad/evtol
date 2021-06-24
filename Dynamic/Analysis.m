clear 
close all

load('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/zla_colors.mat')

%% Set-up the distance landscape
distance = linspace(1,284,284);

labels = {'KH Heaviside','Joby S4','Lilium Jet','Beta Alia-250','Archer Maker','EV expected','ICEV expected'};
specrange = [100,150,161,32,284,60];
specpax = [1,5,7,1,6,2];
variables = {'whpm','range','energy','peakp'};

AeroProps           = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/heaviside_param.csv');
MissionProps        = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/heaviside_mission.csv');
MissionProps.VCr    = 67.056; %m/s
for n=1:length(distance)
[Heaviside(n,1),Heaviside(n,2),~,~] = heaviside(distance(n),1,AeroProps,MissionProps);
[Heavisidef(n,1),Heavisidef(n,2),~,~] = heaviside(distance(n),specpax(1),AeroProps,MissionProps);
if Heaviside(n,2)>specrange(1)
    break
end
end

AeroProps           = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/jobys4_param.csv');
MissionProps        = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/jobys4_mission.csv');
MissionProps.VCr    = 67.056; %m/s
for n=1:length(distance)
[S4(n,1),S4(n,2),S4(n,3),S4(n,4)] = jobyS4(distance(n),1,AeroProps,MissionProps);
[S4f(n,1),S4f(n,2),S4f(n,3),S4f(n,4)] = jobyS4(distance(n),specpax(2),AeroProps,MissionProps);
if S4(n,2)>specrange(2)
    break
end
end

AeroProps           = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/lilium_param.csv');
MissionProps        = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/lilium_mission.csv');
MissionProps.VCr    = 67.056; %m/s
for n=1:length(distance)
[LiliumJet(n,1),LiliumJet(n,2),LiliumJet(n,3),LiliumJet(n,4)] = lilium(distance(n),1,AeroProps,MissionProps);
[LiliumJetf(n,1),LiliumJetf(n,2),LiliumJetf(n,3),LiliumJetf(n,4)] = lilium(distance(n),specpax(3),AeroProps,MissionProps);
if LiliumJet(n,2)>specrange(3)
    break
end
end

AeroProps           = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/betaalia_param.csv');
MissionProps        = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/betaalia_mission.csv');
MissionProps.VCr    = 67.056; %m/s
for n=1:length(distance)
[Alia(n,1),Alia(n,2),Alia(n,3),Alia(n,4)] = betaalia(distance(n),1,AeroProps,MissionProps);
[Aliaf(n,1),Aliaf(n,2),Aliaf(n,3),Aliaf(n,4)] = betaalia(distance(n),specpax(5),AeroProps,MissionProps);
if Alia(n,2)>specrange(5)
    break
end
end

AeroProps           = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/maker_param.csv');
MissionProps        = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/maker_mission.csv');
MissionProps.VCr    = 67.056; %m/s
for n=1:length(distance)
[ArcherMaker(n,1),ArcherMaker(n,2),ArcherMaker(n,3),ArcherMaker(n,4)] = maker(distance(n),1,AeroProps,MissionProps);
[ArcherMakerf(n,1),ArcherMakerf(n,2),ArcherMakerf(n,3),ArcherMakerf(n,4)] = maker(distance(n),specpax(6),AeroProps,MissionProps);
if ArcherMaker(n,2)>specrange(6)
    break
end
end

%% Terretrial Analysis
circu = 1.2;
ICE = 1400*circu;
EV = 311*circu;
car_occupancy = 1.54;

