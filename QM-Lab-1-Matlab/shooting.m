function [psi,energy,iter]=shooting(evenodd,x,Vmax,energy,de,convergence,maxIter,showplot)
% code adapted from Computational Physics by Giordano (publisher: Pearson)
% energy : initial guess for the energy - set this to different values to look for different energy levels
% de : set how much to increase/decrease energy as it iterates, leave empty to use default value
% convergence : minimum energy difference between iterations to determine if solution is converged, leave empty to use default value
% maxIter : max iterations to try before giving up, leave empty to use default value
% showplot : determine whether an updating plot should be shown to illustrate the convergence process, leave empty to use default value
    if nargin < 5 || isempty(de)
        %default to changing the energy by a 10th of the starting guess
        de=energy/10;
    end
    if nargin < 6 || isempty(convergence)
        %default energy convergence value
        convergence = 1e-5;
    end
    if nargin < 7 || isempty(maxIter)
        %default max iteration value - will abort if not converged by then
        maxIter=100;
    end
    if nargin < 8 || isempty(showplot)
        %do not plot the wave function unless it is requested
        showplot=false;
    end

    %initialize the wave function (mostly only needed for first two values
    psi=initPsi(evenodd,x);
    
    %set needed values
    dx=x(2)-x(1);
    last_diverge=0;
    
    if showplot
        %values for plotting purposes - works better OUTSIDE of MATLAB Grader
        figure;
        axHandle=gca;
        hold(axHandle,'on');
        ylim(axHandle,[-2 2])
        xlim(axHandle,max(x)*[-1 1])
        plot(axHandle,[-1 1;-1 1],[-2 -2;2 2],'k:',max(x)*[-1 1],[0 0],'k:')
    end


    %start convergence iterations
    iter = 0;
    while 1
        for i=2:length(psi)-1
            psi(i+1) = 2*psi(i) - psi(i-1) - 2 * (energy - potential(i*dx,Vmax))* dx^2 * psi(i);
            if abs(psi(i+1)) > 2
                break
            end
        end
        iter=iter+1;

        if showplot
            %plot updated wave function
            displayPsi(axHandle,evenodd,psi,i,x,energy,iter,maxIter)
        end

        %determine how to continue adjusting the energy value
        if psi(i+1) > 0
            diverge = 1;
        else
            diverge = -1;
        end
        if diverge * last_diverge < 0
            de = -de/2;
        end
        energy = energy + de;
        last_diverge=diverge;
        
        %check for convergence
        if abs(de) < convergence
            break
        end
        
        %check max iterations and abort if exceeded
        if iter >= maxIter
            psi=[];
            energy=[];
            fprintf('Reached max iteration of %d and did not find convergence, adjust energy, de, maxIter or other value\n',maxIter);
            break
        end
    end
end
