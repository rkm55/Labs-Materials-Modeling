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
Tinit = 500;        % Target temperature
nsteps = 10000;     % number of MD steps to simulate
dt = 0.001;         % Timestep in ps for each MD step
random_seed = 2;    % seed for random number generator

%call molecular dynamics routine
[Temperature,Energy,chainlength,time,position,velocity,forces] = ...
        molecular_dynamics(sigma,eps,amass,rinit,natoms,numNN,Tinit, ...
                           nsteps,dt,random_seed);

%Plot of temperature versus timestep
figure
subplot(3,1,1)
plot(time,Temperature)
grid minor
xlabel('Time [ps]')
ylabel('Temperature [K]')

%Plot of chain length versus timestep
subplot(3,1,2)
plot(time,chainlength)
grid minor
xlabel('Time [ps]')
ylabel('Chain Length [Angstroms]')

%Plot of chain length versus timestep
subplot(3,1,3)
plot(time,Energy)
grid minor
xlabel('Time [ps]')
ylabel('Energy [eV]')

Ang = char(197);
set(gcf,'position',[300,300,550,450])
sgtitle(['Temperature = ',num2str(Tinit),' K,  r* = ',num2str(rinit),' ',Ang],"FontSize",11)

