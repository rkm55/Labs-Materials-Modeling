clc; clear; close all;
%%% Preliminary results data

%% Total PE
d900 = importdata('5x.txt','\t',1);
d900 = d900.data;
d850 = importdata('6x.txt','\t',1);
d850 = d850.data;
d800 = importdata('7x.txt','\t',1);
d800 = d800.data;
d750 = importdata('8x.txt','\t',1);
d750 = d750.data;

t1 = d750(:,1);
t = d900(:,1);

te_900 = d900(:,7);
n_900 = d900(1,3);
te_900 = te_900/n_900;
% m_900 = mean(te_900(2001:2501));

te_850 = d850(:,7);
n_850 = d850(1,3);
te_850 = te_850/n_850;
% m_850 = mean(te_850(2001:2501));

te_800 = d800(:,7);
n_800 = d800(1,3);
te_800 = te_800/n_800;
% m_800 = mean(te_800(2001:2501));

te_750 = d750(:,7);
n_750 = d750(1,3);
te_750 = te_750/n_750;
% m_750 = mean(te_750(2001:2501));

% figure(1)
% plot(t1,te_750)
% xlabel('Step')
% ylabel('Total Energy (eV)')


figure(2)
plot(t,te_900,t,te_850,t,te_800,t1,te_750)
hold on 
% yline([m_900 m_850 m_800 m_750],'--k')
legend('900 K','850 K','800K','750 K','Location','best')
xlabel('Step')
ylabel('Total Energy Per Atom (eV)')
% ylim([-4.68e4 -4.61e4])

% Initital GB Energy
% GB energy is 919.509157468287 mJ/m^2 for all temperatures
%%
% de_900 = d900(:,8);
% de_850 = d850(:,8);
% de_800 = d800(:,8);
% de_750 = d750(:,8);
% 
% figure(2)
% plot(t,de_900,t,de_850,t,de_800,t,de_750)
% hold on 
% legend('900 K','850 K','800K','750 K','Location','best')
% xlabel('Time (ps)')
% ylabel('Density')

















