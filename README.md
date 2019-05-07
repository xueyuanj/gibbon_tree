##Download the SRR runs for the project

##8 gibbon individuals

$ esearch -db bioproject -query "PRJNA232723" |elink -target sra|efetch -format docsum|\xtract -pattern DocumentSummary -ACC @acc -block DocumentSummary -element "&ACC" > gibbon.total.run.txt

##Install cutadapt on cluster

$ cd ~/work

$ mkdir conda_cutadapt && cd conda_cutadapt

$ mkdir $PWD/conda_pkgs

$ export CONDA_PKGS_DIRS=$PWD/conda_pkgs

$ module load python/3.6.3-anaconda5.0.1

$ conda create -y --prefix $PWD

$ source activate $PWD

$ conda install -c bioconda cutadapt
