% Modeling Materials (ME EN 556) - Mesoscale Lab

%set simulation variables
Nspins = 2;         %set to 2 for Ising, > 2 for Potts 
Xmax=20;            %number of sites in x-direction
Ymax=20;            %number of sites in the y-direction
T=1;               %non-dimensional temperature value
interfaceEnergy=1;  %non-dimensional boundary energy

randseed = 1;       %used to ensure identical answers in stochastic simulations
rng(randseed);      %set the random seed


%initialize matrix of spins
if Nspins == 2
    %ISING MODEL - set fraction of sites
    frac=.5;
    mat = double( rand(Xmax,Ymax) < frac) + 1;
else
    %POTTS MODEL - set sites to random spins
    mat = randi(Nspins,Xmax,Ymax);
end

%set list of sites to test
list = randperm(Xmax*Ymax);%sweep randomly

%values to check
deltaE=zeros(size(length(list)));
siteEnergy_likeOld=zeros(size(length(list)));

for i=1:length(list)
    %convert an integer list site number into subscripts of a matrix
    [ix,iy]=ind2sub([Xmax,Ymax],list(i));
    
    %save old spin value
    spinold = mat(ix,iy);

    %there are many ways to select the new spin.
    %here we just pick one randomly from all possible spins
    spinnew = randi(Nspins);

    %call function to calculate the siteEnergies
    [deltaE(i),siteEnergy_likeOld(i)]=siteEnergy(mat,ix,iy,spinold,spinnew,interfaceEnergy,Xmax,Ymax);
end
