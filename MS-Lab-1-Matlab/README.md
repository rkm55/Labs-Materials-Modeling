# Molecular Statics Lab 1 - Lennard Jones Atom Array

In this lab, we will develop a Lennard Jones potential and compute the interactions of a 1D array of atoms. Some of this assignment will take place on MATLAB Grader and the remainder can be carried out in MATLAB on your computer. The Learner Templates are available in the GITHUB repository.

1.	Determine and code the Lennard Jones potential to calculate the energy and force for a vector of atoms at position r. Complete this problem on MATLAB Grader.
2.	Determine and code a function to calculate the total energy, forces, and other relevant parameters for a 1D array of atoms. Complete this problem on MATLAB Grader.
3.	Use the code developed for problems 1-2 to do the following. Place all the graphs and discussion in a single PDF file that you upload to Learning Suite. Use the following parameters: LJ parameters σ = 2.338 Angstroms and ε = 2.4096 eV, calculation that includes both first and second neighbors in chain numNN=2, Chain length N = 50 atoms.
    1.	**Produce a plot of Energy vs atomic spacing.** Do this by manually adjusting the spacing between your atoms over a large range of r. On the same plot, include the analytical LJ curve. (Make sure you normalize your plots so they have similar magnitudes). Compare the computational minimum to the analytical minimum (obtained by differentiation), and comment on any differences and the reason for their origin.
    2.	**Produce a plot of force vs atom position for three different atom spacings.** The three spacings should include the equilibrium spacing as well as a spacing somewhat larger and somewhat smaller than the equilibrium spacing. Comment on the values of the forces in your data.

