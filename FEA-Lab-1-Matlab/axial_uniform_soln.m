function [u,strain,stress] = axial_uniform_soln(x,P,c,L,A,E)
    %calculate displacement, strain, stress
    u = x.*(6*P + 3*c*L^2 - c.*x.^2)./(6*E*A);
    strain = (6*P + 3*c*L^2 - 3*c.*x.^2)./(6*E*A);
    stress = E.*strain;
end
