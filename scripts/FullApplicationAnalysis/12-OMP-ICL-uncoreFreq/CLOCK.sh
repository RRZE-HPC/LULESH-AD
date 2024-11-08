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

export size=350

################################################################################
# Load modules and list them
################################################################################
module load intel/2023.2.1 cmake/3.23.1
module load likwid

module list

################################################################################
# Loops over CPU clock frequencies
################################################################################
for ((f = 1000000; f <= 2800000; f += 200000))
do
    ################################################################################
    # Loops over OpenMP threads
    ################################################################################
	for ((i = 0; i <= 17; i ++))
	do
        srun --cpu-freq=$f-$f:performance likwid-perfctr -C 0-$i -g CLOCK -O ../../../build/build_OMP_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >> CLOCK.csv
	done
done

