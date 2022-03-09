function [deltaE,Esite_likeOld]=siteEnergy(mat,ix,iy,spinold,spinnew,interfaceEnergy,Xmax,Ymax)
% siteEnergy - function that can calculate the change in energy if a
%              specific site were to change spin, as well as the energy for
%              the system without the change in spin
%
% Modeling Materials (ME EN 556) - Mesoscale Lab

    %initialize counts of like (or you can do unlike here)
    likeOld = 0;
    likeNew = 0;

    %look at nearest neighbors
    % for loop over ix nearest neighbors
        %consider periodic boundary conditions
    for i = ix-1:ix+1
        Nx = i;
        if i < 1
            Nx = Xmax;
        elseif i > Xmax
            Nx = 1;
        end
        % for loop over iy nearest neighbors
            %consider periodic boundary conditions
        for j = iy-1:iy+1
            Ny = j;
            if j < 1
                Ny = Ymax;
            elseif j > Ymax
                Ny = 1;
            end
            %skip self
            if i == ix && j == iy
                continue
            end
            %compare energies and count likes or unlikes of new/old spin
            if mat(Nx,Ny) == spinold
                likeOld = likeOld + 1;
            end
            if mat(Nx,Ny) == spinnew
                likeNew = likeNew +1;
            end
        %end for loop over iy neighbors
        end
    %end for loop over ix neighbors
    end

    % don't use the factor of 1/2 like the slides show
    %calculate change in energy
    deltaE = (likeOld - likeNew)*interfaceEnergy;
    
    
    %calculate the interface energy (Esite_likeOld) based on current 
    % unlike count.
    Esite_likeOld = (8 - likeOld)*interfaceEnergy;
    
end
