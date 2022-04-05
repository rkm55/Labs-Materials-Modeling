function [u,strain,stress] = axial_nonuniform_soln(x,A0,AL,P,L,E)
    %calculate displacement, strain, stress
    a = -(A0 - AL)/L;
    b = A0;
    C1 = P;
    C2 = (-C1/a)*log(b);
    u = (1/E)*(((C1/a)*log((a*x)+b)) + C2);
    strain = C1./(E*((a*x)+b));
    stress = E*strain;
end
