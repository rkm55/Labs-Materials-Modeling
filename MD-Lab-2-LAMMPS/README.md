# Molecular Dynamics Lab 2 - LAMMPS


In this lab, you will use LAMMPS to examine a variety of different molecular dynamics problems. First you will complete tutorials from MS State <https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials>, after which you will run additional problems in LAMMPS. Place all the graphs and discussion in a single PDF file that you upload to Learning Suite. **Helpful instructions for the problems are found in an [instructions](./Instructions.md) file.**

In the questions following the tutorials, we will examine some of the common features of molecular dynamics (MD) calculations. In particular, we will focus on the melting behavior of the noble element Xe using MD with a Lennard-Jones potential, beginning with an examination of the proper choice of timestep and system size.

To determine behavior in both the solid and liquid phase as well as the temperature range over which the system melts, we will consider several analytical techniques which are used in a wide range of MD simulations. Beyond visual identification of melting, we will use radial distribution functions and mean squared displacements to identify changes in structure corresponding to a phase transition. You will also observe the phase transition by identifying a divergence in the specific heat of the system and a discontinuity in the caloric curve.

Finally, this problem set includes some short answer questions which should at least expose you to some of the other main issues involved with performing and analyzing MD calculations.

Use LAMMPS to do the following:
1.  Complete [MS State LAMMPS tutorial 3](https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_Help) and then submit the stress-strain curve with at least 5 snapshots of the system at key points during the simulation. Make sure the point at which the snapshots occurred is called out on the stress-strain curve.

