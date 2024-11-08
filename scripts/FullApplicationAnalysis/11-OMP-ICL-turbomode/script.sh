#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=script
#SBATCH --output=script.o%j
#SBATCH --export=NONE
#SBATCH --partition=singlenode
#SBATCH --constraint=hwperf

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
module use ~unrz139/.modules/modulefiles
module load likwid/master-perf-mpirun

module list

################################################################################
# Loops over runs and OpenMP threads
################################################################################
for ((i = 0; i < 72; i++))
do
	for ((run = 0; run < 10; run ++))
	do
		../../../build/build_OMP_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0
	done

	for ((itr = 0; itr < 10; itr ++))
	do
        srun likwid-perfctr -C 0-$i -g MEM_DP -O ../../../build/build_OMP_ICL/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >> MEM_DP.csv
	done
done

