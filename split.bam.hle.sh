#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=8
#PBS -l pmem=2gb
#PBS -m abe
#PBS -M xjj5003@psu.edu
#PBS -j oe

cd /storage/home/xjj5003/scratch
date

while read p; do
	echo "$p"
	newfile="hle.srx590196.srx590198.${p}.bam"
	./samtools view -bh  hle.srx590196.srx590198.bam $p > $newfile
done <gibbon.chromosomes.txt

date
