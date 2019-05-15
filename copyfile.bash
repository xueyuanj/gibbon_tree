#!/bin/bash          

        
while read i; do
	echo $i
	cp SRX590181.mergesample.bash  "$i.mergesample.bash"
	sub="s/SRX590181/${i}/g"
	echo $sub
	sed -i $sub "$i.mergesample.bash"
	cp SRX590181.mergesample.sh "$i.mergesample.sh"
	sed -i $sub "$i.mergesample.sh"
done <srrfiles.name 
