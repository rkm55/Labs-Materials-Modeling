# Molecular Statics Lab 2 - LAMMPS


In this lab, we will use LAMMPS to examine a variety of different molecular statics problems. First you will complete tutorials from MS State <https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials>, after which you will run additional problems in LAMMPS. Place all the graphs and discussion in a single PDF file that you upload to Learning Suite. **Helpful instructions for the problems are found in an instructions markdown file in this folder.**

Use LAMMPS to do the following:
1.  Complete [MS State LAMMPS tutorial 1](https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_Help) and then write a paragraph on what you are calculating and what the final answer is.
2.  Complete [MS State LAMMPS tutorial 2](https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_Help2) and submit a plot of the energy as a function of lattice parameter and explain what the output means. Comment on how this is different/similar to interatomic potential plots as a function of bond distance.
3.	Calculate the lattice constant and cohesive energy (in eV) for FCC Cu. Do this two ways: i) using energy minimization and ii) adjusting the lattice parameter manually (not using energy minimization). This calculation will be done with LJ and EAM potentials. Plot your cohesive energy as a function of lattice parameter for the two potentials using the manual adjustment and also include a data point for the minimization. How do these values, and curves, compare with the experimental lattice parameter for Cu, which is 3.615 Å?
4.	Compute the vacancy formation energy in FCC Cu. Do this two ways: i) using energy minimization and ii) running just a single iteration (run 0) after removing an atom. In this problem, we will look at many of the issues involved in total-energy calculations. We will look at supercell convergence, effect of relaxations, and shortcomings of potentials. This calculation will be done with LJ and EAM potentials.  How do these values, and curves, compare with the vacancy formation energy for Cu, which is 1.3 eV?
5.	Compute the surface energy of a solid (100) surface of FCC Cu. Use both the LJ and EMA potentials. How you do this is up to you, but remember the issues of supercell size and relaxations. In your answer, make sure to write down the formula you use.
    Hints:
    1.	Hint 1: Think hard about which dimension supercell you use, keeping in mind periodic boundary conditions. Do not make your calculations take longer than is required.
    2.	Hint 2: There are two size convergence issues to think about. Again, think about periodic boundary conditions. Give your answer in eV/Å^2
6.	Short answer: When using potentials, the choice of potential is important. In this problem set, we used the Lennard-Jones and EAM energy methods. For what other types of problems would you use Lennard-Jones potentials? When would you use the EAM? When would neither be appropriate?
