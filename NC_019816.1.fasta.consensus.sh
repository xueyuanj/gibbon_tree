#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=8
#PBS -l pmem=2gb
#PBS -m abe
#PBS -M xjj5003@psu.edu
#PBS -j oe

cd /storage/home/xjj5003/scratch
date


REF=GCF_000146795_2_Nleu_3_0_genomic.fa

for file in *.NC_019816.1.bqsr.bam
do
	echo $file
	core=${file%.bam}
	vcffile="${core}.consensus.vcf"
	fafile="${core}.consensus.fa"
	./bcftools mpileup -Ou -f $REF  $file | ./bcftools call -Ou -mv| ./bcftools filter  -s LowQual -e '%QUAL<20 || DP>100'  >$vcffile 
	./bgzip $vcffile
	./bcftools index "${vcffile}.gz"
	./bcftools consensus -f $REF "${vcffile}.gz" > $fafile
done

date
