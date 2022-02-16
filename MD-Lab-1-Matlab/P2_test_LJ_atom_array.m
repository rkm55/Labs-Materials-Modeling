% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida) 

%setup atom related variables
sigma = 2.338;      % LJ sigma parameter
eps = 2.4096;       % LJ epsilon parameter

%setup simulation variables
natoms = 50;        % number of atoms to simulate in 1D chain 
numNN = 2;          % number of nearest neighbors to include in calculation
rinit = 2.618;      % initial spacing of atoms

%Create a 1D chain of atoms
%Use "x" as a vector of atom positions (dimension 1*natoms)
x = 0:rinit:rinit*(natoms-1);

%call LJ_atom_array to get total energy, force row vector, & chainlength
[Etotal,f,chainlen]=LJ_atom_array(x,eps,sigma,numNN);
