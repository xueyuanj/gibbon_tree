#!/bin/bash          

        
while read i; do
	echo $i
	qsub -A rua15_a_g_sc_default  "$i.mergesample.sh"
done <srrfiles.name 
