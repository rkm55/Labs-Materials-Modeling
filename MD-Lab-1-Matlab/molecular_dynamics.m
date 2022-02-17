function [T,E,chainlength,time,pos,vel,forces]=molecular_dynamics(sigma,epsilon,amass,rinit,natoms,numNN,Tinit,nsteps,dt,randseed)
% Inputs: (sigma,epsilon,amass,rinit,natoms,numNN,Tinit,nsteps,dt,randseed)
% Outputs: [T,E,chainlength,time,pos,vel,forces]
% molecular_dynamics - function to simulate the molecular dynamics of a 1D
%                      array of atoms.
%
% Modeling Materials (ME EN 556) - Molecular Dynamics Lab
% Script adapted from original work by Douglas Spearot (U. Arkansas / U. Florida) 


    %Boltzmann's constant
    boltz = 8.62E-5;

    %initialize x positions and velocity vector and initial temperature
    [x,v,temp]=initialize_MD(natoms, rinit, Tinit, amass, randseed);

    % setup arrays to store data
    %scalars as a function of time
    T=zeros(nsteps,1);
    E=zeros(nsteps,1);
    chainlength=zeros(nsteps,1);
    time=zeros(nsteps,1);
    %row vectors as a function of time
    pos=zeros(nsteps,natoms);
    vel=zeros(nsteps,natoms);
    forces=zeros(nsteps,natoms);

    %start interations, with an initial evaluation at time = 0 and 

    %call LJ_atom_array to get total energy, force row vector, & chainlength
    % call LJ_atom_array to get initial energy, forces and chain length
    [Etotal,force,chainlen]=LJ_atom_array(x,epsilon,sigma,numNN);

    %Store initial values (temperature, energy, etc.) in array to be plotted
    T(1) = temp;
    E(1)=Etotal;
    chainlength(1)=chainlen;
    time(1)=0;
    pos(1,:)=x;
    vel(1,:)=v;
    forces(1,:)=force;
    %At this point initial positions, velocities and forces are defined


    %Iterate equations of motion for the desired number of timesteps
    for itime=1:1:nsteps
        
        %Implement the optimized Velocity Verlet algorithm here

        %Evolve positions (full timestep) and velocities (1st half)
        pos(itime+1,:) = pos(itime,:) + vel(itime,:)*dt + forces(itime,:)*dt^2/(2*amass);
        vh = vel(itime,:) + (forces(itime,:)*dt)/(2*amass);

        %call LJ_atom_array to get total energy, force row vector, & chainlength
        % call LJ_atom_array to get current energy, forces and chain length
        [E(itime+1),forces(itime+1,:),chainlength(itime+1)]=LJ_atom_array(pos(itime+1,:),epsilon,sigma,numNN);

        %Evolve velocities (2nd half)
        vel(itime+1,:) = vh + forces(itime+1,:)*dt/(2*amass);

        %calculate the new temperature and then store all variables
        temp = amass*sum(vel(itime+1,:).^2)/(boltz*natoms);
        T(itime+1) = temp; %example of how to store a variable for this iteration
        time(itime+1)=time(itime)+dt;
  
    end
    
end

