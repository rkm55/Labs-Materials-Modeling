% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida) 
clear; clc; close all;

%setup atom related variables
amass = 0.01;       % kinetic mass

%setup simulation variables
natoms = 50;        % number of atoms to simulate in 1D chain 
rinit = 2.618;      % initial spacing of atoms
Tinit = 100;        % Target temperature
random_seed = 2;    % seed for random number generator

%initialize x positions and velocity vector and initial temperature
[x,v,temp]=initialize_MD(natoms, rinit, Tinit, amass, random_seed);
