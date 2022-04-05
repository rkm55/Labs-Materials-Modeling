function [u,strain,stress] = axial_uniform_approximation(x,A,P,c,L,E)

    %calculate displacement, strain, stress
    a1 = (c*L^2 + 3*P)/(3*E*A);
    u = a1*x;
    strain = zeros(1,length(x)) + a1;
    stress = E*strain;

end
