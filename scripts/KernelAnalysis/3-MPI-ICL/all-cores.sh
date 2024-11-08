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
# Export variables
################################################################################
echo "Starting: $(date)"

export

export size=150
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
# Loop over MPI Processes
################################################################################
for i in 1 8 27 64
do

    likwid-mpirun --debug --np $i -g MEM_DP -mpi slurm --mpiopts "--cpu-freq=2400000-2400000:performance" -nperdomain N:$i -m -O ../../../build_MPI_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >>  MEM_DP_$i.csv

done

