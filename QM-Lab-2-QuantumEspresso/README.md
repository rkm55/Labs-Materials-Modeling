# Quantum Mechanics (First Principles) Lab 2 - Quantum Espresso
*This lab has been adapted from an MIT course, 3.320 Atomistic Modeling of Materials (G Ceder)*

In this lab, we will examine various types of calculations. The first several problems will focus on energy-calculation convergence issues specific to first-principles calculations; specifically, the variables of energy cutoff and k-point grid size. Then you use DFT to  calculate lattice parameters, compare phases, obtain band structures, and examine a ferroelectric structure. 

All code for this lab will be run on BYU's supercomputer using a DFT software called *Quantum Espresso*. 

* The scripts necessary for each problem are located in the various folders of the repo; clone the GITHUB repo into your home folder `git clone https://github.com/BYUMicrostructureResearch/MaterialsModelingCourse.git`. 
* The scripts will all run the following commands to load the appropriate modules
    ```
    module purge
    module load gcc openmpi quantum-espresso
    ```
* **You will submit a PDF document with the information listed below to LS.**
* **Helpful instructions for each problem can be found in the [Instructions_QM.pdf](./Instructions_QM.pdf) found in this folder.**

***

1.	Convergence of absolute energies with respect to cutoff energies.
    1.	Using PWSCF, calculate the energy of diamond as a function of cutoff energy. A good increment might be ~10 Ryd, in the range of 10-140 Ryd. When changing the cutoff, make sure to keep the other variables (lattice constant, k-points, etc.) fixed. Record all relevant parameters such as lattice constant, k-points, and so on. Record and plot your final results. Specify when you reach the level of convergence of ~5 meV/atom (convert this to Ryd). Note that PWSCF calculates energy per primitive cell.
    2.	Do you see a trend in your calculated energies with respect to cutoff? If you see a trend, is this what you expect and why? If not, why?
    3.	In other labs we will use cubic unit cells. Here, we use the primitive cell. What are the advantages and disadvantages of both methods?

2.	Convergence of absolute energies with respect to k-points.
    1.	Using PWSCF, calculate the energy as a function of k-point grid size. For each grid, record the number of unique k-points. This gives a measure of how long your calculation will take - calculations scale as K, where K=number of unique k-points. When changing the size of the k-point grid, make sure to keep your other variables fixed (lattice constant, cutoff, etc.) One may choose a lower cutoff than the “converged” cutoff in the last problem. There are some “cross effects” in doing so, however we assume these are small.
    2.	Do you see a trend in your calculated energies with respect to grid size? If you see a trend, is this what you expect and why? If not, why?

3.	Convergence of forces with respect to cutoff energies.
    
    Sometimes, we are interested in quantities other than energies. In this problem, we will be calculating forces on atoms. Displace a C atom +0.05 in the z direction (fractional coordinates). Keeping other parameters fixed, calculate the forces on C as a function of cutoff. A good force value would be converged to within ~10 meV/Angstrom (convert this to Ryd/bohr - PWSCF gives forces in Ryd/bohr). Don’t forget to record relevant parameters (lattice parameter, k -points, unique k -points etc.). A good k -point grid to use is 4x4x4. Plot and record your results. (Note that this convergence is typically slower than the energy, is it here?)

4.	Convergence of energy differences with respect to energy cutoffs.
    
    In practice only energy differences have physical meaning, as opposed to absolute energy scales, which can be arbitrarily shifted. Therefore, it is important to understand the convergence properties. Using PWSCF, calculate the energy difference between diamond structures at two lattice parameters as a function of cutoff. For example, you could calculate the energy of diamond at the experimental lattice parameter (6.74 bohr), then calculate the energy at 6.70 bohr (or any lattice parameter close to the minimum), take the difference between the two, and repeat for many energy cutoffs. Make sure to keep your other variables (lattice constant, k­points, etc.) fixed while changing the cutoff. Record all relevant parameters such as the lattice constant, k-points, and so on. A good energy difference is converged to ~5 meV/atom (convert this to Ryd).

