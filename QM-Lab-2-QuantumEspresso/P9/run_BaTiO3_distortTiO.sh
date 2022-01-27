#!/bin/bash
# This script will sweep through the oxygen displacements of BaTiO3
# to find the stablest tetragonal phase 

#Submit this script with: sbatch thefilename

#SBATCH --time=0:30:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=200M   # memory per CPU core

module purge
module load gcc openmpi quantum-espresso


USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/apps/quantum-espresso/6.5.0/gcc-8.3.0_openmpi-3.1.4"
PSEUDO_DIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0/pseudo"
LatParam=  # don't forget to set this
DistortTi=  # don't forget to set this

rm -rf BaTiO3.distortTiO.pot BaTiO3.distortTiO.rho BaTiO3.distortTiO.save BaTiO3.distortTiO.wfc BaTiO3.distortTiO.igk
echo "BaTiO3_distortTiO.in"
cat > BaTiO3_distortTiO.in << EOF
 &control
    calculation = 'relax',
    restart_mode = 'from_scratch',
    prefix = 'BaTiO3.distortTiO',
    tstress = .true.,
    tprnfor = .true.,
    pseudo_dir='$PSEUDO_DIR'
    outdir='$OUTDIR'
 /
 &system
    ibrav =  1, 
    celldm(1) = $LatParam, 
    nat =  5, 
    ntyp = 3,
    ecutwfc = 30.0,
    ecutrho = 240.0
 /
 &electrons
    diagonalization='cg',
    mixing_mode = 'plain',
    mixing_beta = 0.7,
    conv_thr =  1.0d-8
 /
 &ions
    ion_dynamics='bfgs'
 /

ATOMIC_SPECIES
 Ba 137.327 Ba.UPF
 Ti 47.88   Ti.UPF
 O  15.9994 O.UPF

ATOMIC_POSITIONS
 Ba 0.0 0.0 0.0 0 0 0
 Ti 0.5 0.5 $DistortTi 
 O 0.5 0.5 0
 O 0.5 0.0 0.5
 O 0.0 0.5 0.5

K_POINTS automatic
  4 4 4 1 1 1
EOF

$ESPRESSODIR/bin/pw.x < BaTiO3_distortTiO.in > BaTiO3_distortTiO.out
echo "Done"