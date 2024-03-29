%%% QM Lab 2 plots %%%
%   Ryan Melander
%   ME 556

%% (1)
clc; clear; close all;
% 2 atoms/cell
% k points = 8;
% 10 meV/cell
% 1 Rydberg = 13.6056981 eV
convergence = -0.01/13.6056981;

LISTECUT = [10 20 30 40 50 60 70 80 90 100 110 120 130 140];
total_energies = [-21.03420627 -22.17328683 -22.51880972 -22.68597058 ...
    -22.74709110 -22.77032856 -22.78219846 -22.78744251 -22.78943624 ...
    -22.79051194 -22.79107400 -22.79137231 -22.79151125 -22.79157949];

c = 1;
difference = zeros(1,13);
for i = 1:13
    difference(i) = total_energies(i+1) - total_energies(i);
    if difference(i) > convergence && c == 1
        con_val = LISTECUT(i+1);    % value when converged
        c = 0;
    end
end

plot(LISTECUT,total_energies,'LineWidth',1)
xlim([0 LISTECUT(14)+10])
ylabel('Total Energy (Ryd)')
xlabel('Cutoff Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (2)
clc; clear; close all;
% LISTECUT = 110;
convergence = -0.01/13.6056981;

k = [1 2 3 4 5 6 7 8];
kgrid = [1 3 4 8 10 16 20 29];
total_energies = [-20.48431805 -22.55614457 -22.75688985 -22.79107400 ...
    -22.79861256 -22.80049496 -22.80100682 -22.80114746];

c = 1;
difference = zeros(1,7);
for i = 1:7
    difference(i) = total_energies(i+1) - total_energies(i);
    if difference(i) > convergence && c == 1
        con_val = kgrid(i+1);    % value when converged
        c = 0;
    end
end

plot(kgrid,total_energies,'LineWidth',1)
xlim([0 30])
ylabel('Total Energy (Ryd)')
xlabel('Grid Size')
set(gcf,'position',[400,400,450,350])

%% (3)
clc; clear; close all;
% k = 4;
% 10 meV/Angstrom
% 1 Ry/Bohr = 25.71104309541616 eV/Angstrom
convergence = 0.01/25.71104309541616;

LISTECUT = [10 20 30 40 50 60 70 80 90 100 110 120 130 140];
FA1 = [0.20556752 0.40355051 0.25834926 0.29147473 0.28832892 ...
    0.27621070 0.27980131 0.28088352 0.27966004 0.27938862 ...
    0.27963845 0.27968423 0.27961356 0.27959566];

c = 1;
difference = zeros(1,13);
for i = 1:13
    difference(i) = FA1(i+1) - FA1(i);
    if abs(difference(i)) < convergence && c == 1
        con_val = LISTECUT(i+1);    % value when converged
        c = 0;
    end
end

plot(LISTECUT,FA1,'LineWidth',1)
xlim([0 140])
ylim([0.18 0.42])
ylabel('Force on Atom 1 (Ryd/Bohr)')
xlabel('Cutoff Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (4)
clc; clear; close all;
% 2 atoms/cell
% 10 meV/cell
% 1 Rydberg = 13.6056981 eV
convergence = 0.01/13.6056981;

% k = 4;
LISTECUT = [10 20 30 40 50 60 70 80 90 100 110 120 130 140];
a1 = 6.74; % bohr
a2 = 6.70; % bohr
cut1 = [-21.08699660 -22.20304723 -22.52557478 -22.68939249 ...
    -22.74888419 -22.77094233 -22.78279451 -22.78739176 ...
    -22.78949431 -22.79055477 -22.79112924 -22.79139952 ...
    -22.79153023 -22.79160070];
cut2 = [-21.08938072 -22.20314918 -22.52524752 -22.68718743 ...
    -22.74962854 -22.77195737 -22.78351633 -22.78836260 ...
    -22.79041714 -22.79149039 -22.79205462 -22.79233173 ...
    -22.79246583 -22.79253683];
cutdiff = abs(cut1-cut2);

c = 1;
difference = zeros(1,13);
for i = 1:13
    difference(i) = cutdiff(i+1) - cutdiff(i);
    if i > 3 && abs(difference(i)) < convergence && c == 1
        con_val = LISTECUT(i+1);    % value when converged
        c = 0;
    end
end
difference = abs(difference);

plot(LISTECUT,cutdiff,'LineWidth',1)
ylabel('Total Energy Difference (Ryd)')
xlabel('Cutoff Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (6)
clc; clear; close all;
% LISTECUT = [100];
% k = 7;
A = [6.55 6.56 6.57 6.58 6.59 6.60 6.61 6.62 6.63 6.64 6.65 6.66 6.67 ...
    6.68 6.69 6.70 6.71 6.72 6.73 6.74 6.75 6.76 6.77 6.78 6.79 6.80];
total_energies = [-22.79817760 -22.79873896 -22.79923822 -22.79968064 ...
    -22.80008163 -22.80042424 -22.80071809 -22.80096393 -22.80115577 ...
    -22.80130010 -22.80139393 -22.80143863 -22.80143608 -22.80138541 ...
    -22.80129726 -22.80114653 -22.80096646 -22.80073052 -22.80044826 ...
    -22.80012357 -22.79976021 -22.79934243 -22.79890447 -22.79840860 ...
    -22.79787533 -22.79730051];

[cbest,ci] = min(total_energies);
p = polyfit(A,total_energies,2);
x = 6.55:0.0001:6.80;
pfit = p(1).*x.^2 + p(2).*x + p(3);
[pfitbest,pi] = min(pfit);

scatter(A,total_energies,'*','k')
hold on
plot(x,pfit)
lgd = legend(['Calculated = ',num2str(A(ci)),' Bohr'],...
    ['Best fit = ',num2str(x(pi)),' Bohr'],...
    'Location','best');
title(lgd,'Equilibrium Lattice Constant')
xlabel('Lattice Constant (Bohr)')
ylabel('Total Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (6) Bulk Mod.
V0 = 73.8521/2;
V = (1/2)*[73.5199 73.8521 74.1852];
dV1 = V(2)-V(1);
dV2 = V(3)-V(2);
E = (1/2)*[-22.80139393 -22.80143863 -22.80143608];
dE1 = E(2)-E(1);
dE2 = E(2)-E(3);
P1 = -dE1/dV2;
P2 = -dE2/dV2;
dP = P2-P1;
bulk_mod = -V0*(dP/(V(3)-V(1)));
% 1 Ryd/bohr3 = 14,710.5076 GPa.
bulk_mod = 14710.5076*bulk_mod;

%% (7)
clc; clear; close all;
% volume/atom, 2 atoms (au^3)
VC = (1/2)*[70.2528 70.5751 70.8983 71.2226 71.5478 71.8740 72.2012 72.5294 ...
    72.8586 73.1887 73.5199 73.8521 74.1852 74.5194 74.8546 75.1908 ...
    75.5279 75.8661 76.2053 76.5455 76.8867 77.2289 77.5722 77.9164 ...
    78.2617 78.6080];
EC = (1/2)*[-22.79817760 -22.79873896 -22.79923822 -22.79968064 ...
    -22.80008163 -22.80042424 -22.80071809 -22.80096393 -22.80115577 ...
    -22.80130010 -22.80139393 -22.80143863 -22.80143608 -22.80138541 ...
    -22.80129726 -22.80114653 -22.80096646 -22.80073052 -22.80044826 ...
    -22.80012357 -22.79976021 -22.79934243 -22.79890447 -22.79840860 ...
    -22.79787533 -22.79730051];

Ag = [4.51 4.52 4.53 4.54 4.55 4.56 4.57 4.58 4.59 4.60 4.61 4.62 4.63 ...
    4.64117 4.65 4.66 4.67 4.68 4.69 4.70 4.71 4.72 4.73 4.74 4.75 4.76 4.77];
% 4 atoms/cell 
Vg = (1/4)*[216.5957 218.0397 219.4900 220.9468 222.4100 223.8797 225.3558 ...
    226.8384 228.3275 229.8231 231.3252 232.8339 234.3490 236.0493 ...
    237.3991 238.9340 240.4755 242.0236 243.5784 245.1398 246.7078 ...
    248.2826 249.8640 251.4521 253.0469 254.6485 256.2568];
Eg = (1/4)*[-45.86523983 -45.86820751 -45.87094658 -45.87346085 -45.87539665 ...
    -45.87747103 -45.87933139 -45.88098111 -45.88242321 -45.88366202 ...
    -45.88470045 -45.88554177 -45.88618925 -45.88668734 -45.88691562 ...
    -45.88700071 -45.88690458 -45.88663023 -45.88618073 -45.88555894 ...
    -45.88476792 -45.88381041 -45.88268930 -45.88140586 -45.87996593 ...
    -45.87837065 -45.87662281];
[lE,Ei] = min(Eg);
lcg = Ag(Ei);

% colororder({'k','b'})
% yyaxis left
plot(VC,EC,'LineWidth',1)
ylabel('Diamond Total Energy per atom (Ryd)')
% yyaxis right
hold on
plot(Vg,Eg,'LineWidth',1)
ylabel('Graphite Total Energy per atom (Ryd)')
hold on
xlim([30 70])
legend('Diamond','Graphite','Location','best');
xlabel('Volume per atom (a.u.^{3})')
set(gcf,'position',[400,400,450,350])

%% (9) part 1
clc; clear; close all;
% lattice parameter BaTiO3
a = 7.40:0.02:7.70;
E = [-303.68029067 -303.68224666 -303.68385471 -303.68490877 ...
    -303.68565090 -303.68618725 -303.68654591 -303.68642670 ...
    -303.68625651 -303.68536164 -303.68439934 -303.68331371 ...
    -303.68187165 -303.68015210 -303.67821172 -303.67594440];
[Emin,Ei] = min(E);
lc = a(Ei);

p = polyfit(a,E,2);
pfit = p(1).*a.^2 + p(2).*a + p(3);
[pfitbest,pi] = min(pfit);
lc_pfit = a(pi);

scatter(a,E,'*','k')
hold on
plot(a,pfit)
lgd = legend('Calculated','Best fit','Location','best');
xlabel('Lattice Constant (Bohr)')
ylabel('BaTiO_{3} Total Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (9) part 2
clc; clear; close all;
% Displace Ti atoms
disp = (1/1000)*([502 502 504 504 504 504 506 506 506 506 506 506 506 506 506 506 ...
    506 506 506 506 508 508 508 508 508 508 508 508 508 508 508 508 508 ...
    510 510 510 510 510 510 510 510 510 510 510 510 512 512 512 512 512 ...
    512 512 512 512 512 512 512 514 514 514 514 514 514 514 514 514 514 ...
    514 514 516 516 516 516 516 516 516 516 516 516 516 518 518 518 518 ...
    518 518 518 518 518 518 518 520 520 520 520 520 520 520 520 520 520]-500);
E = [-303.68654032 -303.68654188 -303.68652638 -303.68653273 -303.68653772 ...
    -303.68654233 -303.68650849 -303.68652267 -303.68653384 -303.68654445 ...
    -303.68655230 -303.68655892 -303.68656782 -303.68658261 -303.68660483 ...
    -303.68663543 -303.68669064 -303.68677730 -303.68687987 -303.68690724 ...
    -303.68648771 -303.68651243 -303.68653187 -303.68655040 -303.68656499 ...
    -303.68657678 -303.68659247 -303.68661758 -303.68665518 -303.68672615 ...
    -303.68681924 -303.68689158 -303.68691665 -303.68646185 -303.68649915 ...
    -303.68652826 -303.68655568 -303.68657614 -303.68659161 -303.68661236 ...
    -303.68664574 -303.68670035 -303.68680076 -303.68687170 -303.68690990 ...
    -303.68642767 -303.68647888 -303.68651838 -303.68655473 -303.68657853 ...
    -303.68659567 -303.68661915 -303.68665712 -303.68671964 -303.68681806 ...
    -303.68686481 -303.68688177 -303.68638256 -303.68644846 -303.68649865 ...
    -303.68654312 -303.68656705 -303.68658451 -303.68660872 -303.68664755 ...
    -303.68670922 -303.68679240 -303.68682168 -303.68682723 -303.68632510 ...
    -303.68640597 -303.68646660 -303.68651763 -303.68653904 -303.68655604 ...
    -303.68657972 -303.68661705 -303.68667196 -303.68673474 -303.68674737 ...
    -303.68625489 -303.68635023 -303.68642049 -303.68647576 -303.68649283 ...
    -303.68650895 -303.68653115 -303.68656491 -303.68660695 -303.68664322 ...
    -303.68664655 -303.68617137 -303.68627973 -303.68635801 -303.68641454 ...
    -303.68642643 -303.68644162 -303.68646172 -303.68648992 -303.68651440 ...
    -303.68652616];

[Emin,i] = min(E);

scatter(disp,E,'*','k')
xlabel('Ti Displacement')
ylabel('BaTiO_{3} Total Energy (Ryd)')
set(gcf,'position',[400,400,450,350])

%% (9) part 3
clc; clear; close all;
% Displace Ti & O atoms
final_energy = 1943.38655354;
% ATOMIC_POSITIONS (alat)
% Ba            0.0000000000        0.0000000000        0.0000000000
% Ti            0.5000000000        0.5000000000        0.0744893156
% O             0.5000000000        0.5000000000       -0.0664893617
% O             0.5000000000        0.0000000000        0.5000000139
% O             0.0000000000        0.5000000000        0.5000000139

pos = [0.0000000000 0.0000000000 0.0000000000;...
    0.5000000000 0.5000000000 0.0744893156;...
    0.5000000000 0.5000000000 -0.0664893617;...
    0.5000000000 0.0000000000 0.5000000139;...
    0.0000000000 0.5000000000 0.5000000139];

scatter3(pos(:,1),pos(:,2),pos(:,3),'*','k')
