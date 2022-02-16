% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida) 

%setup atom related variables
sigma = 2.338;      % LJ sigma parameter
eps = 2.4096;       % LJ epsilon parameter

r=2.5;

%calculate the force and energy using the Lennard Jones potential
[energy,force]=lennard_jones(r,eps,sigma);
