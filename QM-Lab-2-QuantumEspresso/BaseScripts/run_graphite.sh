#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=0:25:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=400M   # memory per CPU core

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""


LISTA='4.64117' # list of lattice constants to be evaluated - list should be space separated
LISTECUT='80' # list of Energy Cutoff Values to be evaluated - list should be space separated
LISTK='8' # list of # of K-points for analysis to be used in evaluation - list should be space separated


#all files should be copied to a compute directory
#and this script should be exectued from that directory
USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0"
PSEUDO_DIR="$ESPRESSODIR/pseudo"

rm -rf $OUTDIR/diamond.* #erase old files before beginning
#########################################################
# calculations

for ecut in $LISTECUT
do
for k in $LISTK
do
for a in $LISTA
do

ecutrho=`bc <<< $ecut*6`


echo "graphite.scf.$a.$ecut.$k"
rm -f $OUTDIR/graphite.scf.$a.$ecut.$k.in
cat > $OUTDIR/graphite.scf.$a.$ecut.$k.in << EOF
 &control
    calculation = 'scf'
    restart_mode='from_scratch',
    prefix='graphite',
    tstress = .true.
    tprnfor = .true.
    pseudo_dir='$PSEUDO_DIR'
    outdir='$OUTDIR'

   forc_conv_thr = 1.0D-3
 /

 &system
    ibrav           = 4
    celldm(1)       = $a
    celldm(3)       = 2.7264
    
    nat             = 4 
    ntyp            = 1

    occupations     = 'fixed'
    smearing        = 'methfessel-paxton'
    degauss         = 0.02

    ecutwfc         = $ecut
    ecutrho         = $ecutrho

    input_dft  	    = 'vdW-DF'
 /

 &electrons
    conv_thr        = 1.0d-8
 /
 &ions
 /
 &cell
    press_conv_thr  = 0.5D0
    press           = 0.D0
    cell_dynamics   = 'bfgs'
    cell_dofree     = 'z'
 /

 ATOMIC_SPECIES
    C   12.00   C.pbe-rrkjus.UPF

 ATOMIC_POSITIONS {alat}
    C      0.0000000000 0.0000000000 0.0000000000 
    C      0.0000000000 0.5773502692 0.0000000000
    C      0.0000000000 0.0000000000 1.3632000000
    C      0.5000000000 0.2886751346 1.3632000000

 K_POINTS automatic
    $k $k $k 1 1 1    
 
EOF

rm -f $OUTDIR/graphite.scf.$a.$ecut.$k.out #erase old files before beginning
time mpirun $ESPRESSODIR/bin/pw.x < $OUTDIR/graphite.scf.$a.$ecut.$k.in > $OUTDIR/graphite.scf.$a.$ecut.$k.out
echo "Finished"

done
done
done
