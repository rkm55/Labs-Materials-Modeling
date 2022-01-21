% Modeling Materials (ME EN 556) - QM Lab 1 - P2

%space over which to define the initial conditions - note that this is from
%   0 to just over 1. This is because we will enforce even or odd 
%   conditions and only solve over half the space 0 to 1.
x=0:.01:1.1;

%define whether the desired solution should be even or odd
%1 for even, -1 for odd
evenodd=-1; 

%call the function to define the initial conditions
psi=initPsi(evenodd,x);
