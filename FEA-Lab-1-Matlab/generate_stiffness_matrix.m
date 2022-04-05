function [K] = generate_stiffness_matrix(nodes,elems,E,A)

    K=zeros(length(nodes));%initialize zeros stiffness matrix
    for i=1:size(elems,1) %number of elements
        
        % call AxialDefElement to generate stiffness matrix for individual element
        coord = [nodes(i),nodes(i+1)];
        k = AxialDefElement(E, A, coord);

        % assemble it into overal stiffness matrix K
        K(i,i) = k(1,1) + K(i,i);
        K(i,i+1) = k(1,2) + K(i,i+1);
        K(i+1,i) = k(2,1) +  K(i+1,i);
        K(i+1,i+1) = k(2,2) + K(i+1,i+1);
    end
end

function k = AxialDefElement(E, A, coord)
    % k = AxialDefElement(E, A, coord) - Generates stiffness matrix of an axial deformation element
    % E = modulus of elasticity
    % A = Area of cross-section
    % coord = coordinates at the element ends
    
    %define k for individual element so it can be returned
    k = ((E*A)/(coord(2)-coord(1)))*[1 -1; -1 1];
end