2.  Complete one other [MS State LAMMPS tutorial](https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials) and use one of the following compute commands ([Centrosymmetery parameter](http://lammps.sandia.gov/doc/compute_centro_atom.html), [Common Neighbor Analysis](http://lammps.sandia.gov/doc/compute_cna_atom.html), [Potential Energy](http://lammps.sandia.gov/doc/compute_pe_atom.html), [Atomic (Virial) stress](http://lammps.sandia.gov/doc/compute_stress_atom.html)) that would be appropriate to help understand the result. In addition to describing/plotting what you think is necessary for your tutorial, include snapshots of your system of the output variable.

We will now be simulationg Xe. Instructions for the potential are included in the [instructions](./Instructions.md) file.

3.	First, obtain an appropriate timestep for your simulations by testing at several (at least 3) relevant temperatures with the default supercell size in a microcanonical (NVE) simulation. To determine an appropriate timestep, plot average total energy and standard deviation of the instantaneous total energy as a function of the timestep. Use this data to justify your choice of an appropriate timestep. The timesteps you consider should range from very small (e.g. 0.0001 ps) to very large (e.g 1.00 ps).

4.	Next, examine the size dependence of your simulations by varying the supercell size. As a general rule, temperatures in constant-energy ensembles tend to fluctuate around an average value, with the magnitude of these fluctuations generally dependent on the system size. Derive an expression to describe this scaling of the fluctuations with the system size N. (Derivation Hint: it starts from the central limit theorem and it isn't overly complex; what you're looking for is a relationship between the expected variance or standard deviation and the number of samples.) Using the input files provided, vary the system size of your supercell (NxNxN) for several N (e.g. 2,4,6,8). First, plot the instantaneous temperature versus time for each case. Next, calculate the variance of the temperature (the square of the standard deviation) and plot it against 1/Nat where Nat is the number of atoms in this case. Confirm that your data fits the relation that you derived. Lastly, use this trend to estimate how large a supercell would be required to obtain a melting temperature within a standard deviation of 1.0 K.

Now you will find the melting temperature of bulk fcc Xenon using a variety of techniques. To do this, you will run a number of simulations at various temperatures and analyze them using the following techniques.
    
5.	One of the simplest ways to identify melting is to visually inspect the system. Generate figures using [OVITO](https://www.ovito.org/) or a visualization program of your choice of the system before melting, during melting, and after melting. Specify the average temperatures of each of these simulations and provide an estimate of the melting temperature based upon your results.

6.	Using utilities provided to you, plot the total internal energy as a function of temperature, otherwise known as the caloric curve. When your material undergoes a phase transition from liquid to solid, you should see a discontinuity in the curve. Provide also an estimate of the melting temperature based upon your results.

7.	Radial distribution functions (RDFs) provide information about the structure of your system by indicating the relative probability of finding an atom a particular distance away from another. Compare RDFs for several temperatures below and above the melting temperature. Note the melting temperature by observing the disappearance of the second peak in your RDF. 

    1.  Extra credit: calculate the coordination number for at least one temperature below and one temperature above the melting point by integrating the RDF. The coordination number in the first coordination shell corresponds to the integration sum
    
        <img src="https://latex.codecogs.com/svg.latex?\Large&space;n(R)=\rho\sum_{r=0}^{R}4\pi&space;r^2&space;RDF(r)\Delta&space;r" title="\Large n(R)=\rho\sum_{r=0}^{R}4\pi&space;r^2&space;RDF(r)\Delta&space;r" />
        
        at the point R where the RDF reaches its first minimum. Here ρ represents the number density of the perfect crystal, or the number of atoms per unit volume, and Δr is the spacing between RDF sampling points. 

8.  Extra Credit (for W2020 only): Calculate the mean squared displacement (MSD), 

    <img src="https://latex.codecogs.com/svg.latex?\Large&space;MSD(t)=\langle|\mathbf{r}(t)-\mathbf{r}(0)|^2\rangle" title="\Large MSD(t)=\langle|\mathbf{r}(t)-\mathbf{r}(0)|^2\rangle" />

    for your system. The MSD of solid-like systems should plateau quickly while liquid-like systems exhibit a net-diffusive behavior indicated by a linear slope for a long simulation time.

    1.  Determine the melting temperature by identifying the transition to net-diffusive behavior.
    
    2.  Obtain the diffusion coefficient for temperatures at which the system is liquid using the Einstein relation: 
    
        <img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\frac{1}{6t}\langle|\mathbf{r}(t)-\mathbf{r}(0)|^2\rangle" title="\Large D=\frac{1}{6t}\langle|\mathbf{r}(t)-\mathbf{r}(0)|^2\rangle" />
    
        Generate a plot of log(D) as a function of 1/T.
    
    3. The Lindemann criterion is a rule of thumb for determining melting points based on the RMS amplitude of vibration in the solid (see Jin et al., PRL 87, 055703). It predicts that the system will melt when this quantity reaches about 10% of the nearest-neighbor distance for the perfect crystal. Test the validity of the Lindemann criterion by comparing the square root of the MSD at its plateau for your highest temperature just below the melting point with the nearest-neighbor distance of the crystal. Note: you will need to calculate the nearest-neighbor distance based on the data provided to you.

9.	Extra Credit (for W2020 only): Diffusion coefficients may also be calculated using the velocity autocorrelation function (VAF). 

    <img src="https://latex.codecogs.com/svg.latex?\Large&space;VAF(t)=\langle\mathbf{v}(t)\cdot\mathbf{v}(0)\rangle" title="\Large VAF(t)=\langle\mathbf{v}(t)\cdot\mathbf{v}(0)\rangle" />
 
    This is done by integrating the VAF and using the Green-Kubo relation: 
    
    <img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\lim_{t\to\infty}\frac{1}{3}\sum_{t'=0}{t}\langle\mathbf{v}(t')\cdot\mathbf{v}(0)\rangle\Delta&space;t" title="\Large D=\lim_{t\to\infty}\frac{1}{3}\sum_{t'=0}{t}\langle\mathbf{v}(t')\cdot\mathbf{v}(0)\rangle\Delta&space;t" />
 
    where Δt represents the sampling interval for the VAF (note that Δt as defined here is NOT the timestep but should instead be derived from the ‘dump’ frequency). Calculate VAF and then calculate D in this way for temperatures for which the system is liquid and plot log(D) as a function of 1/T. 

10.	Extra Credit: A first-order phase transition is accompanied by a divergence in the specific heat capacity. This quantity can be estimated by examining the fluctuations in the total energy when simulating in the canonical (NVT) ensemble (switch from NPT to NVT for the sampling). Repeat your simulations, but this time apply a thermostat to fix the temperature. You may find the following relationship between the energy fluctuations and the specific heat useful:

    <img src="https://latex.codecogs.com/svg.latex?\Large&space;C_V=\frac{1}{k_B&space;T^2}\sigma_E^2" title="\Large C_V=\frac{1}{k_B&space;T^2}\sigma_E^2" />
 
    where
    
    <img src="https://latex.codecogs.com/svg.latex?\Large&space;\sigma_E^2=\langle&space;E^2\rangle-\langle&space;E\rangle^2=\frac{1}{t}\sum_{t'=0}^t\left[E(t')-\langle&space;E\rangle\right]^2" title="\Large \sigma_E^2=\langle&space;E^2\rangle-\langle&space;E\rangle^2=\frac{1}{t}\sum_{t'=0}^t\left[E(t')-\langle&space;E\rangle\right]^2" />
 
    is the variance of the energy, or the square of the standard deviation. 

Scalability of MD Systems (short answer). Consider a bulk material simulation using periodic boundary conditions and large supercells.
    
11.	For an fcc material, how many atoms are contained in a supercell consisting of NxNxN unit cells?

12.	How many force calculations are required for each timestep if all atoms are considered? How many force calculations are required if a potential cutoff is implemented? How many times must you calculate the distance between atoms?

13.	Rank the following force calculations in terms of the CPU time required: Hartree-Fock methods (QM method), Lennard-Jones pair potentials, EAM pair functional potentials, and Density Functional Theory (QM method). Explain your choices.

14.	The current world record for size scales of MD is on the order of 1 trillion particles. Assuming an fcc material was used, how many unit cells were included in this calculation? Assuming a lattice constant of approximately 5 Angstroms, give an order of magnitude estimate of the length of the supercell used.

15.	One of the fastest supercomputers on record can perform 34 x 10<sup>15</sup> floating point operations per second. Assuming each distance calculation uses 1 floating point operation and each force calculation also uses 1 floating point operation, what is the maximum number of particles such that a single timestep calculation would take 1 second?

16.	Based on your answer to part E, it should be apparent that billion atom calculations utilize several tricks in order to gain a very significant speed advantage. For simple forms of empirical potentials, most of the computation time is spent calculating the distance between atoms. Can you think of any ways of reducing the amount of time spent calculating distances?
