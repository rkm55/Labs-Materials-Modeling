clc; clear; close all;

r=2.5;          % angstroms
sigma=2.338;    % angstroms
epsilon=2.4096; % eV

[energy,force]=lennard_jones(r,epsilon,sigma);