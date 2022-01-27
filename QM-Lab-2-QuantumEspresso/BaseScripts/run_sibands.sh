#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=0:05:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=100M   # memory per CPU core

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""

#all files should be copied to a compute directory
#and this script should be exectued from that directory
USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0"
PSEUDO_DIR="$ESPRESSODIR/pseudo"

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

mpirun $ESPRESSODIR/bin/pw.x < $OUTDIR/Sibands.in > $OUTDIR/Sibands.out
echo "Done"

echo "bands.in"
rm -f $OUTDIR/bands.in
cat > $OUTDIR/bands.in << EOF
 &bands
    prefix  = 'silicon'
    outdir='/fslhome/----4/compute/ME595R/qm/sibands'
    filband = 'bands.dat'
 /

EOF

mpirun $ESPRESSODIR/bin/bands.x < $OUTDIR/bands.in > $OUTDIR/bands.out

echo "Done"

#now you must run the followign interactively
/fslhome/$USER/fsl_groups/fslg_ME595R/espresso-5.0/bin/plotband.x
