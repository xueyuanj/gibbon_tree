#!/usr/bin/env bash

REF=GCF_000146795.2_Nleu_3.0_genomic.fna

p=SRX590181
addgroup="$p.bam"

./samtools index -@ 15 $addgroup
realcreator="${p}.intervals"
java -jar GenomeAnalysisTK.jar -T RealignerTargetCreator -R $REF -I $addgroup -o $realcreator
realigned="${p}.realigned.bam"
java -jar GenomeAnalysisTK.jar -T IndelRealigner -R $REF -targetIntervals $realcreator -I $addgroup -o $realigned
rmdup="${p}.realigned.rmdup.bam"
./samtools rmdup $realigned  $rmdup
cleanbam="${p}.realigned.rmdup.cleansam.bam"
java -jar picard.jar CleanSam I=$rmdup O=$cleanbam
