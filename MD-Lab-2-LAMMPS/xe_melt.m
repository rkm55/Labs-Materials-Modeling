%% Xe melting analysis
clc; clear; close all;

%% Import log data
path(path,'C:\Users\Ryan Melander\Desktop\ME 556\Labs_ME556\MD-Lab-2-LAMMPS\xe-melting')
% Step	Temp	E_pair	TotEng	Press	c_myMSD[4]	c_myVACF[4]
T140 = importdata('140.txt','\t',1);
T140 = T140.data;
T145 = importdata('145.txt','\t',1);
T145 = T145.data;
T150 = importdata('150.txt','\t',1);
T150 = T150.data;
T155 = importdata('155.txt','\t',1);
T155 = T155.data;
T160 = importdata('160.txt','\t',1);
T160 = T160.data;
T165 = importdata('165.txt','\t',1);
T165 = T165.data;
T170 = importdata('170.txt','\t',1);
T170 = T170.data;
T175 = importdata('175.txt','\t',1);
T175 = T175.data;
T180 = importdata('180.txt','\t',1);
T180 = T180.data;

%% Caloric curve
temps = [mean(T140,1);mean(T145,1);mean(T150,1);mean(T155,1);mean(T160,1);...
    mean(T165,1);mean(T170,1);mean(T175,1);mean(T180,1)];
figure(1)
hold on
plot(temps(:,2),temps(:,4),'--b')
plot(temps(:,2),temps(:,4),'*r','MarkerSize',7.5)
xlabel('Temperature (K)')
ylabel('Total Energy (eV)')
set(gcf,'position',[400,400,470,350])
% saveas(gcf,'part6.png')

%% MSD
temps = [T140(21,2) T145(21,2) T155(21,2) T160(21,2) T150(21,2) T165(21,2)...
    T170(21,2) T175(21,2) T180(21,2)];
MSD = [T140(21,6) T145(21,6) T155(21,6) T160(21,6) T150(21,6) T165(21,6)...
    T170(21,6) T175(21,6) T180(21,6)];
figure(2)
hold on 
plot(temps,MSD,'--b')
plot(temps,MSD,'*r','MarkerSize',7.5)
xlabel('Temperature (K)')
ylabel('MSD')
set(gcf,'position',[400,400,470,350])
% saveas(gcf,'msd_1.png')

D = (1/(6*(2000*0.001)))*MSD(5:9);
Dlog = log(D);
figure(3)
hold on
plot(1./temps(5:9),Dlog,'--b')
plot(1./temps(5:9),Dlog,'*r','MarkerSize',7.5)
xlabel('1/T (K^{-1})')
ylabel('log(D)')
set(gcf,'position',[400,400,470,350])
% saveas(gcf,'msd_2.png')

%% VAF
temps = [T140(21,2) T145(21,2) T150(21,2) T155(21,2) T160(21,2) T165(21,2)...
    T170(21,2) T175(21,2) T180(21,2)];
VAF = [T140(21,7) T145(21,7) T150(21,7) T155(21,7) T160(21,7) T165(21,7)...
    T170(21,7) T175(21,7) T180(21,7)];
D = (1/3)*(2000*0.001)*VAF(5:9)*(0.001*50);
Dlog = log(D);
figure(4)
hold on
plot(1./temps(5:9),Dlog,'--b')
plot(1./temps(5:9),Dlog,'*r','MarkerSize',7.5)
xlabel('1/T (K^{-1})')
ylabel('log(D)')
set(gcf,'position',[400,400,470,350])
% saveas(gcf,'vaf_1.png')
