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

[R] = generate_load_vector(nodes,elems,c,P);
