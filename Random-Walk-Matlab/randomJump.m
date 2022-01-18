function [newPos,jump]=randomJump(currentPos,latticeConstant)
%randomJump - function that suggests a random jump to a first nearest
%   neightbor on a theoretical 2D lattice
%
%   currentPos - 1 by 2 (row) vector containing the x,y position values
%   latticeConstant - scalar defining the magnitude of the lattice constant
%   jump - 1 by 2 (row) vector with magnitude and direction of jump
%   newPos - 1 by 2 (row) vector containing the final x,y position 
%            following the jump
%
% Modeling Materials (ME EN 556) - Random Walk Assignment
    
    
    % since we're just interested in integer random numbers use
    % the randi function to pick one of the possible sites
    jumpdir = randi(4);
    
    %determine jump based on random integer - use definitions in equation 2.18
    switch jumpdir
        case 1
            jumpPos = currentPos + [latticeConstant,0];
        case 2
            jumpPos = currentPos + [0,latticeConstant];
        case 3
            jumpPos = currentPos + [-latticeConstant,0];
        case 4
            jumpPos = currentPos + [0,-latticeConstant];
    end
    jump = jumpPos - currentPos;

    %update newPos
    newPos = jumpPos;
end
