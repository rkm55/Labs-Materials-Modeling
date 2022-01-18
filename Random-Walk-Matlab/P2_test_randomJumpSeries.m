% Modeling Materials (ME EN 556) - Random Walk Assignment - P2

%uncomment next line to set random number generator seed so that answers are consistent
rng(1);

%define the latticeConstant
latticeConstant=1;
%define the initial position
initialPos=[9,9];
%define the number of desired jumps
Njumps=1000;
%define the increment of time for each jump
dt=1;

%set the time (column) vector
t=dt * (0:1:Njumps)';

%get the updated position and jump by calling the function randomJumpSeries
[newPosSeries,SDseries,jumpSeries]=randomJumpSeries(Njumps,initialPos,latticeConstant);

%plot the data
figure;

%plot the jump path (newPosSeries)
subplot(1,2,1);
hold on;
plot([newPosSeries(1:end-1,1),newPosSeries(2:end,1)],[newPosSeries(1:end-1,2),newPosSeries(2:end,2)],'k-')
plot(newPosSeries(1,1),newPosSeries(1,2),'r*',newPosSeries(end,1),newPosSeries(end,2),'gs')
axis equal
box on;

%plot the squared displacement vs time
subplot(1,2,2);
plot(t,SDseries,'r')
xlabel('Time')
ylabel('Squared Displacement')
