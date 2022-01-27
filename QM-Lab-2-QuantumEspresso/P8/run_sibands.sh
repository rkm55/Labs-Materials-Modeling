#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=0:05:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=100M   # memory per CPU core

module purge
module load gcc openmpi quantum-espresso

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""

#all files should be copied to a compute directory
#and this script should be exectued from that directory
USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/apps/quantum-espresso/6.5.0/gcc-8.3.0_openmpi-3.1.4"
PSEUDO_DIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0/pseudo"

echo "Si.scf.in"
rm -f $OUTDIR/Si.scf.in
cat > $OUTDIR/Si.scf.in << EOF

&control
    prefix='silicon',
    outdir = '$OUTDIR'
    pseudo_dir = '$PSEUDO_DIR'
 /
 &system    
    ibrav=  2, celldm(1) =10.2, nat=  2, ntyp= 1,
    ecutwfc = 12.0, 
 /
 &electrons
 /
ATOMIC_SPECIES
 Si  28.086  Si.vbc.UPF
ATOMIC_POSITIONS
 Si 0.00 0.00 0.00 
 Si 0.25 0.25 0.25 
K_POINTS
   2
   0.25 0.25 0.75 3.0
   0.25 0.25 0.25 1.0
  
EOF

mpirun $ESPRESSODIR/bin/pw.x < $OUTDIR/Si.scf.in > $OUTDIR/Si.scf.out
echo "Done"

echo "Sibands.in"
rm -f $OUTDIR/Sibands.in
cat > $OUTDIR/Sibands.in << EOF
 &control
    calculation='bands',
    prefix='silicon',
    outdir = '$OUTDIR'
    pseudo_dir = '$PSEUDO_DIR'
 /
 &system    
    ibrav=  2, celldm(1) = 10.2, nat=  2, ntyp= 1,
    ecutwfc = 12.0, nbnd = 8, 
 /
 &electrons
 /
ATOMIC_SPECIES
 Si  28.086  Si.vbc.UPF
ATOMIC_POSITIONS
 Si 0.00 0.00 0.00 
 Si 0.25 0.25 0.25 
K_POINTS
   36
     0.5 0.5 0.5  1
     0.4 0.4 0.4  2
     0.3 0.3 0.3  3
     0.2 0.2 0.2  4
     0.1 0.1 0.1  5
     0.0 0.0 0.0  6
     0.0 0.0 0.1  7
     0.0 0.0 0.2  8
     0.0 0.0 0.3  9
     0.0 0.0 0.4 10
     0.0 0.0 0.5 11
     0.0 0.0 0.6 12
     0.0 0.0 0.7 13
     0.0 0.0 0.8 14
     0.0 0.0 0.9 15
     0.0 0.0 1.0 16
     0.0 0.1 1.0 17
     0.0 0.2 1.0 18
     0.0 0.3 1.0 19
     0.0 0.4 1.0 20
     0.0 0.5 1.0 21
     0.0 0.6 1.0 22
     0.0 0.7 1.0 23
     0.0 0.8 1.0 24
     0.0 0.9 1.0 25
     0.0 1.0 1.0 26
     0.0 0.9 0.9 27
     0.0 0.8 0.8 28
     0.0 0.7 0.7 29
     0.0 0.6 0.6 30
     0.0 0.5 0.5 31
     0.0 0.4 0.4 32
     0.0 0.3 0.3 33
     0.0 0.2 0.2 34
     0.0 0.1 0.1 35
     0.0 0.0 0.0 36

EOF

#run the code - there are a couple ways you can run this
#    1: run with mpirun as shown and submit job using sbatch
#    2: run with srun (replace mpirun with srun) and submit job with sbatch
#    3: run with mpirun (add -n 1) so it only uses 1 processor and run from the command line
mpirun $ESPRESSODIR/bin/pw.x < $OUTDIR/Sibands.in > $OUTDIR/Sibands.out
echo "Done"

echo "bands.in"
rm -f $OUTDIR/bands.in
cat > $OUTDIR/bands.in << EOF
 &bands
    prefix  = 'silicon'
    outdir='$OUTDIR'
    filband = 'bands.dat'
 /

EOF

#run the code - there are a couple ways you can run this
#    1: run with mpirun as shown and submit job using sbatch
#    2: run with srun (replace mpirun with srun) and submit job with sbatch
#    3: run with mpirun (add -n 1) so it only uses 1 processor and run from the command line
mpirun $ESPRESSODIR/bin/bands.x < $OUTDIR/bands.in > $OUTDIR/bands.out

echo "Band calculation finished"

##now you must run the following interactively
#$ESPRESSODIR/bin/plotband.x
echo -e "#now you must run the following interactively"
echo -e "$ESPRESSODIR/bin/plotband.x"
