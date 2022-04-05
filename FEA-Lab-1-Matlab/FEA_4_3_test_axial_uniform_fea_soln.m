A=25; % mm^2
P=3500; % N
c=18; % N/cm^2
L=55; % cm
E=95; % GPa
nNodes=5;
nodes = linspace(0,L,nNodes); % nodal positions

%Define elements - list of nodal pairs, one pair per element (row)
nElems=nNodes-1;
elems=zeros(nElems,2);
for i=1:nElems
    elems(i,:)=[i,i+1];
end

[u,strain,stress,K,R,reactions] = axial_uniform_fea_soln(nodes,elems,A,P,c,L,E);

figure;
subplot(3,1,1)
plot(nodes,u)
xlabel('Position')
ylabel('Displacement')
subplot(3,1,2)
plot(nodes(elems)',[strain,strain]')
xlabel('Position')
ylabel('Strain')
subplot(3,1,3)
plot(nodes(elems)',[stress,stress]')
xlabel('Position')
ylabel('Stress')
