#!/usr/bin/env bash

while read p; do
        echo "$p"
        ./fastq-dump --gzip $p
        downfile="${p}.fastq.gz"
        remove1="${p}.rm1.fastq.gz"
        ./cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o $remove1  $downfile
        remove2="${p}.rm12.fastq.gz"
        ./cutadapt -a AAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --minimum-length 25  -o $remove2 $remove1
        rm $remove1
        rm $downfile    
done <SRX590181