5.	Comparing Probs. 1, 2, 3, and 4:
    
    How do the cutoff requirements change when looking at absolute energies vs. looking at forces vs. energy differences? How do the k -point grid requirements change? Can you explain this? Comment on the overall process one might use to ensure accurate QM calculations and implications this may have on calculations that are not carried out carefully.

6.	Equilibrium lattice constant and bulk modulus.
    
    This problem has you calculating the equilibrium lattice constant and bulk modulus of diamond.
    
    Usually, we are interested in quantities such as forces or energy differences. We are not usually interested in absolute energies. For this reason, use the cutoff and k-point criteria that you determined for the force and energy difference calculation for this problem.
    
    Note, to be absolutely safe you should test for the quantity you are interested in. Ideally, we would test convergence of lattice constant as a function of energy cutoff and k-point grid size. For now, just use the force criteria.
    1.	Calculate the equilibrium lattice constant of diamond using PWSCF. The experimental value is 6.74 bohr. Use the cutoff and k-point grid criteria you obtained from the force convergence calculations. How does the experimental value compare with the calculated value? Is this expected? Make sure to record all the relevant parameters ( k -points, cutoffs, etc.).
    2.	Calculate the bulk modulus of diamond. This problem will have you derive some (simple) equations and then apply them to solving a problem. This type of procedure (derive and calculate) happens all the time in the computational sciences. 
    The bulk modulus is a measure of the stiffness of a material. The bulk modulus is defined as B=−V0 dP/dV , where V0 is the equilibrium volume. 
    
    Derive an expression for the bulk modulus, and calculate it.
    
    How does your value compare with the experimental value of 442 GPa?
    
    Hint 1 : Remember P=pressure=−dE/dV
    
    Hint 2: Remember the program calculates energies per primitive unit cell (How many atoms?).
    
    The following page may help with units: <http://www.chemie.fu-berlin.de/chemistry/general/units_en.html>

7.	Compare Graphite and Diamond

    1.	Using PWSCF, calculate the energy of the Graphite structure as a function of volume and compare to the Diamond structure. Remember the program calculates energies per primitive unit cell (How many atoms?) and you want to compare as a function of volume/atom. Make sure you have checked ecut and kpoint convergence first. Also note that it is important when comparing energies that the k-point samplings for both systems are comparable and converged. 
    2.	What does this tell you about the equilibrium phases as a function of pressure?

8.	Silicon band structure
    
    Compute, plot, and label the band structure of Si. Follow the instructions in the handout.
    1.	How many valence electron is there per Silicon atoms? How many in an elementary unit cell for Silicon in its diamond structure? From there, calculate the number of occupied bands (knowing that Silicon is a semiconductor, so it has fully occupied bands and fully unoccupied bands). How many bands were calculated with PWscf? How many are valence bands and how many are conduction bands? 
    2.	From the calculated band structure calculate the smallest gap between valence and conduction bands (indirect band gap). How well does it compare to experiment (1.17 eV)?
 
9.	Stability of the perovskite structure: a case study of BaTiO3.
    
    BaTiO3 is a perovskite oxide which is known to behave as a ferroelectric. The ferroelectric response of BaTiO3 is commonly thought to be the result of a displacive transition where a low temperature tetragonal phase is preferred over the cubic phase. In this problem, we will study the energetics of cubic BaTiO3 and use first principles calculations to gather information pertaining to the displacive transition to the tetragonal phase.
    1.	Compute and plot the energy of cubic BaTiO3 as a function of lattice parameter. Use a 4 x 4 x 4 k-point mesh with a 1,1,1 offset (see example script in the handout). Sample lattice parameters with a sufficiently fine grid to get a reliable value for the equilibrium lattice constant. To get an idea where to begin, note that the room-temperature experimental lattice constant is about 4 angstroms (1 bohr = 0.529177 ang). 
    2.	Using the equilibrium lattice parameter from part (a), plot the energy as a function of displacement of the Ti atom along one of the cubic lattice directions, allowing the O atoms to fully relax for each displacement. Report the Ti displacement at which the total energy is at a minimum. What is the energy difference between this configuration and the minimum-energy configuration from part (a)? Be aware that for BaTiO3, the Ti displacement will be very small. 
    3.	Now allow both the Ti atom and the O atoms to relax and find the minimum energy structure, using the minimum-energy Ti displacement from part (b) as your starting configuration. Report the final atomic positions and final energy. 
    4.	Which phase is the most energetically stable for PbTiO3 and how does that relate to the ferroelectric behavior of this material?

