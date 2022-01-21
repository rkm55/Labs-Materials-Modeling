function p = potential(x,V)
%potential - function that defines the potential for a particle in a 1D
%   box. The box width should run from -1 to 1 and have a potential of zero
%   in the box and a potential of V outside. You can write this function 
%   assuming x is passed in as a scalar and not a vector
%
%   x - scalar defining the position for a particle
%   V - scalar defining the magnitude of the potential outside the box
%   p - scalar defining the value of the potential at the position x
%
% Modeling Materials (ME EN 556) - QM Lab 1

    %define the value of P based on position x
     if x < -1 || x > 1
        p = V;
     else
        p = 0;
     end
    
end
