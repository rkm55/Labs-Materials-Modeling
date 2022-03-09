function selectedSpin = GlauberDynamicsMetropolis(mat,ix,iy,interfaceEnergy,T,Xmax,Ymax,Nspins)
% GlauberDynamicsMetropolis - function to determine whether a given site 
%                             should change spin based on energetics and 
%                             probabilities.
%
% Modeling Materials (ME EN 556) - Mesoscale Lab


    boltz = 1;          %non-dimensional Boltzmann value
    
    %set the oldspin value
    spinold = mat(ix,iy);

    %there are many ways to select the new spin.
    %here we just pick one randomly from all possible spins
    spinnew = randi(Nspins);

    %skip any attempts that leave the spin the same and return the old spin
    if spinold == spinnew
        selectedSpin = spinold;
        return; %has no effect, skip
    end

    %calculate the change in energy for a potential change in spin
    [deltaE,siteEnergy_likeOld]=siteEnergy(mat,ix,iy,spinold,spinnew,interfaceEnergy,Xmax,Ymax);

    %calculate probability to accept spin change for negative change 
    %in energy, or for positive change in energy for both T=0 and T> 0
    %accept spin change based on probability and random number
    % but you must return a spin either way
    if deltaE <= 0
        selectedSpin = spinnew;
    elseif T > 0
        prob = exp(-deltaE/(boltz*T));
        random = rand;
        if random < prob
            selectedSpin = spinnew;
        else
            selectedSpin = spinold;
        end
    elseif T == 0
        selectedSpin = spinold;
    end
end
