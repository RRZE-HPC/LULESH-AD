#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=script
#SBATCH --output=script.o%j
#SBATCH --export=NONE
#SBATCH --partition=singlenode
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
module load intel/2023.2.1 cmake/3.23.1 intelmpi/2021.10.0
module use ~unrz139/.modules/modulefiles
module load likwid/master-perf-mpirun

module list

################################################################################
# Loop over Domain sizes
################################################################################
for size in 30 60 90 120 150 250 350; do

    ################################################################################
    # Loop over MPI processes
    ################################################################################
    for i in 1 8 27 64; do
    
        likwid-mpirun --debug -mpi slurm --mpiopts "--cpu-freq=2400000-2400000:performance" --np $i -nperdomain N:$i -g MEM_DP -O ../../../build/build_MPI_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >>  size_${size}/MEM_DP_$i.csv
            
    done
done
