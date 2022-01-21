% Modeling Materials (ME EN 556) - QM Lab 1 - P4
clc; clear; close all;
%define whether the desired solution should be even or odd
%1 for even, -1 for odd
evenodd=1;

%potential well depth
V = logspace(-1,5,10);
PV = zeros(2,111,length(V));
for i = 1:length(V)
    Vmax= V(i);
    
    %define how many solutions (even or odd) you wish to find
    Nsolutionstofind=2;
    
    %determines wether an iterative figure will show the evolution of the
    %   solution using the shooting method
    showplot=false;
    
    %call the function to find the first N solutions - using mostly default
    %values for dE, maxIter, and convergence energy values
    [energyvalues,psivalues,probvalues,x]=findfirstNsolutions(evenodd,Vmax,Nsolutionstofind,[],[],[],showplot);
    PV(:,:,i) = probvalues;
end
x = [-1*flip(x) x];
PV = [flip(PV,2) PV];

%% Plot data (psi)
close all;

if evenodd == 1
    psi1 = [flip(psivalues(1,:)) psivalues(1,:)];
    psi2 = [flip(psivalues(2,:)) psivalues(2,:)];
    psi3 = [flip(psivalues(3,:)) psivalues(3,:)];
elseif evenodd == -1
    psi1 = [-1*flip(psivalues(1,:)) psivalues(1,:)];
    psi2 = [-1*flip(psivalues(2,:)) psivalues(2,:)];
    psi3 = [-1*flip(psivalues(3,:)) psivalues(3,:)];
end
if evenodd == 1
    EO = 'Even';
elseif evenodd == -1
    EO = 'Odd';
end

figure(1)
plot(x,psi1,x,psi2,x,psi3,'LineWidth',1)
xlim([-1 1])
ylim([-1.25 1.75])
hold on
z = zeros(1,size(psi1,2));
plot(x,z,'LineStyle','--','Color','k')
title(['First ',num2str(Nsolutionstofind),' ',EO,' Wave Function Solutions'])
legend('N=1','N=2','N=3','')

%% Plot data (prob)

if evenodd == 1
    prob1 = [flip(probvalues(1,:)) probvalues(1,:)];
    prob2 = [flip(probvalues(2,:)) probvalues(2,:)];
    prob3 = [flip(probvalues(3,:)) probvalues(3,:)];
elseif evenodd == -1
    prob1 = [flip(probvalues(1,:)) probvalues(1,:)];
    prob2 = [flip(probvalues(2,:)) probvalues(2,:)];
    prob3 = [flip(probvalues(3,:)) probvalues(3,:)];
end
if evenodd == 1
    EO = 'Even';
elseif evenodd == -1
    EO = 'Odd';
end

figure(2)
plot(x,prob1,x,prob2,x,prob3,'LineWidth',1)
xlim([-1 1])
ylim([0 1.5])
hold on
z = zeros(1,size(prob1,2));
plot(x,z,'LineStyle','--','Color','k')
title(['First ',num2str(Nsolutionstofind),' ',EO,' Probability Densities'])
legend('N=1','N=2','N=3','')

%% EV plot
if evenodd == 1
    EO = 'Even';
elseif evenodd == -1
    EO = 'Odd';
end

semilogx(V,EV(1,:),V,EV(2,:),'LineWidth',1.1)
title(['First ',num2str(Nsolutionstofind),' ',EO,' Energy Levels'])
legend('N=1','N=2','Location','best')
xlabel('Potential Well Depth')
ylabel('Energy')
xlim([min(V) max(V)])
ylim([0 20])

%% energy (k,E)

n = 3;
L = 2;
ko = zeros(3,1);
E = zeros(3,1);
for i = 1:n
    ko(i,1) = (2*i*pi)/L;
    E(i,1) = ko(i,1)^2/2;
end

%% prob even 

elevel = 2;
plot(x,PV(elevel,:,1),"LineWidth",1.2);
hold on
xlim([-1.2 1.2])
ylim([0 1.1])

for i = 2:size(PV,3)-1
    plot(x,PV(elevel,:,i),LineStyle="--",Color='k')
end
plot(x,PV(elevel,:,size(PV,3)),'LineWidth',1.2)
leg = legend(num2str(V(1)),'','','','','','','','',num2str(V(10)),'Location','best');
title('Probability Desnity Even Energy Level 2')
title(leg,'Well Depth')



