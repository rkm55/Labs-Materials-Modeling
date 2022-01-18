% Modeling Materials (ME EN 556) - Random Walk Assignment - P1

%uncomment next line to set random number generator seed so that answers are consistent
% rng(1);

%define the latticeConstant
latticeConstant=1;
%define the initial position
initialPos=[0,0];

%get the updated position and jump by calling the function randomJump
[finalPos,jump]=randomJump(initialPos,latticeConstant);
