##Download the SRR runs for the project

##8 gibbon individuals

$ esearch -db bioproject -query "PRJNA232723" |elink -target sra|efetch -format docsum|\xtract -pattern DocumentSummary -ACC @acc -block DocumentSummary -element "&ACC" > gibbon.total.run.txt
