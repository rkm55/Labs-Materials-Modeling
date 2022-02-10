%% MS Lab2
clear; clc; close all;

%% Tutorial 2
a = [3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0...
    4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0];
Etotlj = [9.96567496490893;4.38654652306884;-0.349063127438108;...
    -4.08772209644045;-7.05239777384006;-9.24996862294402;...
    -10.8526701493103;-12.0363782859575;-12.8258245727982;...
    -13.2394307852542;-13.4177872966399;-13.4179451763361;...
    -13.2449881441355;-12.9291989495811;-12.5330361333102;...
    -12.0937632839879;-11.634992706341;-11.1627859324479;...
    -10.6530850882936;-10.0811626336944;-9.47540967050678].';

[Emin,Ei] = min(Etotlj);
% disp('equlibrium lattice parameter (Ang)')
% disp(a(Ei))
Ang = char(197);
plot(a,Etotlj,'*k','MarkerSize',5)
lgd = legend(['Minimum Energy = ',num2str(a(Ei)),' ',Ang],...
    'Location','best');
title(lgd,'Equilibrium Lattice Parameter')
xlabel(['Lattice Parameter (',Ang,')'])
ylabel('Total Energy (eV)')
set(gcf,'position',[400,400,450,350])

%% 3 part ii
% LJ and EAM
a = 2.5:0.1:4.5;
Ecoh_eam = [23.2496145883705;10.4737334639288;4.64383357556833;...
    1.92741626487709;0.41542244749388;-0.620872630369922;...
    -1.42018051620361;-2.04319880498129;-2.54285272746703;...
    -2.93530815430567;-3.1847517886534;-3.27761557493295;...
    -3.27000147906758;-3.19682250291535;-3.07600337709585;...
    -2.92007488101555;-2.72979227587768;-2.5381232025536;...
    -2.36679251492858;-2.21365548618394;-2.06654219302478];
Ecoh_lj = [210.415845415224;119.110691777186;66.6985414328948;...
    35.8030189205043;17.8437836644785;7.35642476567895;...
    1.6319239936155;-1.73950163222451;-3.5091239957486;...
    -4.32840868084265;-4.46215199626927;-4.42750871841537;...
    -4.2167776510405;-3.91796312158995;-3.58361483707337;...
    -2.96984319808995;-2.6806228471449;-2.40710821974127;...
    -2.15436368019214;-1.92430303226737;-1.71698513619185];
% part i data
eamlat = 3.639;
eamE = -3.283;
ljlat = 3.534;
ljE = -4.478;
[~,a_eam] = min(Ecoh_eam);
[~,a_lj] = min(Ecoh_lj);
MS = 5.5;
Ang = char(197);
hold on
plot(a,Ecoh_eam,'*k','MarkerSize',MS)
plot(a,Ecoh_lj,'*b','MarkerSize',MS)
plot(a,Ecoh_eam,'--k','MarkerSize',MS)
plot(a,Ecoh_lj,'--b','MarkerSize',MS)
plot(eamlat,eamE,'o','MarkerSize',5.7,'MarkerFaceColor','r','MarkerEdgeColor','k')
plot(ljlat,ljE,'o','MarkerSize',5.7,'MarkerFaceColor','y','MarkerEdgeColor','b')
ylim([-5 0])
xlim([3 4.5])
lgd = legend('','','','',['EAM = ',num2str(eamlat),' ',Ang],...
    ['  LJ   = ',num2str(ljlat),' ',Ang],'Location','best');
title(lgd,'Lattice Parameter')
xlabel(['Lattice Parameter (',Ang,')'])
ylabel('Cohesive Energy (eV)')
set(gcf,'position',[400,400,450,350])

%% part 4 vacancies
% Energy min.
% EAM
% Total number of atoms = 2048
% Initial energy of atoms = -6723.82193895975
% Final energy of atoms = -6719.49088010725
% Vacancy formation energy = 1.04794267136731
% LJ
% Total number of atoms = 2048
% Initial energy of atoms = -9170.22739603237
% Final energy of atoms = -9161.30585044798
% Vacancy formation energy = 4.44389548867002

% Other method
% LJ baseline
% Etotb = -17.9106003828758;
% Nb = 4;
% ECohb = -4.47765009571895;
% Evacb = Etotb-(-Nb*ECohb);



% LJ converge
Etotlj = [-9.41278242184843 -134.329502871569 -474.630910146196...
    -1137.32312431258 -2229.86974766805 -3859.73438250981 -6134.38063113699];
N = [3 31 107 255 499 863 1371]+1;
Ecohlj = -1*[-3.13759414061614 -4.33320977005061 -4.43580289856258...
    -4.46009068357874 -4.46867684903417 -4.47246162515621 -4.47438412190882];
Evaclj = Etotlj-(-N.*Ecohlj);
% EAM converge
Etoteam = [-8.54644129249801;-99.439027184234;-345.103114375457;...
    -823.496542276313;-1612.19922070042;-2788.78846228253;-4430.84157964687].';
Ecoheam = [-2.848813764166;-3.20771055433013;-3.2252627511725;...
    -3.22939820500515;-3.23086016172429;-3.23150459128914;-3.23183193263813].';
Ecoheam = Ecoheam*-1;
Evaceam = Etoteam-(-N.*Ecoheam);
% plot
hold on
plot(N,Evaclj,'--*b',"LineWidth",1)
plot(N,Evaceam,'--*k',"LineWidth",1)
xlim([min(N) max(N)])
lgd = legend(['  LJ   =  ',num2str(Evaclj(7)),' eV'],...
    ['EAM = ',num2str(Evaceam(7)),' eV'],'Location','best');
title(lgd,'Converged Values')
xlabel('Number of Atoms')
ylabel('Vacancy Formation Energy (eV)')
set(gcf,'position',[400,400,450,350])












