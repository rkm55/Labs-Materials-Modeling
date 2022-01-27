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

%% (7) convergence graphite
LISTECUT = [10 20 30 40 50 60 70 80 90 100 110 120 130 140];
x = 4.64-0.13:0.01:4.64+0.13;

%% (7) final
clc; clear; close all;
% volume/atom, 2 atoms (au^3)
VC = (1/2)*[70.2528 70.5751 70.8983 71.2226 71.5478 71.8740 72.2012 72.5294 ...
    72.8586 73.1887 73.5199 73.8521 74.1852 74.5194 74.8546 75.1908 ...
    75.5279 75.8661 76.2053 76.5455 76.8867 77.2289 77.5722 77.9164 ...
    78.2617 78.6080];
EC = [-22.79817760 -22.79873896 -22.79923822 -22.79968064 ...
    -22.80008163 -22.80042424 -22.80071809 -22.80096393 -22.80115577 ...
    -22.80130010 -22.80139393 -22.80143863 -22.80143608 -22.80138541 ...
    -22.80129726 -22.80114653 -22.80096646 -22.80073052 -22.80044826 ...
    -22.80012357 -22.79976021 -22.79934243 -22.79890447 -22.79840860 ...
    -22.79787533 -22.79730051];

Ag = [4.51 4.52 4.53 4.54 4.55 4.56 4.57 4.58 4.59 4.60 4.61 4.62 4.63 ...
    4.64117 4.65 4.66 4.67 4.68 4.69 4.70 4.71 4.72 4.73 4.74 4.75 4.76 4.77];
% Vg = 
% Eg = 

plot(VC,EC)

%% (8)





































