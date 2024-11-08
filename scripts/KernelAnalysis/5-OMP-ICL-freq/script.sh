#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=script
#SBATCH --output=script.o%j
#SBATCH --export=NONE
#SBATCH --reservation=icl-ihpc
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

################################################################################
# Load modules and list them
################################################################################
module load intel/2023.2.1 cmake/3.23.1
module use ~unrz139/.modules/modulefiles
module load likwid/master-perf-mpirun

module list

################################################################################
# Loop over CPU clock frequencies
################################################################################
for ((f = 1000000; f <= 2800000; f += 200000))
do
    ################################################################################
    # Loop over OpenMP threads
    ################################################################################
    for ((i = 0; i <= 17; i++))
    do
    
        srun "--cpu-freq=$f-$f:performance" likwid-perfctr -C 0-$i -m -g MEM_DP -O ../../../build/build_OMP_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >> MEM_DP_$i.csv
    
    done
done
