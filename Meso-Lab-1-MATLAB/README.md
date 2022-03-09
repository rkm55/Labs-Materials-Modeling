# Mesoscale Lab 1 - Ising/Potts

In this lab, we will develop an Ising/Potts Monte Carlo code in Matlab for a 2D periodic square lattice of sites that have interface penalties for neighboring sites with unlike spins and compute the interactions of this lattice over various conditions. Some of this assignment will take place on MATLAB Grader and the remainder can be carried out in MATLAB on your computer. The Learner Templates are available in the GITHUB repository.


|   |   |   |   |
|---|---|---|---|
| A | A | A | B |
| A | A | B | B |
| A | C | B | B |
| C | C | C | C |


1.	Determine and code a function to calculate the energy of a site in a 2D periodic square lattice of sites that have interface penalties for neighboring sites with unlike spins. Complete this problem on MATLAB Grader.
2.	Determine and code a function to change spins of a given site using Glauber dynamics. Complete this problem on MATLAB Grader.
3.	Use the code developed for problems 1-2 and the additional `run_Ising_Potts.m` file to do the following. Place all the graphs and discussion in a single PDF file that you upload to Learning Suite. Use the following parameters: Xmax=Ymax=50 and interfaceEnergy=1. Start with Nsweeps=100 but adjust it as necessary.
    1.	**Produce a plot of Energy vs time and Magnetization vs time for a 2 spin system.** Do this for a range of tempreatures to get an idea of where the Curie temperature is. Submit the results from 3 different temperatures that capture the behavior above and below the critical Curie temperature. Comment on why the three temperatures differ in their behavior.
    2.	**Produce a magnetization vs temperature plot by running the code over a range of temperatures (e.g. 0-5+) for a 2 spin system.** Comment on the meaning of this graph and estimate a value for the critical Curie temperature.
    3.  **Produce a series of snapshots for a Potts system (# spins > 2) to demonstrate microstructural coarsening.** Comment on the evolution of the Potts system
