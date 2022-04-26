clear 
close all

load('../Plotting/la_colors.mat')
color.brown = [0.5451,0.271,0.07451];
greyey = [0.4 0.4 0.4];
yellow = [1,0.691,0.2];

fsize = 16;
lw = 6;

lpath = pwd;
addpath('../Model')
addpath('../Static')

%% Set-up the distance landscape


labels = {'KH Heaviside','Joby S4','Lilium Jet','Beta Alia-250','Archer Maker','EV expected','ICEV expected'};
specrange = [100,150,162,32,284,60];
specpax = [1,5,7,1,6,2];
output_variables = {'whpm','range','energy','peakp'};

fixed_cruise_speed = 67.056; %m/s
distance = linspace(1,max(specrange),max(specrange));

AeroProps           = readtable('../Static/heaviside_param.csv');
MissionProps        = readtable('../Static/heaviside_mission.csv');
MissionProps.VCr    = fixed_cruise_speed; %m/s
Heaviside = zeros(length(distance(1)),4);
Heavisidef = zeros(length(distance(1)),4);
for n=1:length(distance)
[Heaviside(n,1),Heaviside(n,2),Heaviside(n,3),Heaviside(n,4)] = heaviside(distance(n),1,AeroProps,MissionProps);
[Heavisidef(n,1),Heavisidef(n,2),Heavisidef(n,3),Heavisidef(n,4)] = heaviside(distance(n),specpax(1),AeroProps,MissionProps);
if Heaviside(n,2)>specrange(1)
    break
end
end

AeroProps           = readtable('../Static/jobys4_param.csv');
MissionProps        = readtable('../Static/jobys4_mission.csv');
MissionProps.VCr    = fixed_cruise_speed; %m/s
S4 = zeros(length(distance(2)),4);
S4f = zeros(length(distance(2)),4);
for n=1:length(distance)
[S4(n,1),S4(n,2),S4(n,3),S4(n,4)] = jobyS4(distance(n),1,AeroProps,MissionProps);
[S4f(n,1),S4f(n,2),S4f(n,3),S4f(n,4)] = jobyS4(distance(n),specpax(2),AeroProps,MissionProps);
if S4(n,2)>specrange(2)
    break
end
end

AeroProps           = readtable('../Static/lilium_param.csv');
MissionProps        = readtable('../Static/lilium_mission.csv');
MissionProps.VCr    = fixed_cruise_speed; %m/s
LiliumJet = zeros(length(distance(3)),4);
LiliumJetf = zeros(length(distance(3)),4);
for n=1:length(distance)
[LiliumJet(n,1),LiliumJet(n,2),LiliumJet(n,3),LiliumJet(n,4)] = lilium(distance(n),1,AeroProps,MissionProps);
[LiliumJetf(n,1),LiliumJetf(n,2),LiliumJetf(n,3),LiliumJetf(n,4)] = lilium(distance(n),specpax(3),AeroProps,MissionProps);
if LiliumJet(n,2)>specrange(3)
    break
end
end

AeroProps           = readtable('../Static/betaalia_param.csv');
MissionProps        = readtable('../Static/betaalia_mission.csv');
MissionProps.VCr    = fixed_cruise_speed; %m/s
Alia = zeros(length(distance(5)),4);
Aliaf = zeros(length(distance(5)),4);
for n=1:length(distance)
[Alia(n,1),Alia(n,2),Alia(n,3),Alia(n,4)] = betaalia(distance(n),1,AeroProps,MissionProps);
[Aliaf(n,1),Aliaf(n,2),Aliaf(n,3),Aliaf(n,4)] = betaalia(distance(n),specpax(5),AeroProps,MissionProps);
if Alia(n,2)>specrange(5)
    break
end
end

AeroProps           = readtable('../Static/maker_param.csv');
MissionProps        = readtable('../Static/maker_mission.csv');
MissionProps.VCr    = fixed_cruise_speed; %m/s
ArcherMaker = zeros(length(distance(6)),4);
ArcherMakerf = zeros(length(distance(6)),4);
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