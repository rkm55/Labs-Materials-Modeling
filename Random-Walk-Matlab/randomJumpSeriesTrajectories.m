function [newPosSerTrajs,SDserTrajs,MSDser]=randomJumpSeriesTrajectories(Ktrajectories,Njumps,initialPos,latticeConstant)
%randomJumpSeriesTrajectories - function that runs multiple trajectories 
%   where each trajectory represents a series of random jumps to first 
%   nearest neightbors on a theoretical 2D lattice
%
%   Ktrajectories - number of different trajectories to examine
%   Njumps - number of jumps to execute
%   initialPos - 1 by 2 (row) vector containing the initial x,y position 
%                values
%   latticeConstant - scalar defining the magnitude of the lattice constant
%   newPosSerTrajs - Njumps+1 by 2 by Ktrajectories 3D matrix containing 
%                    row vectors of the x,y position of each jump in the 
%                    series in the first two dimensions, for each 
%                    trajectory enumerated by the 3rd dimension
%   SDserTrajs - Njumps+1 by Ktrajectories matrix containing the squared 
%                displacement of each of the Ktrajectories jump at each 
%                time step
%   MSDser - Njumps+1 by 1 vector containing the mean squared displacement 
%            of the Ktrajectories at each time step
%   
%
% Modeling Materials (ME EN 556) - Random Walk Assignment
    
    %pre-allocate output arrays
    newPosSerTrajs = zeros(Njumps+1,2,Ktrajectories);
    SDserTrajs = zeros(Njumps+1,Ktrajectories);
    
    %Iterate over the Ktrajectories and call randomJumpSeries to get 
    % results for each. NOTE: There is no reason to keep track of the 
    % jumpSeries for all trajectories going forward.
    for n = 1:Ktrajectories
        [newPosSeries,SDseries,~]=randomJumpSeries(Njumps,initialPos,latticeConstant);
        newPosSerTrajs(:,:,n) = newPosSeries;
        SDserTrajs(:,n) = SDseries;
    end

    %calculate the mean squared displacement for all steps (averaging over the trajectories)
    %       Note: it may be helpful to use mean(val,dim) where you specify which dim the
    %       average is calculated over. Also, if you're doing this by vector
    %       calculations, you can use the squeeze command to get rid of singular
    %       dimensions
    MSDser = mean(SDserTrajs,2);

end
