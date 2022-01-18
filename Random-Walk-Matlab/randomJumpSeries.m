function [newPosSeries,SDseries,jumpSeries]=randomJumpSeries(Njumps,initialPos,latticeConstant)
%randomJump - function that runs a series of random jumps to first nearest
%   neightbors on a theoretical 2D lattice
%
%   Njumps - number of jumps to execute
%   initialPos - 1 by 2 (row) vector containing the initial x,y position 
%                values
%   latticeConstant - scalar defining the magnitude of the lattice constant
%   newPosSeries - Njumps+1 by 2 matrix containing row vectors of the x,y 
%                  position of each jump in the series
%   SDseries - Njumps+1 by 1 column vector containing the squared displacement of
%               each jump in the series.
%   jumpSeries - Njumps by 2 matrix containing row vectors with x,y 
%                position of each jump (relative to the previous steps 
%                position)
%
% Modeling Materials (ME EN 556) - Random Walk Assignment
    
    %pre-allocate output arrays
    newPosSeries = zeros(Njumps+1,2);
    jumpSeries = zeros(Njumps,2); 
    
    %store the initial position in the output array
    newPosSeries(1,:) = initialPos;
    
    %iterate over Njumps and save output at each stage
    currentPos = initialPos;
    for n = 1:Njumps
        [newPos,jump] = randomJump(currentPos,latticeConstant);
        jumpSeries(n,:) = jump;
        newPosSeries(n+1,:) = newPos;
        currentPos = newPos;
    end
    
    %calculate the squared displacement for all steps
    nps = newPosSeries - newPosSeries(1,:);
    SDseries = dot(nps,nps,2);
    
end
