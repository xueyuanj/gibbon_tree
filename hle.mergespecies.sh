#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=8
#PBS -l pmem=2gb
#PBS -m abe
#PBS -M xjj5003@psu.edu
#PBS -j oe

cd /storage/home/xjj5003/scratch
date

java -jar picard.jar MergeSamFiles  I=SRX590196.realigned.rmdup.cleansam.bam I=SRX590198.realigned.rmdup.cleansam.bam O=hle.srx590196.srx590198.bam

date
