% Modeling Materials (ME EN 556) - QM Lab 1 - test_shooting

%Play around with these values to see how the affect the solution

%define whether the desired solution should be even or odd
%1 for even, -1 for odd
evenodd=1;

%potential well depth
Vmax=1e5; %You can play around with this now, but you'll change it later in a problem

%starting guess of energy - raise initial guess to search for higher numbers
energy =0.5; 


%%% values which can be left empty (e.g. val=[];) so function will use a
%%%     default value

%amount by which the shooting method increases its guess on each iteration
de = [];            % default is initial energy guess/10
%amount by which the solution energy must converge to satisfy convergence
convergence = [];   % default is 1e-5;
%max number of allowed iterations, if not converged by then, it aborts
maxIter = [];       % default is 100
%determines wether an iterative figure will show the evolution of the
%   solution using the shooting method
showplot=true; % default is false, but helpful in seeing method. Do not set to true in MATLAB GRADER


%space over which to define the initial conditions - note that this is from
%   0 to just over 1. This is because we will enforce even or odd 
%   conditions and only solve over half the space 0 to 1.
x=0:.01:1.1;

%call the shooting method - will plot the wave function if showplot = true
[psi,energy]=shooting(evenodd,x,Vmax,energy,de,convergence,maxIter,showplot);
