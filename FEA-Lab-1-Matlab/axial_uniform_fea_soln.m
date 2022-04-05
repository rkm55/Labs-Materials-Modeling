function [u,strain,stress,K,R,reactions] = axial_uniform_fea_soln(nodes,elems,A,P,c,L,E)

    %%********* NOTE: YOU DO NOT HAVE TO USE PREVIOUS FUNCTIONS, YOU CAN HARD CODE A FUNCTION FOR 5 nodes (4 elements) and this will give you 80%. It must allow variable A,P,c,L,E. Full credit for variable node numbers

    %assemble stiffness matrix
    [K] = generate_stiffness_matrix(nodes,elems,E,A);

    %assemble load vector
    [R] = generate_load_vector(nodes,elems,c,P);

    %Calculate nodal solutions and reactions
    % Nodal solution and reactions
    debc = 1;
    ebcVals = 0;
    [u, reactions] = NodalSoln(K,R,debc,ebcVals);
        
    %calculate displacement, strain, stress
    strain = (1/nodes(2))*diff(u);
    stress = E*strain;

end


function [d, rf] = NodalSoln(K, R, debc, ebcVals)
    % [d, rf] = NodalSoln(K, R, debc, ebcVals) - Computes nodal solution and reactions
    % K = global coefficient matrix
    % R = global right hand side vector
    % debc = list of degrees of freedom with specified displacement values (e.g. which nodes have specified displacements)
    % ebcVals = specified displacement values for specified nodes (e.g. displacement values for nodes specified in debc)
    
    %get partial stiffness matrix
    Kf = K;
    Kf(debc,:) = [];
    Kf(:,debc) = [];

    %get partial load vector
    Rf = R;
    Rf(debc,:) = [];

    %solve for displacement
    d = Kf\Rf;
    d = [ebcVals; d];

    %solve for reaction forces of nodes with specified displacements
    rf = K(1,:)*d;

end

%you can copy your previous functions and use them here but it is not required.
