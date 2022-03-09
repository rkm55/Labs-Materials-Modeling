% Modeling Materials (ME EN 556) - Mesoscale Lab

%set simulation variables
Nspins = 2;         %set to 2 for Ising, > 2 for Potts 
Nsweeps = 600;       %number of sweeps over the lattice to 
Xmax=50;            %number of sites in x-direction
Ymax=50;            %number of sites in the y-direction
T=5;               %non-dimensional temperature value
interfaceEnergy=1;  %non-dimensional boundary energy

plotMat=false;      %plot simulation - turn off inside MATLAB Grader
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

%setup arrays to store variables
mat_hist = zeros(Nsweeps,Xmax,Ymax);
Etotal = zeros(Nsweeps,1); %sum of the total energy
if Nspins == 2
    %ISING MODEL - save the total magnetization
    Mtotal = zeros(Nsweeps,1); % Magnetization;
end

%setup figure for plotting the evolving matrix
if plotMat
    f=figure;
    if Nspins > 2
        colormap(lines(Nspins))
    end
    %plot initial state
    mat_temp=mat;
    mat_temp(end+1,end+1)=0;%pad extra row and column for surf
    surf(mat_temp);view(2);axis equal off;
    title(0)
    caxis([1 Nspins]);
    drawnow
    pause(.1)
end

%for loop for the number of seeps
Nsites = Xmax*Ymax;
for n=1:Nsweeps


    %three ways to sweep the lattice
    %pick one comment the other two
%     list = 1:Nsites;%sweep in order
    list = randperm(Nsites);%sweep randomly
%     list = randi(Nsites,1,Nsites);%pick sites randomly

    %for loop for the list of sites to check during the sweep
    for i=1:length(list)
        %convert an integer list site number into subscripts of a matrix
        [ix,iy]=ind2sub([Xmax,Ymax],list(i));

        %call GlauberDynamics to set spin of site
        mat(ix,iy)=GlauberDynamicsMetropolis(mat,ix,iy,interfaceEnergy,T,Xmax,Ymax,Nspins);

    end

    %store a copy of the matrix in its current state
    mat_hist(n,:,:)=mat;

    %plot the current structure
    if plotMat
        clf(f);
        mat_temp=mat;
        mat_temp(end+1,end+1)=0;%pad extra row and column for surf
        surf(mat_temp);view(2);axis equal off;
        title(n)
        caxis([1 Nspins]);
        drawnow
        pause(.1)
    end

    %calculate the total energy in its current state
    list = 1:Nsites;%sweep in order - no need to do this randomly

    %intialize energy for this step so it can be summed
    Estep = 0;
    %for loop for the list of sites to check during the sweep
    for i=1:length(list)
        %convert an integer list site number into subscripts of a matrix
        [ix,iy]=ind2sub([Xmax,Ymax],list(i));

        %get the spin of the site for comparison
        spin = mat(ix,iy);

        %add to Estep based on current site energy from spin
        %   set spinold = spin and spinnew to 0 (not of interest here)
        [~,Esite]=siteEnergy(mat,ix,iy,spin,0,interfaceEnergy,Xmax,Ymax);
        Estep = Estep + Esite;
    end

    %store total energy calculation
    Etotal(n)=Estep/2;%factor of two for double-counting
    if Nspins == 2
        %store total magnetization
        Mtotal(n)=sum(mat(:)-1);%convert to zeros and ones first
    end

end

%normalize by system size
Etotal = Etotal/Nsites;
if Nspins == 2
    Mtotal = Mtotal/Nsites;
    Mtotal = 2*abs(Mtotal-.5);%set to value between 0 and 1
end


%plot
figure;
plot(1:Nsweeps,Etotal,'k','DisplayName','Energy')
xlabel('Sweeps')
ylabel('Energy')
if Nspins == 2
    hold on;
    plot(1:Nsweeps,Mtotal,'r','DisplayName','Magnetization')
    legend('show')
    ylabel('Property')
end
sgtitle(['Temperature = ',num2str(T)],'fontsize',10)
set(gcf,'position',[400,400,450,350])
