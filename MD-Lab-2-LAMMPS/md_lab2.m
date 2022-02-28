%% MD-Lab2 LAMMPS
clear; clc; close all;

%% Tutorial 3
path(path,'C:\Users\Ryan Melander\Desktop\ME 556\Labs_ME556\MD-Lab-2-LAMMPS\tutorial 3 files')
A = importdata('Al_SC_100.def1.txt',' ',1);
A = A.data;
strain = A(:,1);
stress = A(:,2:4);
hold on
for i = 1:1
    figure(1)
    plot(strain,stress(:,i),'-o','MarkerSize',2,'LineWidth',1.5)
end
FS = 10;
text(strain(1,1),stress(1,1)+1,'(1)',Clipping='on',FontSize=FS,FontWeight='bold')
text(strain(75,1),stress(75,1)+1,'(2)',Clipping='on',FontSize=FS,FontWeight='bold')
text(strain(150,1),stress(150,1)+0.5,'(3)',Clipping='on',FontSize=FS,FontWeight='bold')
text(strain(165,1),stress(165,1)+1,'(4)',Clipping='on',FontSize=FS,FontWeight='bold')
text(strain(191,1),stress(191,1)+1,'(5)',Clipping='on',FontSize=FS,FontWeight='bold')
xlabel('Strain')
ylabel('Stress (GPa)')
xlim([0 0.2])
ylim([0 10])
set(gcf,'position',[400,400,450,350])
% saveas(gcf,'tutorial-3.png')

%% Tutorial 5
% ovito figure

%% Part 3
path(path,'C:\Users\Ryan Melander\Desktop\ME 556\Labs_ME556\MD-Lab-2-LAMMPS\part-3')
% 125 K
E125 = importdata('125K.txt','\t',2);
E125 = E125.data;
E125 = E125(:,1:3);
E125totavg = sum(E125,1)/101;
tstep = [0.0001 0.001 0.01];
S125 = std(E125,0,1);
% 150 K
E150 = importdata('150K.txt','\t',2);
E150 = E150.data;
E150totavg = sum(E150,1)/101;
S150 = std(E150,0,1);
% 175 K
E175 = importdata('175K.txt','\t',2);
E175 = E175.data;
E175totavg = sum(E175,1)/101;
S175 = std(E175,0,1);
LW = 0.7;
figure(2)
hold on
semilogx(tstep,E125totavg,'--ob','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','b')
semilogx(tstep,E150totavg,'--or','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','r')
semilogx(tstep,E175totavg,'--ok','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','k')
xlabel('Timestep (ps)')
ylabel('Average Total Energy (eV)')
lgd = legend('125 K','150 K','175 K');
title(lgd,'Temperature')
set(gcf,'position',[400,400,450,350])
% saveas(gcf,'part3_1.png')
figure(3)
hold on
semilogx(tstep,S125,'--ob','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','b')
semilogx(tstep,S150,'--or','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','r')
semilogx(tstep,S175,'--ok','MarkerSize',5,'LineWidth',LW,'MarkerFaceColor','k')
xlabel('Timestep (ps)')
ylabel('Standard Deviation')
lgd = legend('125 K','150 K','175 K');
title(lgd,'Temperature')
set(gcf,'position',[400,400,450,350])
% saveas(gcf,'part3_2.png')

%% part 4
path(path,'C:\Users\Ryan Melander\Desktop\ME 556\Labs_ME556\MD-Lab-2-LAMMPS\part-4')
n2 = importdata('n2.txt','\t',2);
n2 = n2.data;
n2 = var(n2,0,1);
n4 = importdata('n4.txt','\t',2);
n4 = n4.data;
n4 = var(n4,0,1);
n6 = importdata('n6.txt','\t',2);
n6 = n6.data;
n6 = var(n6,0,1);
n8 = importdata('n8.txt','\t',2);
n8 = n8.data;
n8 = var(n8,0,1);
n10 = importdata('n10.txt','\t',2);
n10 = n10.data;
n10 = var(n10,0,1);

na = 1./[32 256 864 2048 4000];
tv = [n2;n4;n6;n8;n10].';

figure(4)
hold on
for i = 1:12
   semilogx(na,tv(i,:),'--o','MarkerSize',3.5,'LineWidth',0.6)
end
legend('125','130','135','140','145','150','155','160','165','170','175','180'...
    ,'Location','northwest')
xlabel('1/Number of Atoms')
ylabel('Temperature Variance')
set(gcf,'position',[400,400,550,400])
% saveas(gcf,'part4.png')


















