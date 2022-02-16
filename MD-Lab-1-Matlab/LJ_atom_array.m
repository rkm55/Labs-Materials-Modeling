function [Etotal,force,chainlen]=LJ_atom_array(x,epsilon,sigma,numNN)
    
    % set number of atoms variable
    N = length(x);

    %Store initial chain length in array chlen to be plotted
    chainlen= x(N)-x(1);
    
    %initialize output data
    %Use "f" as a vector with the total force on each atom (dimension 1*N)
    f= zeros(1,N);
    Etotal= 0;
    
    %Calculate forces & total energy
    for i=1:1:N                 %Loop over all atoms in chain
        for j= i-numNN:i+numNN         %Loop over appropriate set of numNN neighbors to atom i
            if j >= 1 && j <= N && j ~= i %skip atoms that should not / cannot be considered
                %calculate position vector between atoms i and j
                r = x(j) - x(i);
                
                %calculate force and energy for atoms i and j
                [energy,force]=lennard_jones(r,epsilon,sigma); %call lennard_jones
                
                %add force between atoms i and j to overall force acting on
                %atom i (with appropriate direction r)
                f(i) = f(i) + force*sign(r);

                %add to total energy
                Etotal = energy + Etotal;
                
            end
        end
    end
    force = f;
end
