# Molecular Statics Lab 2 Instructions

## Compiling LAMMPS

You'll need to compile LAMMPS to be able to run the clalculations you need. To do this, you'll need to have the right modules set up. Run the following commands to set the recommended libraries.

```bash
module purge
module load intel-compilers/2019 intel-mpi/2019 libfabric/1.8
```

Now you can obtain the source code for LAMMPS and compile an executable. Naviate to folder where you'd like to place a copy of the LAMMPS source code. Then run the following:

```bash
git clone -b stable https://github.com/lammps/lammps.git lammps-stable  # get the latest version of lammps
cd lammps-stable/src/ # navigate to the source code directory
make yes-MANYBODY # indicate to lammps that you want to include a package for EAM and other potentials
make -j mpi # build lammps
```

These set of commamds should compile LAMMPS and there should be a new executable file `lmp_mpi`.

**To use this executable you'll need to do a few things:**

1. Put the executable file in a searchable path or copy it to the folder where you'll want to run it. The included slurm bash script assumes you'll copy it to the folder of interest.
2. Ensure that the appropriate modules are active. This means that you must purge and load the appropriate modules each time you login, as indicated above, or put those lines of code in a slurm bash script, as provided in the accompanying slurm script.
3. You must call your executable from either mpirun or srun. If I want to call the executable from an interactive shell I might use the following `mpirun -n 1 ./lmp_mpi < calc_fcc.in` where this will use 1 processor. In general, this lab will not require many processors and often only require 1. If I choose to call the executable inside a script submitted to slurm I would use the following `srun ./lmp_mpi < calc_fcc.in`.






## Running the MS STATE CAVS LAMMPS Tutorials
The MS STATE LAMMPS tutorials are found at <https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials>.

I have copied the LAMMPS input file for the first tutorial into the this folder. 

Here are an important list of points to be able to run the tutorials in LAMMPS on the supercomputer:

1. Please note that the instructions for running LAMMPS on the supercomputer are slightly different than on a desktop. For example, the tutorial refers to the executable as `lmp_win_no-mpi` whereas the executable you have compiled is named `lmp_mpi`. 
2. You will need to download the appropriate interatomic potential from NIST <http://www.ctcms.nist.gov/potentials/> as indicated in the instructions for tutorial 1.

All other question are reasonably discussed in the tutorials


## Running LAMMPS for the rest of the assignment

Most of this lab can be done by adapting the input script from the very first LAMMPS tutorial from the CAVS website <https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials>

The Lennard-Jones Potential for Cu (where ε = 0.5838 eV and σ =0.227 nm, cutoff = 0.488 nm, and atomic mass of 63.546g/mol) that you will use for this Lab can be implemented in LAMMPS by and would replace the equivalent lines for the EAM potential.
```
pair_style lj/cut cutoff #don’t forget to check your units
pair_coeff * * epsilon sigma #don’t forget to check your units
mass * cu_mass # don't forget to replace "cu_mass" with the atomic mass of copper and don't forget to check your units
```

The EAM potential that we will be using is the potential published by M.I. Mendelev, M.J. Kramer, C.A. Becker, and M. Asta, "Analysis of semi-empirical interatomic potentials appropriate for simulation of crystalline and liquid Al and Cu," Phil. Mag. 88, 1723-1750 (2008). DOI: 10.1080/14786430802206482. This potential is available on the NIST website <http://www.ctcms.nist.gov/potentials/Cu.html> and the syntax is very similar to that used for the Al eam potential in the tutorials.

To adjust the lattice parameter you can change `lattice fcc 4.0` to `lattice fcc ${lp}` and then when you run the script add a tag to the end of the command to run lammps `mpirun –np 2 lmp_byu < inputfile.in -var lp 4`. This will replace any `${lp}` in the script with `4`. (Read the variable command in lammps for more information.  Note that variables with more than one letter in the name require curly braces while single letters do not.  E.g. `${myvariable}` and `$x`. Also note that each variable passed in by the command must have its own `–var`. E.g. `–var lp 4 –var x 3`.)

To obtain the energy-lattice parameter plots as a function of the lattice parameter, you must turn off the minimization commands `minimize and min_style` and substitute the run command `run 0`. Normally, this command is executed to run a certain number of MD iterations of Newton’s equations.  In this case, running 0 steps will not move any of the atoms but will run all the energy and other analytical calculations on the current configuration for output purposes.

To speed things up, I often write MATLAB scripts to run lots of simulations. (You could also write a BASH or python Script) 
```matlab
lp=%define an array
 
for i=1:length(lp)
    cmd=sprintf('/usr/local/bin/mpirun -np 1 ./lmp_mpi < calc_fcc.in -var lp %.2f',lp(i));
    [status,result] = unix(cmd);
    if status, error(result); end
    [status,result] = unix('grep Cohesive log.lammps | grep -v ecoh');
    C = textscan(result, '%s %s %s %s %f %s');
    e(i)=C{5}; 
end
plot(lp,e)
```

Hint 1: To delete atoms to form the vacancy or free surface, you can use a [group](https://lammps.sandia.gov/doc/group.html) or [region](https://lammps.sandia.gov/doc/region.html) command paired with the [delete_atoms](https://lammps.sandia.gov/doc/delete_atoms.html) command. Some ideas
```
group delAtomsID id 1 1
delete_atoms group delAtomsID
```
or
```
region delBlockID block 2 3 INF INF INF INF
delete_atoms region delBlockID
```
Hint 2: Many of the calculations require the energy of a perfect system. Run a calculation on the system you set up before you delete atoms; then run the calculation with the defect.

Variables can be very confusing. If you are going to use them, please read the LAMMPS documentation as variables can be handled multiple ways. <http://lammps.sandia.gov/doc/variable.html> Make sure you read the subsection "Immediate Evaluation of Variables", about 7/8 down the page.  As a general rule, whenever I define new variables using equal, I put them in quotes and use the v_ to access the variable. When I print a variable I use the $. As noted in "Immediate Evaluation of Variables", you can use an extra variable plus a $ to immediately evaluate a given variable.

## Visualizing LAMMPS dump files

There are a variety of different atomistic visualizers but I recommend that you use [OVITO](http://www.ovito.org/) as it has a nice GUI and can accept a variety of file types.

I recommend that you use the [custom](https://lammps.sandia.gov/doc/dump.html) `dump` command such as one of the following where you can pick any unique name to replace `PICKANAME`
```
dump PICKANAME1 all custom 100 dump.*.out id type x y z #simple example
dump PICKANAME2 all custom 100 dump.*.out id type x y z fx fy fz c_CNA # also dump forces and a compute output
```


## BYU Supercomputing 

* [Office of Research Computing Website](https://rc.byu.edu)

* [Getting started videos](https://www.youtube.com/watch?v=i1r9BxHBG0I&list=PL326A5EB4E3B16FED&feature=plpp_play_all)

* [SLURM commands](https://rc.byu.edu/wiki/?id=SLURM+Commands)

* [Job script generator](https://rc.byu.edu/documentation/slurm/script-generator)
