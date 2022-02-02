function [energy,force]=lennard_jones(r,epsilon,sigma)
    %DO NOT USE any "for" loops; function return energy and force using vector code (e.g. ".*")
    %make sure r is only ever positive
    r = abs(r);
    %calculate the energy
    energy = 4.*epsilon.*((sigma./r).^12 - (sigma./r).^6);
    %calculate the force
%     syms e s r
%     E = 4*e*((s/r)^12 - (s/r)^6);
%     eqn = diff(E,r);
    force = 4*epsilon.*(((6*sigma^6)./r.^7) - ((12*sigma^12)./r.^13)).*(r./norm(r));
end