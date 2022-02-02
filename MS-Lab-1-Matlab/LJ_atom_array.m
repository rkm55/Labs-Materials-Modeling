function [Etotal,force,x,chlen]=LJ_atom_array(N,rinit,epsilon,sigma,numNN)
    
    %Create a 1D chain of atoms
    %Use "x" as a vector of atom positions (dimension 1*N)
    %have first atom start at x=0 and space the atoms by rinit such that all atoms have x>=0
    x=0:rinit:rinit*(N-1);
    
    %Store initial chain length in array chlen to be plotted
    chlen= x(N);
    
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
