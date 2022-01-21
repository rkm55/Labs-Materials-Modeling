function [energyvalues,psivalues,probvalues,x]=findfirstNsolutions(evenodd,Vmax,N,de,convergence,maxIter,showplot)
%findfirstNsolutions - function returns the first even or odd N energy 
%    levelsand wave functions for a particle in a box
%
%   Input:
%   evenodd - scalar; 1 for even solutions, -1 for odd solutions
%   Vmax - scalar; potential energy surrounding the box
%   N - scalar; number of energy levels and wave functions expected
%   de - set how much to increase/decrease energy as it iterates, leave 
%        empty to use default value
%   convergence - minimum energy difference between iterations to determine
%                 if solution is converged, leave empty to use default value
%   maxIter - max iterations to try before giving up, leave empty to use 
%             default value
%   showplot - bool to determine whether an updating plot should be shown
%              to illustrate the convergence process, leave empty to use 
%              default value - *** ONLY SET TO TRUE OUTSIDE MATLAB GRADER
%
%   Output:
%   energyvalues - N by 1 array of energy values corresponding to the first
%                  N energy levels
%   psivalues - N by length(x) matrix where each row is the wave vector 
%               corresponding to the energy level in energy values
%   probvalues - N by length(x) matrix where each row is the probability 
%                density corresponding to the energy level in energy values
% 
% This function will call the shooting function
%
% Modeling Materials (ME EN 556) - QM Lab 1

    if nargin < 4 || isempty(de)
        de=[];%set as empty so it can take the default value in the shooting method
    end
    
    if nargin < 5 || isempty(convergence)
        convergence=[];%set as empty so it can take the default value in the shooting method
    end
    
    if nargin < 6 || isempty(maxIter)
        maxIter=[];%set as empty so it can take the default value in the shooting method
    end
    
    if nargin < 7 || isempty(showplot)
        showplot=[];
    end
    
    %fixed range of x to simplify coding and solutions
    x=0:0.01:1.1;       %define range of x, only need half the space, evenodd will account for other half
    
    %setup arrays for output values
    energyvalues = zeros(N,1);
    psivalues = zeros(N,length(x));
    probvalues = zeros(N,length(x));
    
    %set an initial energy guess
    energy=1;
    
    for i=1:N
        
        %call the shooting method
        [psi,energy]=shooting(evenodd,x,Vmax,energy,de,convergence,maxIter,showplot);
        %check to make sure it didn't return an empty psi vector
        if isempty(psi) == 1
            error('psi is emtpy')
        end
        
        %normalize the wave function
        [psi,prob]=normalizePsi(x,psi);
        
        %save psi and energy from shooting function into output arrays
        psivalues(i,:) = psi;
        probvalues(i,:) = prob;
        energyvalues(i,1) = energy;
        
        %Should update starting energy guess for each iteration (before or
        %   after shooting method call). If you are searching for energy
        %   levels in an increasing manner, increase the starting guess a
        %   bit from the last solution so it will search for the next one).
        energy = energyvalues(i,1)+1;
    end
end
