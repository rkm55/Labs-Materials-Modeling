% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida) 
clear; clc; close all;
%setup atom related variables
sigma = 2.338;      % LJ sigma parameter
eps = 2.4096;       % LJ epsilon parameter
amass = 0.01;       % kinetic mass

%setup simulation variables
natoms = 50;        % number of atoms to simulate in 1D chain 
numNN = 2;          % number of nearest neighbors to include in calculation
rinit = 3;     % initial spacing of atoms
Tinit = [100 300 500];        % Target temperature
nsteps = 10000;     % number of MD steps to simulate
dt = 0.001;         % Timestep in ps for each MD step
random_seed = 1;    % seed for random number generator

N = 3;

%call molecular dynamics routine
Temperature = zeros(nsteps+1,3);
Energy = zeros(nsteps+1,3);
chainlength = zeros(nsteps+1,3);
for i = 1:N 
    [Temperature(:,i),Energy(:,i),chainlength(:,i),time,position,velocity,forces] = ...
        molecular_dynamics(sigma,eps,amass,rinit,natoms,numNN,Tinit(i), ...
                           nsteps,dt,random_seed);
end

%Plot of temperature versus timestep
figure
subplot(3,1,1)
hold on
for i = 1:N
    plot(time,Temperature(:,i))
end
grid minor
xlabel('Time [ps]')
ylabel('Temperature [K]')
legend('100 K', '300 K','500 K','Location','northeast')

%Plot of chain length versus timestep
subplot(3,1,2)
hold on
for i = 1:N
    plot(time,chainlength(:,i))
end
grid minor
xlabel('Time [ps]')
ylabel('Chain Length [Angstroms]')

%Plot of chain length versus timestep
subplot(3,1,3)
hold on
for i = 1:N
    plot(time,Energy(:,i))
end
grid minor
xlabel('Time [ps]')
ylabel('Energy [eV]')

Ang = char(197);
set(gcf,'position',[300,300,550,450])
sgtitle(['Temperature = ',num2str(Tinit),' K,  r* = ',num2str(rinit),' ',Ang],"FontSize",11)

