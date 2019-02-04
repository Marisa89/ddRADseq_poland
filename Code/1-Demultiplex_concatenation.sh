#!/bin/bash

#process_radtags version 1.48 Demultiplex and quality filtering
process_radtags -P -1 /home/marisa/Documents/Resultados/Apodemus_Poland/Raw_data/Undetermined_S0_L008_R1_001.fastq.gz -2 /home/marisa/Documents/Resultados/Apodemus_Poland/Raw_data/Undetermined_S0_L008_R3_001.fastq.gz -i gzfastq -y gzfastq -o /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/ -b /home/marisa/Documents/Resultados/Apodemus_Poland/Raw_data/barcodes -c -q -E phred33 --renz_1 sbfI --renz_2 mseI -D --retain_header --filter_illumina --adapter_1 AGATCGGAAGAGCG --adapter_2 TCTAGCCTTCTCGC -t 141


#concatenate the 4 files per sample produced by process_radtags. 


#You need to be in the folder containing the output from process_radtags
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/

mkdir concatenated

###This part creates a list with the id of the samples
for i in *.fq.gz
	do
	name=${i%%.*} 
	echo "$name"
done > samples.txt

##Now we extract each ID only one time

uniq samples.txt > sample_names.txt

##Now we can concatenate all the files with a same ID

value=$(<sample_names.txt)
for j in ${value[@]}
	do
	cat $j.* > concatenated/$j.fq.gz
done