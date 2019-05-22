#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=8
#PBS -l pmem=2gb
#PBS -m abe
#PBS -M xjj5003@psu.edu
#PBS -j oe

cd /storage/home/xjj5003/scratch
date


REF=GCF_000146795.2_Nleu_3.0_genomic.fna

for file in *.NC_019816.1.bam
do
	./samtools index -@ 15 $file
	core=${file%.bam}
	echo $core
	gtoutput="${core}.vcf"
	java -jar GenomeAnalysisTK.jar -T UnifiedGenotyper -R $REF -I $file  --min_base_quality_score 50 -o $gtoutput
	bcoutput="${core}.table"
	java -jar GenomeAnalysisTK.jar -T BaseRecalibrator -R $REF -I $file -knownSites $gtoutput -o $bcoutput
	bamoutput="${core}.bqsr.bam"
	java -jar GenomeAnalysisTK.jar -T PrintReads -R $REF -I $file -BQSR $bcoutput -o $bamoutput
done

date
