#!/usr/bin/env bash

REF=GCF_000146795.2_Nleu_3.0_genomic.fna

while read p; do
	echo "$p"
	infile="${p}.rm12.fastq.gz"
	outfile="${p}.sam"
	./bwa mem -t 24  $REF $infile >$outfile
done <SRX590181
