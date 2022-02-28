# Molecular Dynamics Lab 2 Instructions

## Using the LAMMPS executable

In MS Lab 2 you compiled LAMMPS using a certain set of modules. Look back at the instructions file for MS Lab 2 if you have trouble running your LAMMPS executable.

In the examples below, all the calls to run LAMMPS us the `srun` command but one could also substitute `mpirun -n 1` with an appropriate number of processors.

## Using LAMMPS computes and dumps

You will frequently want to compute certain quantities on your data and LAMMPS has a number of these readily available for use. For example there is the [centrosymmetry parameter](http://lammps.sandia.gov/doc/compute_centro_atom.html), [common neighbor analysis](http://lammps.sandia.gov/doc/compute_cna_atom.html), [potential energy per atom](http://lammps.sandia.gov/doc/compute_pe_atom.html), [stress tensor per atom](http://lammps.sandia.gov/doc/compute_stress_atom.html) (Note: The stress tensor is actually output as the stress times the local volume; calculating the stress requires dividing by the local volume), and [atomic volume by Voronoi method](https://lammps.sandia.gov/doc/compute_voronoi_atom.html). 

These commands all have examples on the website showing how to use them.  Since these are per atom quantities, they can be output with the dump files to be viewed in OVITO or another visualization program. To output these, you must use the ID associated with the compute command and call that out in the dump command. For example, one can call a compute and give it the ID PEID
```
compute PEID all pe/atom
```
This potential energy can then be dumped with each atom using the following dump syntax
```
dump DUMPID all custom 100 dump.*.out id type x y z c_PEID 
```
This will result in a column of data with the potential energy for each atom. This can be selected as the way to color your data.



## Running the MS STATE CAVS LAMMPS Tutorials
The MS STATE LAMMPS tutorials are found at <https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials>. 

Here are an important list of points to be able to run the tutorials in LAMMPS on the supercomputer:

1. Please note that the instructions for running LAMMPS on the supercomputer are slightly different than on a desktop. For example, the tutorial refers to the executable as `lmp_win_no-mpi` whereas the executable you have compiled is named `lmp_mpi`. 
2. You will need to download the appropriate interatomic potentials from NIST <http://www.ctcms.nist.gov/potentials/> as indicated in the instructions for the tutorials you choose.

All other question are reasonably discussed in the tutorials




## Running LAMMPS for the rest of the assignment

Note: these instructions have been adapted from the MIT 3.320 Atomistic Modeling of Materials course taught by G. Ceder.

Here is a link to an [MD Primer](http://www.fisica.uniud.it/~ercolessi/md/md/) written by Furio Ercolessi. It is a very good, and very easy-to-understand explanation of molecular dynamics and interatomic potentials.

Note that initial velocities are chosen randomly, often consistent with the Maxwell-Boltzmann distribution, but if not, those the distribution is quickly obtained. Unfortunately, these initial velocities can be quite wrong at first. Thus, we want the system to run at several timesteps first before we actually sample thermodynamic quantities (such as potential energy or kinetic energy). This is called equilibration time. A schematic is shown below.

```
                              total simulation length
|---------------------------------------------------------------------------------------|
  equilibration period
|----------------------|
                                               sampling period
                       |----------------------------------------------------------------|
 timestep
|-|
 ```

### Melting of Xenon
In this lab, we look at melting of Xe. Xe crystallizes in the FCC structure (the same structure as Cu and Al) with the lattice parameter 6.12 Angstroms. Experimentally, Xe melts at 161.4 K. We will use Lennard-Jones (LJ) potentials.

The Lennard-Jones Potential for Xe (where ε = 0.01834428 eV and σ =0.410 nm, cutoff = 1.0 nm) that you will use for this Lab can be implemented in LAMMPS by and would replace the equivalent lines for the EAM potential.
```
pair_style lj/cut cutoff #don’t forget to check your units
pair_coeff * * epsilon sigma #don’t forget to check your units
```

### Finding a timestep
The first thing we need to do is find a good timestep. This is controlled by the step parameter in the control file. A rough rule of thumb is that the timestep is 1/100 the highest-frequency excitation in which you are interested. This value is usually around 
10<sup>-13</sup>-10<sup>-15</sup> seconds. You want as long a timestep as possible, so that you can perform long simulations, but too large a timestep will produce unstable simulation conditions.

The standard way to test your timestep is to measure the conservation of energy in the NVE ensemble because in this case total energy (PE+KE) is constant. If the timestep is too long, the total energy may drift or the atoms may crash into each other. These are both indications of too large of a timestep. Note, we could also do this in the NPE ensemble also – in this case, the conserved quantity would be H =E +PV.

The timestep test should be done at a smaller-sized supercell but not too small (3x3x3 is fine). The temperature should be at LEAST the temperatures of interest. It should be done for ~10000 sampling timesteps.

### Finding a system size
Run a single temperature at the timestep identified in the previous tests. Run various supercell sizes (2,4,6,8, etc.) and plot the variance of the temperature as a function of 1 over the number of atoms in the supercell. 

Below is an example input script but with numerous missing values indicated with _____. Also note that there are variables to simplify your ability to run this script with various values. This can be run with `srun ./lmp_mpi < input.txt –var t 0.001 –var n 3`
```
# ---------- Initialize Simulation --------------------- 
units metal 
dimension 3 
boundary p p p 
atom_style atomic 
atom_modify map array

# ---------- Create Atoms --------------------- 
lattice 	fcc _____
region	box block 0 $n 0 $n 0 $n units lattice
create_box	1 box
create_atoms 1 box

# ---------- Define Interatomic Potential --------------------- 
pair_style lj/cut _____
pair_coeff * * _____ _____

mass 1 _____
neighbor 2.0 bin 
neigh_modify delay 10 check yes 

# ---------- Run Equilibration --------------------- 
velocity all create _____ 12345 mom yes rot no
timestep $t
fix 1 all nve
thermo _____ 
run _____

print "All done!"
```



To run the various temperatures, I suggest running simulations that take the output from the previous simulation as input to the next. For instance, you might do a run at 130 K first, and then use that input data to run simulations at a higher temperature such as 135K and then use that output as the input for the next, etc. The first time you run, you will start from a perfect lattice, but for all future runs you should uncomment the lines necessary to have future runs start from previous restart files. Remember that you use the output of your old temperature as input into your new temperature because this procedure gives better initial conditions. Example files are available below. The first creates a crystal and can be run by specifying `-var temp _____` and specifying the starting temperature.
```
log output.${temp}.log
# ---------- Initialize Simulation --------------------- 
units metal 
dimension 3 
boundary p p p 
atom_style atomic 
atom_modify map array

# ---------- Create Atoms --------------------- 
lattice 	fcc 6.12
region	box block 0 _____ 0 _____ 0 _____ units lattice
create_box	1 box
create_atoms 1 box

# ---------- Define Interatomic Potential --------------------- 
pair_style lj/cut _____
pair_coeff * * _____ _____
mass 1 _____

# ---------- Run Initialize Temp ---------------------
variable tstart equal "2*v_temp"
velocity all create ${tstart} 12345 mom yes rot no

# ---------- Neighbor lists ---------------------
neighbor 2.0 bin 
neigh_modify delay 10 check yes 

# ---------- Run Equilibration --------------------- 
reset_timestep 0
timestep _____
fix 1 all npt temp ${temp} ${temp} _____ iso 0.0 0.0 _____
thermo 50 
run _____

# ---------- Run Sampling --------------------- 
compute myMSD all msd com yes 
compute myVACF all vacf
thermo_style custom step temp epair etotal press c_myMSD[4] c_myVACF[4]
print "StartSampling"
run _____
print "EndSampling"
#output a single snapshot at the end of the simulation
dump 1 all cfg 1 dump.${temp}.*.cfg mass type xs ys zs
compute myRDF all rdf 100
fix 2 all ave/time 1 1 1 c_myRDF file rdf.${temp}.out mode vector 
run 0

# ---------- Write restart ---------------------
unfix 1
unfix 2
uncompute myMSD
uncompute myVACF
uncompute myRDF
undump 1
thermo_style one
write_restart restartfile.${temp}

print "All done!" 
```

Once this one has run, the next higher temperature can use the input from the last. Use the following script with `-var temp _____ –var lasttemp _____` and specify the desired and last temperatures.
```
log output.${temp}.log
# ---------- Read restart --------------------- 
read_restart restartfile.${lasttemp}

# ---------- Neighbor lists ---------------------
neighbor 2.0 bin 
neigh_modify delay 10 check yes 

# ---------- Run Equilibration --------------------- 
reset_timestep 0
timestep _____
fix 1 all npt temp ${temp} ${temp} _____ iso 0.0 0.0 _____
thermo 50 
run _____

# ---------- Run Sampling --------------------- 
compute myMSD all msd com yes 
compute myVACF all vacf
compute myRDF all rdf 50
fix 2 all ave/time 1 1 1 c_myRDF file rdf.${temp}.out mode vector 
thermo_style custom step temp epair etotal press c_myMSD[4] c_myVACF[4]
print "StartSampling"
run _____
print "EndSampling"
#output a single snapshot at the end of the simulation
dump 1 all cfg 1 dump.${temp}.*.cfg mass type xs ys zs
compute myRDF all rdf 50
fix 2 all ave/time 100 1 100 c_myRDF file rdf.${temp}.out mode vector 
run 0

# ---------- Write restart ---------------------
unfix 1
unfix 2
uncompute myMSD
uncompute myVACF
uncompute myRDF
undump 1
thermo_style one
write_restart restartfile.${temp}

print "All done!" 
```
Using these two scripts you could have a script or supercomputer batch file with the commands the looked something like this:
```
srun ./lmp_mpi < melting_start.in -var temp _____
srun ./lmp_mpi < melting_restart.in -var temp _____ -var lasttemp _____
srun ./lmp_mpi < melting_restart.in -var temp _____ -var lasttemp _____
```
where each successive line has lasttemp as the temp from before. Or you could learn how to write for loops in a bash or shell script so you don’t have to have lots of lines.

Finally, you will have a lot of output files and the following MATLAB script will get you started on how to analyze all the files. The following script is available in this directory and is called `analyzeMelting.m`.
```matlab
temperature_list=%define array to examine various temperatures simulated
 
for i=1:length(temperature_list)
    %analyze the .log file
    T_target=temperature_list(i);
    inputFile=sprintf('output.%d.log',T_target);
    outputFile=sprintf('data.%d.txt',T_target);
    %the following command will only work on a Linux or Unix operating
    %system but cuts your file down to only the sampling data. You can do
    %this by hand if needed and skip this line.
    system(['sed -e ''1,/StartSampling/ d'' -e ''/EndSampling/,$ d'' ',...
            inputFile,' > ',outputFile]);
    %import data into an array
    A = importdata(outputFile, ' ', 4);
    d=A.data;
    %set data into variables
    Step=d(:,1);
    Temp=d(:,2);
    E_pair=d(:,3);
    TotEng=d(:,4);
    Press=d(:,5);
    myMSD=d(:,6);
    myVACF=d(:,7);
 
    %calculate the average temperature
    
    %run other calculations to operate on the data (ave TotEng, MSD, VACF)
    
    %analyze the rdf file
    inputFile=sprintf('rdf.%d.out',T_target);
    outputFile=sprintf('rdfdata.%d.txt',T_target);
    system(['sed -e ''1,/75000 50/ d'' ',...
            inputFile,' > ',outputFile]);
    %import data into an array
    B = importdata(outputFile, ' ');
    
    %plot the RDF data
    
end
 
%plot temperature dependent values
```

A former student also wrote a script to extract information from the log file, it is called `readLogH.m`.


## BYU Supercomputing 

* [Office of Research Computing Website](https://rc.byu.edu)

* [Getting started videos](https://www.youtube.com/watch?v=i1r9BxHBG0I&list=PL326A5EB4E3B16FED&feature=plpp_play_all)

* [SLURM commands](https://rc.byu.edu/wiki/?id=SLURM+Commands)

* [Job script generator](https://rc.byu.edu/documentation/slurm/script-generator)
