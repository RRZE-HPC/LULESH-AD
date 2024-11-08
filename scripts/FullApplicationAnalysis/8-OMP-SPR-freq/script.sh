#!/bin/bash -l
#SBATCH --nodes=1
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

export size=350
export iter=300

################################################################################
# Load modules and list them
################################################################################
module load intel/2023.2.1 cmake/3.23.1
module load likwid/5.3.0-spr

module list

################################################################################
# Loops over CPU clock frequencies
################################################################################
for ((f = 1000000; f <= 2800000; f += 200000))
do
    ################################################################################
    # Loops over OpenMP threads
    ################################################################################
	for ((i = 0; i <= 12; i ++))
	do
		srun --cpu-freq=$f-$f:performance likwid-perfctr -C 0-$i -g MEM_DP -O ../../../build/build_OMP_SPR/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >> MEM_DP.csv
	done
done

