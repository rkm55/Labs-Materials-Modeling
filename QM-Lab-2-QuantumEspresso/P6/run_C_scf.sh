#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=0:25:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=200M   # memory per CPU core

module purge
module load gcc openmpi quantum-espresso

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""

LISTA='6.6' # list of lattice constants to be evaluated - list should be space separated
LISTECUT='100' # list of Energy Cutoff Values to be evaluated - list should be space separated
LISTK='4' # list of # of K-points for analysis to be used in evaluation - list should be space separated


#all files should be copied to a compute directory
#and this script should be exectued from that directory
USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/apps/quantum-espresso/6.5.0/gcc-8.3.0_openmpi-3.1.4"
PSEUDO_DIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0/pseudo"

rm -rf $OUTDIR/diamond.* #erase old files before beginning
#########################################################
# calculations

for ecut in $LISTECUT
do
for k in $LISTK
do
for a in $LISTA
do

echo "C.scf.$a.$ecut.$k"
rm -f $OUTDIR/C.scf.$a.$ecut.$k.in
cat > $OUTDIR/C.scf.$a.$ecut.$k.in << EOF
 &control
    calculation = 'scf'
    restart_mode='from_scratch'
    prefix='diamond'
    tstress = .true.
    tprnfor = .true.
    outdir = '$OUTDIR'
    pseudo_dir = '$PSEUDO_DIR'
 /        
 &system    
    ibrav=  2, celldm(1) =$a, nat=  2, ntyp= 1
    ecutwfc =$ecut 
 /
 &electrons
    diagonalization='david'
    mixing_mode = 'plain'
    mixing_beta = 0.7 
    conv_thr =  1.0d-8
 /
 ATOMIC_SPECIES
  C  12.011  C.pz-vbc.UPF
 ATOMIC_POSITIONS
  C 0.00 0.00 0.00 
  C 0.25 0.25 0.25                  
 K_POINTS {automatic}
    $k $k $k 0 0 0 
EOF

rm -f $OUTDIR/C.scf.$a.$ecut.$k.out #erase old files before beginning

#run the code - there are a couple ways you can run this
#    1: run with mpirun as shown and submit job using sbatch
#    2: run with srun (replace mpirun with srun) and submit job with sbatch
#    3: run with mpirun (add -n 1) so it only uses 1 processor and run from the command line
time mpirun $ESPRESSODIR/bin/pw.x < $OUTDIR/C.scf.$a.$ecut.$k.in > $OUTDIR/C.scf.$a.$ecut.$k.out
echo "Finished"

done
done
done

rm -rf $OUTDIR/diamond.* #erase unnecessary files
