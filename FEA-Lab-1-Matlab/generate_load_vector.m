function [R] = generate_load_vector(nodes,elems,c,P)
        
    % Define the load vector
    R=zeros(length(nodes),1);%initialize zeros column vector 
    for i=1:size(elems,1)%number of elements
        
        %call AxialDefLoadLinear to generate column vector for individual elements
        coord = [nodes(i),nodes(i+1)];
        rq = AxialDefLoadLinear(c, coord);
        %assemble it into overall load vector
        R(i) = rq(1) + R(i);
        R(i+1) = rq(2) + R(i+1);
    end
    %add end load P at appropriate node.
    R(length(nodes)) = R(length(nodes)) + P;
    
end

function rq = AxialDefLoadLinear(c, coord)
    % rq = AxialDefLoad(c, coord)
    % Generates equivalent load vector for an axial deformation element
    % q = linear load = c*x
    % coord = coordinates at the element ends
    
    %define rq for individual elements so it can be returned
    rq = [0 0];
    rq(1) = (c/(coord(2)-coord(1)))*((coord(2)^3/2) - (coord(2)^3/3) - ...
        (coord(1)^2*coord(2)/2) + (coord(1)^3/3));
    rq(2) = (c/(coord(2)-coord(1)))*((coord(2)^3/3) - (coord(1)^3/3) - ...
        (coord(1)*coord(2)^2/2) + (coord(1)^3/2));

end
