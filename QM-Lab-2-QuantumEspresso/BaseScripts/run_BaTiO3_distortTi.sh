#!/bin/bash
# This script will sweep through the oxygen displacements of BaTiO3
# to find the stablest tetragonal phase 

#Submit this script with: sbatch thefilename

#SBATCH --time=0:30:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=200M   # memory per CPU core


USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0"
PSEUDO_DIR="$ESPRESSODIR/pseudo"
LatParam=  # don't forget to set this

for distort in 502 504 506 508 510 512 514 516 518 520
do
rm -rf *.pot *.rho *.save *.wfc *.igk BaTiO3_distortTi.$distort.in
echo "BaTiO3_distortTi.$distort.in"
cat > BaTiO3_distortTi.$distort.in << EOF
 &control
    calculation = 'relax',
    restart_mode = 'from_scratch',
    prefix = 'BaTiO3.distortTi',
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
 Ti 0.5 0.5 0.$distort 0 0 0
 O 0.5 0.5 0
 O 0.5 0.0 0.5
 O 0.0 0.5 0.5

K_POINTS automatic
  4 4 4 1 1 1
EOF

$ESPRESSODIR/bin/pw.x < BaTiO3_distortTi.$distort.in > BaTiO3_distortTi.$distort.out
echo "Done"
done
