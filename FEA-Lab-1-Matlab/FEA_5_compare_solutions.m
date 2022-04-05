clear; clc; close all;

A=25; % mm^2
P=3500; % N
c=18; % N/cm^2
L=55; % cm
E=95; % GPa
x=linspace(0,L);
nNodes=5;
nodes = linspace(0,L,nNodes); % nodal positions

%Define elements - list of nodal pairs, one pair per element (row)
nElems=nNodes-1;
elems=zeros(nElems,2);
for i=1:nElems
    elems(i,:)=[i,i+1];
end


[u1,strain1,stress1] = axial_uniform_soln(x,P,c,L,A,E);

[u2,strain2,stress2] = axial_uniform_approximation(x,A,P,c,L,E);

[u3,strain3,stress3,K,R,reactions] = axial_uniform_fea_soln(nodes,elems,A,P,c,L,E);


LW1 = 1.1;  % LineWidth
LW2 = 0.75;
LW3 = 0.75;
MS = 4;     % MarkerSize

figure(1)
% Displacement
plot(x,u1/10,'k','LineWidth',LW1)
hold on
plot(x,u2/10,'--r','LineWidth',LW2)
plot(nodes,u3/10,'-ob','LineWidth',LW3,'MarkerSize',MS)
legend('Exact Solution','Linear Approximation',['FEA Solution: ',num2str(nNodes),' Nodes']','Location','northwest')
title('Displacement')
xlabel('Position (cm)')
ylabel('Displacement ({\mum})')
set(gcf,'position',[400,400,450,350])

figure(2)
% Strain
plot(x,strain1/10,'k','LineWidth',LW1)
hold on
plot(x,strain2/10,'--r','LineWidth',LW2)
plot(nodes(elems)',[strain3/10,strain3/10]','-ob','LineWidth',LW3,'MarkerSize',MS)
legend('Exact Solution','Linear Approximation',['FEA Solution: ',num2str(nNodes),' Nodes'])
title('Strain')
xlabel('Position (cm)')
ylabel('Strain (%)')
set(gcf,'position',[400,400,450,350])

figure(3)
% Stress
plot(x,stress1,'k','LineWidth',LW1)
hold on
plot(x,stress2,'--r','LineWidth',LW2)
plot(nodes(elems)',[stress3,stress3]','-ob','LineWidth',LW3,'MarkerSize',MS)
legend('Exact Solution','Linear Approximation',['FEA Solution: ',num2str(nNodes),' Nodes'])
title('Stress')
xlabel('Position (cm)')
ylabel('Stress (MPa)')
set(gcf,'position',[400,400,450,350])


