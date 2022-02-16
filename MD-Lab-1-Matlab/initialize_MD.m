function [x,v,temp]=initialize_MD(natoms, rinit, Tinit, amass, randseed)
% initialize_MD - function to initialize the positions, temperature and
%                 velocity of a 1D array of atoms.
%
% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida)

    %Boltzmann's constant
    boltz = 8.62E-5;

    %set the random seed
    rng(randseed);

    %Create a 1D chain of atoms
    %Use "x" as a vector of atom positions (dimension 1*natoms)
    x = 0:rinit:rinit*(natoms-1);

    %Assign initial velocities randomly to each atom in chain
    %Adjust initial velocities to meet desired temperature
    %Use "v" as a vector of atom velocities (dimension 1*natoms)
    %Use "temp" to store the temperature of the system
    %Use the matlab function "rand" to generate random numbers
    v = rand(1,natoms)-0.5;
    Pcom = sum(amass*v,'all');
    v = v - Pcom/(amass*natoms);
    % make sure you include a factor of 2 to fix KE+PE partitioning
    temp = amass*sum(v.^2)/(boltz*natoms);
    v = v*sqrt((2*Tinit)/temp);
    temp = amass*sum(v.^2)/(boltz*natoms);
end
