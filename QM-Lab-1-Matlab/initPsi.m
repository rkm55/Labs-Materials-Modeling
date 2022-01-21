function psi=initPsi(evenodd,x)
%initPsi - function that defines the initial form of the wave function
%   based on an even or odd solution.
%
%   evenodd - scalar that takes values of 1 or -1 to define even or odd
%             solutions, respectively.
%   x - vector defining the positions of which to define the initial wave 
%       vector
%   psi - vector (the same size as x) defininte the inital wave vector
%
% Modeling Materials (ME EN 556) - QM Lab 1

    %pre-allocate psi array
    psi=zeros(size(x));
    
    %the shooting method requires that we set initial values for the first
    %two values of psi based on whether the wave function is odd or even
    %define the first to values psi(1),psi(2) based on the following
    %information
    if evenodd == 1 %even: psi(+x) = +psi(-x)
        % psi(x=0 which corresponds to index=1) = 1 
        % psi(x>0 which corresponds to index=2) can be assumed to have 
        %    similar values in surrounding points because dpsi/dx=0 at x=0
        psi(1)=1;
        psi(2)=1;
    elseif evenodd == -1 %odd:  psi(+x) = -psi(-x)
        % psi(x=0 which corresponds to index=1) can be inferred from the
        %    requirement that psi(+x) = -psi(-x)
        % psi(x>0 which corresponds to index=2) can be estimated based on
        %    the fact that we know that dpsi/dx = 1
        psi(1)=0;
        psi(2)=x(2);
    else
        error('evenodd must be 1 or -1')
    end
end
