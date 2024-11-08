# Artifact Description (AD) / Artifact Evaluation (AE)
# Title: Analytic Roofline Modeling and Energy Analysis of the LULESH Proxy Application on Multi-Core Clusters

### Table of Contents

* [A. Abstract](#Abstract)
* [B. Description](#Description)
    * [B.1 Check-list (artifact meta information)](#Check-list)
        * [B1.1.1 Algorithms and Programs](#Programs)
        * [B1.1.2 Compilation](#Compilation)
        * [B1.1.3 Binary](#Binary)
        * [B1.1.4 Hardware](#Hardware)
        * [B1.1.5 Run-time environment and state](#state)
        * [B1.1.6 Output](#Output)
        * [B1.1.7 Publicly available?](#available)
    * [B.2. How software can be obtained (if available)](#software)
    * [B.3. Hardware dependencies](#HWD)
    * [B.4. Software dependencies](#SWD)
    * [B.5. Datasets](#Datasets)
* [C. Installation](#Installation)
* [D. Experiment workflow](#WF)
* [E. Evaluation and expected result](#Evaluation)
* [D. Experiment workflow](#WF)
* [F. Experiment customization](#Experiment)
* [G. Results Analysis Discussion](#Results)
* [H. Summary](#Summary)
* [I. Notes](#Notes)

<a name="Abstract"></a>
## A. Abstract

<a name="Description"></a>
## B. Description

To allow a third party to duplicate the findings, this article provides reproducibility initiative dependencies (Artifact Description or Artifact Evaluation or Computational Results Analysis) appendix at [https://doi.org/10.5281/zenodo.14056332](https://doi.org/10.5281/zenodo.14056332). 
In addition to our extensive performance data artifact, it further describes details regarding the software environments, experimental design, and methodology employed for the results shown in the paper. 
The computational artifacts will enable experienced performance engineers to reproduce and interpret the data shown in the paper in the appropriate way and to follow the conclusions we draw from it.

<a name="Check-list"></a>
### B.1 Check-list (artifact meta information)

<a name="Programs"></a>

- **B1.1.1 Algorithms and Programs**: We employed MPI and OpenMP parallel programming models for Livermore Unstructured Lagrangian Explicit Shock Hydrodynamics (LULESH) application.

<a name="Compilation"></a>

- **B1.1.2 Compilation**: All information can be found in [builds](builds) and [scripts](scripts).

<a name="Binary"></a>

- **B1.1.3 Binary**: x86

<a name="Hardware"></a>

- **B1.1.4 Hardware** 

     - ClusterA: 36 core Intel Xeon Ice Lake (Platinum 8360Y) CPUs and HDR-100 InfiniBand 
     - ClusterB: 52 core Intel Xeon Sapphire (Platinum 8470) Rapids CPUs and HDR-100 InfiniBand 
      
      Further information on hardware is available in Table 1 of the paper.

<a name="state"></a>

- **B1.1.5 Run-time environment and state**:
A thorough state description of the two systems that were utilized to conduct the experiments can be found in [`machine-states`](machine-states).
This lists comprehensive hardware information on 

     - libraries and compilers along with their versions 
     - operating system kernel, version and other details
     - CPUset
     - topology (cores, cache, NUMA)
     - NUMA balancing
     - general memory details 
     - transparent huge pages
     - performance energy bias
     - hardware power limits

<a name="Output"></a>

- **B1.1.6 Output**

     - Navigate to the [output-data-perf-power-energy](output-data-perf-power-energy) for additional thoroughly investigated performance, power and energy results, which are inside and outside the results published in the paper:

          - `performance [z/s]` (total, scalar, vectorized)
          - `runtime [s]` and `speedup` 
          - `FP arithmetic instructions` (scalar, packed 128 B, packed 256 B, packed 512 B)
          - `Òverall instructions retired`
          - `memory bandwidth [GBytes/s]` (total, read, write)
          - `memory data volume [GByte]` (total, read, write)
          - `operational intensity [F/B]`
          - `cycles per instruction, CPI`
          - `power [Watt]` (total, chip, DRAM) 
          - `energy [Joule]` (total, chip, DRAM) 

<a name="available"></a>

- **B1.1.7 Publicly available?**
```
yes
```

<a name="software"></a>
### B.2. How software can be obtained (if available)
To download softwares, check out the following website.

* Original proxy application: [https://asc.llnl.gov/codes/proxy-apps/lulesh](https://asc.llnl.gov/codes/proxy-apps/lulesh)
* Modified code: [modified-code](modified-code)
* Intel C++ compiler: [https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/dpc-compiler.html](https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/dpc-compiler.html)
* Intel MPI library: [https://intel.com/content/www/us/en/developer/tools/oneapi/mpi-library.html](https://intel.com/content/www/us/en/developer/tools/oneapi/mpi-library.html)
* Intel VTune: [https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html)
* LIKWID: [https://github.com/RRZE-HPC/likwid](https://tiny.cc/LIKWID)

<a name="HWD"></a>
### B.3. Hardware dependencies
Unless specified otherwise, experiments were conducted on ClusterA (Intel Xeon Ice Lake CPUs) at a base clock-frequency of 2.4 GHz (fixed, turbo disabled), and on ClusterB (Intel Xeon Sapphire Rapid CPUs) at a base clock frequency of 2.0 GHz (fixed, turbo disabled).
The reproducibility of experiments requires mapping consecutive MPI processes to consecutive cores and fixing the frequency and switching-off the turbo mode.
For node-level analysis, as the RAPL measurements often differ between nodes, all code versions employed the same node. 

<a name="SWD"></a>
### B.4. Software dependencies
* [Livermore Unstructured Lagrangian Explicit Shock Hydrodynamics (LULESH)](https://asc.llnl.gov/codes/proxy-apps/lulesh), version 2.0
* [Intel C++ compiler](https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/dpc-compiler.html), version 2023, update 2
* [Intel MPI library](https://www.intel.com/content/www/us/en/developer/tools/oneapi/mpi-library.html), version 2021, update 7
* Analyzing results metrics
     * [Intel VTune](https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html), version 2023, update 2
     * [LIKWID](https://tiny.cc/LIKWID), version 2024, update 5.3.0 and 5.3.0/saprap1
* Monitoring results metrics: [ClusterCockpit](https://monitoring.nhr.fau.de), version 2023, update 1.0.0

<a name="Datasets"></a>
### B.5. Datasets
Table 1 of the paper contains further information on input setup.

<a name="Installation"></a>
## C. Installation
Please install the above-mentioned software dependencies.

<a name="WF"></a>
## D. Experiment workflow
To reproduce the experimental results, git clone the following repository and download modified code from the [modified-code](modified-code):
```
git clone https://github.com/RRZE-HPC/LULESH-AD && cd LULESH-AD/
```
To run OpenMP- and MPI-parallel LULESH code and to generate performance, power and energy results, the description for compiling and running can be found in the files available at the [builds](builds) and [scripts](scripts).

Outputs can be compared with results available in [output-data-perf-power-energy](output-data-perf-power-energy). 

<a name="Evaluation"></a>
## E. Evaluation and expected result
See paper. 

<a name="Experiment"></a>
## F. Experiment customization
See section 2 of the paper.

<a name="Results"></a>
## G. Results analysis discussion
See paper. 

<a name="Summary"></a>
## H. Summary
Please see the `upshots` and Section 7 of the paper that presents the summary.

<a name="Notes"></a>
## I. Notes
Please cite the work as:

* A. Afzal, G. Hager, and G. Wellein: Analytic Roofline Modeling and Energy Analysis of the LULESH Proxy Application on Multi-Core Clusters. [DOI:..](https://arxiv.org/...)

Bibtex:  
> @INPROCEEDINGS{SPEC2023,  
>   author={Afzal, Ayesha and Hager, Georg and Wellein, Gerhard},  
>   booktitle={arxiv},   
>   title={Analytic Roofline Modeling and Energy Analysis of the LULESH Proxy Application on Multi-Core Clusters},   
>   year={2024},  
>   doi={...}}

* A. Afzal, G. Hager, and G. Wellein: Analytic Roofline Modeling and Energy Analysis of the LULESH Proxy Application on Multi-Core Clusters -- Performance Data Artifact Appendix. [DOI:
10.5281/zenodo.14056332](https://doi.org/10.5281/zenodo.14056332)

Bibtex:  
> @INPROCEEDINGS{SPECAD2023,  
>   author={Afzal, Ayesha and Hager, Georg and Wellein, Gerhard},  
>   booktitle={[online]},   
>   title={Analytic Roofline Modeling and Energy Analysis of the LULESH Proxy Application on Multi-Core Clusters {--} Performance Data Artifact Appendix},   
>   year={2024},  
>   doi={10.5281/zenodo.14056332.}} 
