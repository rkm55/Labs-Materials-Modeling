A0=50; % 50 mm^2
AL=25; % 25 mm^2
P=3500; % N
L=55; % cm
E=95; % GPa
x=linspace(0,L);

[u,strain,stress] = axial_nonuniform_soln(x,A0,AL,P,L,E);

figure;
subplot(3,1,1)
plot(x,u)
xlabel('Position')
ylabel('Displacement')
subplot(3,1,2)
plot(x,strain)
xlabel('Position')
ylabel('Strain')
subplot(3,1,3)
plot(x,stress)
xlabel('Position')
ylabel('Stress')
