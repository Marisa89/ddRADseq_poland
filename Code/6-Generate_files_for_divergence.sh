#!bin/bash

#Make list of loci
cat batch_124.samples.fa |sed 's/Sample/ Sample/g'|cut -f1 -d " "|grep CLocus| uniq | sed 's/>CLocus/CLocus/g' > list_of_loci

#Generate a file per locus
mkdir CLocus
for file in $(cat list_of_loci); do cat batch_124.samples.fa| grep -A1 $file > CLocus/$file.fa; done

#Separate sequences by species
cd CLocus/
mkdir flavicollis
mkdir sylvaticus

for file in *_.fa
do
name=${file%_.fa}
grep -A1 'D07\|E07\F07\|G07\|H07\|A08\|B08\|C08\|D08\|E08' $file > sylvaticus/sylvaticus_$name.fa
grep -A1 'D01\|B02\|C02\|D02\|E02\|F02\|G02\|H02\|A03\|B03\|C03\|D03\|E03\|F03\|G03\|H03\|A04\|B04\|C04\|D04\|E04\|F04\|G04\|H04\|A05\|B05\|C05\|D05\|E05\|F05\|G05\|H05\|C06\|D06\|E06\|F06\|G06\|H06\|A07\|B07\|C07\|F08\|G08\|H08\|A09\|B09\|C09\|D09\|E09\|F09\|G09\|H09\|A10\|B10\|C10\|D10\|E10\|F10\|G10\|H10\|A11\|B11\|C11\|D11\|E11\|F11\|G11\|H11\|A12\|B12\|C12\|D12\|E12\|F12\|G12\|H12' $file  > flavicollis/flavicollis_$name.fa
done

#remove empty files
mkdir flavicollis/empty
mkdir sylvaticus/empty
mv $(find flavicollis/ -type f -empty) empty/
 mv $(find sylvaticus/ -type f -empty) empty/

#find common elements

ls| grep -o '[0-9]*'> list_sylvaticus_loci
ls| grep -o '[0-9]*'> list_flavicollis_loci
comm -12 ../sylvaticus/list_sylvaticus_loci ../flavicollis/list_flavicollis_loci > list_common_loci
mkdir flavicollis/common
mkdir sylvaticus/common
sed -e 's/^/mv flavicollis_CLocus_/' -e 's/$/.fa common/' ../flavicollis/list_common_loci > common_loci_to_mv
bash sylvaticus/common_loci_to_mv
bash flavicollis/common_loci_to_mv


#Consensus

cd ../../sylvaticus/common
for file in *_align.fa
name=${file%_align.fa}
do
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out $name_consensus.fa
done


cd ../../flavicollis/common
for file in *_align.fa
name=${file%_align.fa}
do
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out $name_consensus.fa
done
