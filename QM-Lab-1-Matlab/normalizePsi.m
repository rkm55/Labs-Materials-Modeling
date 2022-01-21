function [psi,prob]=normalizePsi(x,psi)
%normalizePsi - function that normalize the wave function psi. This is 
%   accomplished by squaring the wave function and integrating over the 
%   domain where the wave function is non-zero. Ideally this domain ends
%   at the edge of the box/well, but if the wave function goes to zero 
%   outside the domain it should integrate until it goes to zero.
%
%   x - vector defining the positions of which to normalize the wave vector
%   psi (in) - vector (the same size as x) defining the wave vector
%   psi (out) - corrected wave vector (same size as the original)
%   prob - probability density (same size as x) of the wave vector solution
%
% Modeling Materials (ME EN 556) - QM Lab 1

    %find the index where x >=1
    idx=find(x>=1,1);
    %find the position where the wave function goes to zero at x>=1
    id=find(abs(psi) < 1e-3 & x >= x(idx),1);

    %set wave function to zero for all x beyond point where it goes to zero as
    %the non-zero wave function outside this point is an artifact of the method
    %and is meaningless
    psi(id:end)=0;

    %use trapezoidal integration (trapz function) to calculate the integral
    %of the probability over the wave function. This represents half of the
    %probability since we're only evaluating half the domain.
    hprob = trapz(x,psi.^2);

    %determine constant that should be used to multiply the wave function
    A = sqrt(0.5/hprob);

    %update the magnitude of the wave function using the calculated constant
    psi = A.*psi;

    %calculate the probability density
    prob = psi.^2;

end
