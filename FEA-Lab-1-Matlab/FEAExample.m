E=29e6;     %psi
A=21.8;     %in^2
L=180;      %in
format short g

%construct stiffness matrix
k=(E*A/L)*...
[1 -1 0 0 0;
-1 2 -1 0 0;
0 -1 2 -1 0;
0 0 -1 2 -1;
0 0 0 -1 1]

%construct vector of all body loads and concentrated forces
f=[0; %note this does NOT included the unknown reaction force - will be solved for later
    -50000;
    -40000;
    -40000;
    -35000]

%Can't solve with unknowns on both right and left side - and mathematically
%we can't solve this as is - therefore we will use a boundary condition

%known that u(0)=0; so solve rest of the matrix
kf=k(2:5,2:5);
ff=f(2:5);


%solve without the row that has a known displacement
uf=kf\ff;

%add back to get full solution
u=[0;uf]

%now we can solve for our unknown reaction force
reaction = k(1,:)*u


%now calculate values in elements (not values at nodes)

%calculate the strain - this can be done one of two ways - this is the easy
%way for linear elements - alternatively calculate u(x) at each element and
%find strain=du/dx
strain=[u(2)-u(1);
        u(3)-u(2);
        u(4)-u(3);
        u(5)-u(4)]/L
    
%use Hooke's law to get stress
stress=E * strain

% use definition of stress to get force
force=stress * A