10.	Reflect on problems 6-9 and comment on the types of information that can be gained using QM calculations. 

---
## Energy Conversions
1 bohr = 1 a.u. (atomic unit) = 0.529177249 angstroms. 
1 Rydberg = 13.6056981 eV
1 eV =1.60217733 x 10-19 Joules

## Background
We will be using the Quantum-Espresso package as our first-principles code. Quantum- Espresso is a full ab initio package implementing electronic structure and energy calculations, linear response methods (to calculate phonon dispersion curves, dielectric constants, and Born effective charges) and third-order anharmonic perturbation theory. Quantym-Espresso also contains two molecular-dynamics codes, CPMD (Car-Parrinello Molecular Dynamics) and FPMD (First-Principles Molecular Dynamics). Inside this package, PWSCF is the code we will use to perform total energy calculations. PWSCF uses both norm-conserving pseudopotentials (PP) and ultrasoft pseudopotentials (US-PP), within density functional theory (DFT).

Quantum-Espresso is free under the conditions of the GNU GPL. Further information (including online manual) can be found at the Quantum-Espresso website <http://www.quantum-espresso.org> or <http://www.pwscf.org/>. Quantum-Espresso is currently at version 6.5.0. and is under very active development.


* [Quantum Espresso Documentation](https://www.quantum-espresso.org/resources/users-manual)

* [Quantum Espresso Plane-Wave Self-Consistent Field User Guide](https://www.quantum-espresso.org/Doc/pw_user_guide/)

* [Quantum Espresso Plane-Wave Input File Description](https://www.quantum-espresso.org/Doc/INPUT_PW.html)

* [Wikipedia Band Strucure Entry](https://en.wikipedia.org/wiki/Electronic_band_structure)

## Other first-principles codes

There are many other first-principles codes that one can use. Here is a non-comprehensive list:

* [ABINIT](http://www.abinit.org):
DFT Plane wave pseudo-potential (PP) code. ABINIT is also distributed under the GPL license.

* [CPMD](http://www.cpmd.org):
DFT Plane wave pseudopotential code. Car-Parrinello molecular dynamics. GPL.

* [SIEST A](http://www.uam.es/departamentos/ciencias/fismateriac/siesta/):
DFT in a localized atomic base.

* [VASP](http://cms.mpi.univie.ac.at/vasp/):
DFT Ultrasoft pseudo-potential (US-PP) and P A W code. US PP’ s are faster and more complex than corresponding PP codes, with similar accuracy. Moderate cost for academics (~$5000)

* [WIEN2k](http://www.wien2k.at/):
DFT Full-Potential Linearized Augmented Plane-Wave (FLAPW). FLAPW is the most accurate implementation of DFT, but the slowest. Small cost for academics (~$500)

* [Gaussian](http://www.gaussian.com):
Quantum Chemistry Code - includes Hartree-Fock and higher-order correlated electrons approaches. Moderate cost for academics (~$3000). Has recently been extended to solids.

* [Crystal](http://www.cse.clrc.ac.uk/cmg/CRYSTAL):
HF and DFT code. Small cost for academics (~$500). 

## BYU Supercomputing 

* [Office of Research Computing Website](https://rc.byu.edu)

* [Getting started videos](https://www.youtube.com/watch?v=i1r9BxHBG0I&list=PL326A5EB4E3B16FED&feature=plpp_play_all)

* [SLURM commands](https://rc.byu.edu/wiki/?id=SLURM+Commands)

* [Job script generator](https://rc.byu.edu/documentation/slurm/script-generator)
