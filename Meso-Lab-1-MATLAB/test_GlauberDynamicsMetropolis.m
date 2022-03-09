% Modeling Materials (ME EN 556) - Mesoscale Lab

%set simulation variables
Nspins = 2;         %set to 2 for Ising, > 2 for Potts 
Xmax=20;            %number of sites in x-direction
Ymax=20;            %number of sites in the y-direction
T=1;                %non-dimensional temperature value
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

for i=1:length(list)
    %convert an integer list site number into subscripts of a matrix
    [ix,iy]=ind2sub([Xmax,Ymax],list(i));
    
    %set site matrix to spin returned from GlauberDynamicsMetropolis function
    mat(ix,iy) = GlauberDynamicsMetropolis(mat,ix,iy,interfaceEnergy,T,Xmax,Ymax,Nspins);
end
