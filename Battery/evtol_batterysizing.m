clear
close all


%% Results 
rmaker     = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/maker_results.csv');
rlilium    = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/lilium_results.csv');
rjobys4    = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/jobys4_results.csv');
rheaviside = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/heaviside_results.csv');
rbetaalia  = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/betaalia_results.csv');
pmaker     = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/maker_param.csv');
plilium    = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/lilium_param.csv');
pjobys4    = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/jobys4_param.csv');
pheaviside = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/heaviside_param.csv');
pbetaalia  = readtable('/Users/ssripad/Box Sync/Projects/Electric Aircarft/PNAS_BR/Static/betaalia_param.csv');

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
ewf = 0.5;
ewf1 = 0.45;
ewf2 = 0.55;
mpax = 100;
spenfrac = 1;
failfrac = 0.5;

KHH_nr = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf + pheaviside.paxmax*mpax))/spenfrac];
KHH1 = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf1 + pheaviside.paxmax*mpax))/spenfrac];
KHH2 = [rheaviside.peakp,rheaviside.packreserve*1e3, (pheaviside.MTOM - (pheaviside.MTOM*ewf2 + pheaviside.paxmax*mpax))/spenfrac];
S4_nr = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf + pjobys4.paxmax*mpax))/spenfrac];
S41 = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf1 + pjobys4.paxmax*mpax))/spenfrac];
S42 = [rjobys4.peakp,rjobys4.packreserve*1e3, (pjobys4.MTOM - (pjobys4.MTOM*ewf2 + pjobys4.paxmax*mpax))/spenfrac];
lilijet_nr = [rlilium.peakp,rlilium.packreserve*1e3, (plilium.MTOM - (plilium.MTOM*ewf + plilium.paxmax*mpax))/spenfrac];
lilijet1 = [rlilium.peakp,rlilium.packreserve*1e3, (plilium.MTOM - (plilium.MTOM*ewf1 + plilium.paxmax*mpax))/spenfrac];
lilijet2 = [rlilium.peakp,rlilium.packreserve*1e3, (plilium.MTOM - (plilium.MTOM*ewf2 + plilium.paxmax*mpax))/spenfrac];
alia_nr = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf + pbetaalia.paxmax*mpax))/spenfrac];
alia1 = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf1 + pbetaalia.paxmax*mpax))/spenfrac];
alia2 = [rbetaalia.peakp,rbetaalia.packreserve*1e3, (pbetaalia.MTOM - (pbetaalia.MTOM*ewf2 + pbetaalia.paxmax*mpax))/spenfrac];
maker_nr = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf + pmaker.paxmax*mpax))/spenfrac];
maker1 = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf1 + pmaker.paxmax*mpax))/spenfrac];
maker2 = [rmaker.peakp,rmaker.packreserve*1e3, (pmaker.MTOM - (pmaker.MTOM*ewf2 + pmaker.paxmax*mpax))/spenfrac];