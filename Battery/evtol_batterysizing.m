clear
close all
load('../Plotting/la_colors.mat')

greyey = [0.4 0.4 0.4];
yellow = [1,0.691,0.2];
fsize = 14;
lw = 3.5;

%% Results 
rmaker     = readtable('../Static/maker_results.csv');
rlilium    = readtable('../Static/lilium_results.csv');
rjobys4    = readtable('../Static/jobys4_results.csv');
rheaviside = readtable('../Static/heaviside_results.csv');
rbetaalia  = readtable('../Static/betaalia_results.csv');
pmaker     = readtable('../Static/maker_param.csv');
plilium    = readtable('../Static/lilium_param.csv');
pjobys4    = readtable('../Static/jobys4_param.csv');
pheaviside = readtable('../Static/heaviside_param.csv');
pbetaalia  = readtable('../Static/betaalia_param.csv');

%% Current vehicles and batteries
taycan = [460,93.4e3,93.4e3/136];%kW,Wh,kg
models = [500,109.8e3,109.8e3/165];%kW,Wh,kg
rimac_c2 = [1408,120e3,830];
x57 = [57.6*300/1e3,3.5e3,23.2];
llb = [2.362,827,5];
bydg = [1.5,140,1];

%% Aircraft weight and battery calculations 
% Run the static files to generate the results
% IMPORTANT ASSUMPTIONS FOR THE ANALYSIS

% Empty weight fraction if specified or 0.5
ewf_lilijet = 0.48; 
ewf = 0.5; 
ewf1 = 0.45; %lower limit
ewf2 = 0.55; %upper limlit

mpax = 100; %mass of passenger

% Assumption of degradation beginning of life to end of life
spen_BOLtoEOL = 1;

% Assumption of 2 rotor failure
number_rotor_fail = 2;
failfrac_KHH = 1-number_rotor_fail/8;
failfrac_S4 = 1-number_rotor_fail/6;
failfrac_lilijet = 1-number_rotor_fail/36;
failfrac_alia = 1-number_rotor_fail/4;
failfrac_maker = 1-number_rotor_fail/12;

KHH_nr = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf + pheaviside.paxmax*mpax))/spen_BOLtoEOL];
KHH1 = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf1 + pheaviside.paxmax*mpax))/spen_BOLtoEOL];
KHH2 = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf2 + pheaviside.paxmax*mpax))/spen_BOLtoEOL];
S4_nr = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf + pjobys4.paxmax*mpax))/spen_BOLtoEOL];
S41 = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf1 + pjobys4.paxmax*mpax))/spen_BOLtoEOL];
S42 = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf2 + pjobys4.paxmax*mpax))/spen_BOLtoEOL];
lilijet_nr = [rlilium.peakp,rlilium.packmission*1e3, (plilium.MTOM - (plilium.MTOM*ewf_lilijet + plilium.paxmax*mpax))/spen_BOLtoEOL];
lilijet1 = [rlilium.peakp,rlilium.packmission*1e3, (plilium.MTOM - (plilium.MTOM*ewf1 + plilium.paxmax*mpax))/spen_BOLtoEOL];
lilijet2 = [rlilium.peakp,rlilium.packmission*1e3, (plilium.MTOM - (plilium.MTOM*ewf2 + plilium.paxmax*mpax))/spen_BOLtoEOL];
alia_nr = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf + pbetaalia.paxmax*mpax))/spen_BOLtoEOL];
alia1 = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf1 + pbetaalia.paxmax*mpax))/spen_BOLtoEOL];
alia2 = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf2 + pbetaalia.paxmax*mpax))/spen_BOLtoEOL];
maker_nr = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf + pmaker.paxmax*mpax))/spen_BOLtoEOL];
maker1 = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf1 + pmaker.paxmax*mpax))/spen_BOLtoEOL];
maker2 = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf2 + pmaker.paxmax*mpax))/spen_BOLtoEOL];