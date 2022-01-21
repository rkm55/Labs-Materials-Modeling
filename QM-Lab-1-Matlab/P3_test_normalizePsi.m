% Modeling Materials (ME EN 556) - QM Lab 1 - P3
clc; clear;

%%
%space over which to define the initial conditions - note that this is from
%   0 to just over 1. This is because we will enforce even or odd 
%   conditions and only solve over half the space 0 to 1.
x=0:.05:1.1;

%simulated wave function for testing
psi=0.5*cos(x*pi/2);

%normalize the wave function
[psi,prob]=normalizePsi(x,psi);

%%
plot(x,psi)