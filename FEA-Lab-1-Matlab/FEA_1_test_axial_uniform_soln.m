A=25; % mm^2
P=3500; % N
c=18; % N/cm^2
L=55; % cm
E=95; % GPa
x=linspace(0,L);    


[u,strain,stress] = axial_uniform_soln(x,P,c,L,A,E);

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
