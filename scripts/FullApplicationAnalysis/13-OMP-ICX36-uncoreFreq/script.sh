#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=script
#SBATCH --output=script.o%j
#SBATCH --export=NONE
#SBATCH --nodelist=icx36 --exclusive
#SBATCH --constraint=hwperf

unset SLURM_EXPORT_ENV

################################################################################
# export variables
################################################################################
echo "Starting: $(date)"

export

export iter=300

export size=350

export turbo=0

################################################################################
# Load modules and list them
################################################################################
module load intel/2023.2.1 cmake/3.23.1
module load likwid/5.3.0

module list
################################################################################
# Loops over uncore frequencies
################################################################################
for freq in 1.0 1.2 1.4 1.6 1.8 2.0 2.2
do
    source /tmp/likwid-icx36/loadme.sh
    #likwid-setFrequencies -t $turbo -f $freq --umin 2.4 --umax 2.4
    likwid-setFrequencies -t $turbo
    likwid-setFrequencies --umin $freq --umax $freq
    likwid-setFrequencies -p
    source /tmp/likwid-icx36/unloadme.sh
    ################################################################################
    # Loops over OpenMP threads
    ################################################################################
    for ((i = 0; i <= 17; i++))
    do
        srun "--cpu-freq=2400000-2400000:performance" --cpu-bind=none likwid-perfctr -C 0-$i -g MEM_DP -O ../../../build/build_OMP_ICX36/lulesh2.0 -p -b 0 -s ${size} -i ${iter} -c 0 >> MEM_DP.csv
    done
done
