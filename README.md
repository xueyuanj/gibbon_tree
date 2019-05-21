## Download the SRR runs for the project

##8 gibbon individuals, 5 species

$ esearch -db bioproject -query "PRJNA232723" |elink -target sra|efetch -format docsum|\xtract -pattern DocumentSummary -ACC @acc -block DocumentSummary -element "&ACC" > gibbon.total.run.txt

##Parse the file into samples

##File name as individual sample name

$python parse.srr.py

##
##
For the purpose of parallel processing, the same scripts are running simultaneously for each sample (individual)

The SRX IDs are in srxfile.name

Generation of script copies: copyfile.bash

Submission of jobs: submitjob.sh
##
##


## Trim adapter

##Install cutadapt on cluster

$ cd ~/work

$ mkdir conda_cutadapt && cd conda_cutadapt

$ mkdir $PWD/conda_pkgs

$ export CONDA_PKGS_DIRS=$PWD/conda_pkgs

$ module load python/3.6.3-anaconda5.0.1

$ conda create -y --prefix $PWD

$ source activate $PWD

$ conda install -c bioconda cutadapt

##Afterwards, move the app to desired places

##Download SRR files, run cutadapt on them

$ bash SRX590181.bash

##Use SRX590181.sh to submit the job on the cluster

##For the other seven gibbon samples, copy the files and run as the previous one

$ bash copyfile.bash

##
##

## Run alignment

##Get the reference genome Nleu 3.0

$wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/795/GCF_000146795.2_Nleu_3.0/GCF_000146795.2_Nleu_3.0_genomic.fna.gz

##Index the reference genome

$ ./bwa index GCF_000146795.2_Nleu_3.0_genomic.fna 

##Align with bwa mem


$bash SRX590181.align.bash

For future reference, use bwa mem -R $TAG $REF $R1 $R2 | samtools sort > bwa.bam

Here the TAG='@RG\tID:xyz\tSM:Ebola\tLB:patient_100'

##
##
## Clean the sam/bam files 

##Make the files ready for GATK and Picard

##Generate .fai and .dict files for the reference genome

./samtools faidx GCF_000146795.2_Nleu_3.0_genomic.fna

java -jar picard.jar CreateSequenceDictionary R=GCF_000146795.2_Nleu_3.0_genomic.fna O=GCF_000146795.2_Nleu_3.0_genomic.fna.dict


##The steps include:

1)sort sam files, create bam files, index bam files

2)add read groups

$bash SRX590181.clean.bash

--> SRR*.addgroup.bam
##

3)merge files within samples

$ bash SRX590181.mergesample.bash
##

4)run local realignment on INDELs

5)remove PRC duplicates

6)further clean with CleanSam

$ bash SRX590181.sampleclean.bash

--> SRX*.realigned.rmdup.cleansam.bam

7)merge by species, then split each into 100 files

HLE: SRX590196, SRX590198

NLE: SRX590181, SRX590192

SSY: SRX590189, SRX590195

$ qsub -A rua15_a_g_sc_default  hle.mergespecies.sh

Index the files, then split into different chromosomes (ignore the scaffolds)


##
##
## Generate consensus fasta files for each species

##Merge sample by species (there are three species that each has two individuals)




