%% MS Lab2
clear; clc; close all;

%% Tutorial 2
alj = [3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0...
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
figure(1)
plot(alj,Etotlj,'*k','MarkerSize',5)
lgd = legend(['Minimum Energy = ',num2str(alj(Ei)),' ',Ang],...
    'Location','best');
title(lgd,'Equilibrium Lattice Parameter')
xlabel(['Lattice Parameter (',Ang,')'])
ylabel('Total Energy (eV)')
set(gcf,'position',[400,400,450,350])

%% 3 part ii
% LJ and EAM
alj = 2.5:0.1:4.5;
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
figure(2)
hold on
plot(alj,Ecoh_eam,'*k','MarkerSize',MS)
plot(alj,Ecoh_lj,'*b','MarkerSize',MS)
plot(alj,Ecoh_eam,'--k','MarkerSize',MS)
plot(alj,Ecoh_lj,'--b','MarkerSize',MS)
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
Etoteam = [-8.39909547923335;-100.710747827532;-350.228703976327;...
    -836.129898783895;-1637.21024698046;-2832.26453691161;-4500.08755692957].';
Ecoheam = [-2.79969849307778;-3.24873380088813;-3.27316545772268;...
    -3.27894077954469;-3.28098245887868;-3.28188242979329;-3.28233957471158].';

Ecoheam = Ecoheam*-1;
Evaceam = Etoteam-(-N.*Ecoheam);
% plot
figure(3)
hold on
plot(N,Evaclj,'--*b',"LineWidth",1)
plot(N,Evaceam,'--*k',"LineWidth",1)
xlim([min(N) max(N)])
ylim([2.7 4.7])
lgd = legend(['  LJ   =  ',num2str(Evaclj(7)),' eV'],...
    ['EAM = ',num2str(Evaceam(7)),' eV'],'Location','best');
title(lgd,'Converged Values')
xlabel('Number of Atoms')
ylabel('Vacancy Formation Energy (eV)')
set(gcf,'position',[400,400,450,350])

%% prob 5 surface energy

% all for LJ
% Before removing planes
% Total energy (eV) = -6143.33593132844;
% Number of atoms = 1372;
% Lattice constant (Angstoms) = 24.738;
% Cohesive energy (eV) = -4.47765009572044;

alj = 3.534;
rep = 5:20;
Alj = (alj*rep).^2;
Etotlj = [-1398.88840496232;-2659.18091692933;-4497.06011124846;...
    -7019.98959021845;-10335.4329561355;-14550.8538112968;...
    -19773.7157579917;-26111.4823985184;-33671.6173351765;...
    -42561.5841702479;-52888.8465060433;-64760.8679448598;...
    -78285.1120888072;-93569.0425403321;-110720.122901741;-129845.81677533].';
N = 4*(rep.^3);
Ncutlj = [350;648;1078;1664;2430;3400;4598;6048;7774;9800;12150;14848;17918;...
21384;25270;29600].';
Ecohlj = -1*[-3.99682401417806;-4.10367425452057;-4.17166986201156;...
    -4.21874374412166;-4.25326459100226;-4.27966288567553;...
    -4.30050364462629;-4.31737473520476;-4.3313117230739;...
    -4.34301879288244;-4.35299148197887;-4.36158862775187;...
    -4.36907646438259;-4.37565668445249;-4.38148487937242;...
    -4.38668299916655].';
Esurflj = (Etotlj-(-N.*Ecohlj))./(2*Alj);

aeam = 3.639;
rep = 5:20;
Aeam = (aeam*rep).^2;
Etoteam = [-1103.75928400235;-2062.18209904569;-3450.34973964758;...
    -5347.05699415713;-7831.09865092056;-10981.2694982834;...
    -14876.3643246443;-19595.1779183246;-25216.5050676094;...
    -31819.1405607947;-39481.879186378;-48283.515732664;...
    -58302.8449883235;-69618.6617416023;-82309.7607802033;...
    -96454.9368929016].';
N = 4*(rep.^3);
Ecoheam = -1*[-3.15359795429243;-3.18237978247792;-3.20069549132429;...
    -3.2133755974502;-3.22267434194262;-3.22978514655394;-3.23539893967906;...
    -3.23994343887642;-3.24369759037939;-3.24685107763211;-3.2495373815949;...
    -3.25185316087446;-3.25387012994327;-3.25564261792005;-3.25721253582126;...
    -3.2586127328683].';

Esurfeam = (Etoteam-(-N.*Ecoheam))./(2*Aeam);

Ang = char(197);
figure(4)
plot(N,Esurflj,'--*b',"LineWidth",1)
hold on
plot(N,Esurfeam,'--*k',"LineWidth",1)
xlim([min(N) max(N)])
lgd = legend(['  LJ   =  ',num2str(round(Esurflj(16),3)),' eV/',Ang,'^{2}'],...
    ['EAM = ',num2str(round(Esurfeam(16),3)),' eV/',Ang,'^{2}'],'Location','best');
title(lgd,'Surface Energy')
xlabel('Number of Atoms')
ylabel(['Surface Energy (eV/',Ang,'^{2})'])
set(gcf,'position',[400,400,450,350])
