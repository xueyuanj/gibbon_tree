#!/usr/bin/env bash


line=$(head -n 1 SRX590181.1)
temp="$line.addgroup.bam"

echo $temp

cp $temp SRX590181.bam

while read p; do
        tmpfile="$p.addgroup.bam"
	echo $tmpfile
	mergetmp="$p.tmp.bam"
	./samtools merge -@ 15 $mergetmp  SRX590181.bam $tmpfile
	mv $mergetmp  SRX590181.bam
done <SRX590181.2
