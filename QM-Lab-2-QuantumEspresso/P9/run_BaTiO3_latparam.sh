#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --time=0:15:00   # walltime - you'll usually want more than this
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks) - you'll usually want more than this
#SBATCH --nodes=1   # number of nodes - you'll usually want more than this
#SBATCH --mem-per-cpu=200M   # memory per CPU core

module purge
module load gcc openmpi quantum-espresso

USER=`whoami`
OUTDIR=`pwd`
ESPRESSODIR="/apps/quantum-espresso/6.5.0/gcc-8.3.0_openmpi-3.1.4"
PSEUDO_DIR="/fslhome/$USER/fsl_groups/fslg_MaterialsModeling/espresso-5.0/pseudo"

for lattice in 7.40 7.42 7.44 7.46 7.48 7.50 7.52 7.54 7.56 7.58 7.60 7.62 \
7.64 7.66 7.68 7.70
do
rm -rf *.pot *.rho *.save *.wfc *.igk BaTiO3.lat.$lattice.in
echo "BaTiO3.lat.$lattice.in"
cat > BaTiO3.lat.$lattice.in << EOF
 &control
    calculation = 'scf',
    restart_mode = 'from_scratch',
    prefix = 'BaTiO3',
    tstress = .true.,
    tprnfor = .true.,
    pseudo_dir='$PSEUDO_DIR'
    outdir='$OUTDIR'
 /
 &system
    ibrav =  1, 
    celldm(1) = $lattice, 
    nat =  5, 
    ntyp = 3,
    ecutwfc = 30.0,
    ecutrho = 240.0
 /
 &electrons
    diagonalization = 'cg',
    mixing_mode = 'plain',
    mixing_beta = 0.7,
    conv_thr = 1.0d-8
 /

ATOMIC_SPECIES
 Ba 137.327 Ba.UPF
 Ti 47.88   Ti.UPF
 O  15.9994 O.UPF

ATOMIC_POSITIONS
 Ba 0.0 0.0 0.0
 Ti 0.5 0.5 0.5
 O 0.5 0.5 0
 O 0.5 0.0 0.5
 O 0.0 0.5 0.5

K_POINTS automatic
  4 4 4 1 1 1
EOF

$ESPRESSODIR/bin/pw.x < BaTiO3.lat.$lattice.in > BaTiO3.lat.$lattice.out
echo "Done"
done
