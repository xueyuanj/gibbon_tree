#!/usr/bin/env bash

REF=GCF_000146795.2_Nleu_3.0_genomic.fna

while read p; do
        echo "$p"
        samfile="${p}.sam"
        bamfile="${p}.bam"
        ./samtools sort -@ 15 -m 1G $samfile > $bamfile
        ./samtools index -@ 15 $bamfile
	addgroup="${p}.addgroup.bam"
	java -jar picard.jar AddOrReplaceReadGroups I=$bamfile O=$addgroup RGID=$p RGLB=lib1 RGPL=illumina RGPU=uni1 RGSM=20
done <SRX590181
