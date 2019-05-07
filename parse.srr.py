import re

runinfor = open("gibbon.total.run.txt", "r")

alleight = runinfor.readlines()

for srrid in alleight:
	sample = re.search("SRX\w+", srrid).group(0)
	runs = re.findall("SRR\w+", srrid)
	samplefile = open(sample, "w")
	for runids in runs:
		samplefile.write(runids+"\n")