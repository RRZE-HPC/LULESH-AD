#!/bin/bash -l
#SBATCH --nodes=8
#SBATCH --time=24:00:00
#SBATCH --job-name=script
#SBATCH --output=script.o%j
#SBATCH --export=NONE
#SBATCH -p spr1tb
#SBATCH --constraint=hwperf

unset SLURM_EXPORT_ENV
################################################################################
# export variables
################################################################################
echo "Starting: $(date)"

export

export iter=300

export OMP_NUM_THREADS=1

################################################################################
# Load modules and list them
################################################################################
module load intel/2023.2.1 cmake/3.23.1
module load intelmpi/2021.10.0 likwid/5.3.0-spr

module list

################################################################################
# Loop over Domain sizes
################################################################################
for size in 30 60 90 120 150; do

    ################################################################################
    # Loop over MPI processes
    ################################################################################
    for ((n = 1; n <= 13 ; n ++))
    do
        likwid-mpirun --debug -mpi slurm --mpiopts "--cpu-freq=2000000-2000000:performance" -np $((n**3)) -nperdomain N:104 -g MEM_DP -O ../../../build/build_MPI_SPR/lulesh2.0 -p -b 0 -c 0 -s ${size} -i ${iter} >> size_${size}/MEM_DP.csv
    done
done
