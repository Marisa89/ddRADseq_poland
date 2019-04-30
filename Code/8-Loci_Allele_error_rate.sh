#!bin/bash
#Move into the directory containing the Loci data
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/
mkdir -p Duplicates/{A12,F12,B02,F06,H11,G06,G02,D01}
#Copy CLocus from Apodemus flavicollis
cp /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/flavicollus_CLocus_*  /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicates/
cp /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/common/flavicollis_CLocus_*  /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicates/

#Create directories structure
mkdir -p A12/{empty,common/Consensus}
mkdir -p F12/{empty,common/Consensus}
mkdir -p B02/{empty,common/Consensus}
mkdir -p F06/{empty,common/Consensus}
mkdir -p H11/{empty,common/Consensus}
mkdir -p G06/{empty,common/Consensus}
mkdir -p G02/{empty,common/Consensus}
mkdir -p D01/{empty,common/Consensus}

#Separate sequences by Duplicate samples
for file in *.fa
do
name=${file%.fa}
grep -A1 'A12' $file > A12/$name.fa
grep -A1 'F12' $file > F12/$name.fa
grep -A1 'B02' $file > B02/$name.fa
grep -A1 'F06' $file > F06/$name.fa
grep -A1 'H11' $file > H01/$name.fa
grep -A1 'G06' $file > G06/$name.fa
grep -A1 'G02' $file > G02/$name.fa
grep -A1 'D01' $file > D01/$name.fa
done


#move empty files into a new folder
find A12/ -empty -type f > A12_empty
cat A12_empty |while read foo; do mv "$foo" A12/empty/; done
find F12/ -empty -type f > F12_empty
cat F12_empty |while read foo; do mv "$foo" F12/empty/; done
find B02/ -empty -type f > B02_empty
cat B02_empty |while read foo; do mv "$foo" B02/empty/; done
find F06/ -empty -type f > F06_empty
cat F06_empty |while read foo; do mv "$foo" F06/empty/; done
find H11/ -empty -type f > H11_empty
cat H11_empty |while read foo; do mv "$foo" H11/empty/; done
find G06/ -empty -type f > G06_empty
cat G06_empty |while read foo; do mv "$foo" G06/empty/; done
find G02/ -empty -type f > G02_empty
cat G02_empty |while read foo; do mv "$foo" G02/empty/; done
find D01/ -empty -type f > D01_empty
cat D01_empty |while read foo; do mv "$foo" D01/empty/; done


#Create a list of loci for each Duplicate sample
ls A12|grep -o '[0-9]*'|sort> list_loci_A12
ls F12|grep -o '[0-9]*'|sort> list_loci_F12
ls B02|grep -o '[0-9]*'|sort> list_loci_B02
ls F06|grep -o '[0-9]*'|sort> list_loci_F06
ls H11|grep -o '[0-9]*'|sort> list_loci_H11
ls G06|grep -o '[0-9]*'|sort> list_loci_G06
ls G02|grep -o '[0-9]*'|sort> list_loci_G02
ls D01|grep -o '[0-9]*'|sort> list_loci_D01

#find common elements
comm -12 list_loci_A12 list_loci_F12 >common_loci_A12_F12
comm -12 list_loci_B02 list_loci_F06 >common_loci_B02_F06
comm -12 list_loci_H11 list_loci_G06 >common_loci_H11_G06
comm -12 list_loci_G02 list_loci_D01 >common_loci_G02_D01

#Create a script to move all common loci into the common folder
sed -e 's/^/mv flavicollis_CLocus_/' -e 's/$/.fa common/' common_loci_A12_F12 > common_loci_to_mv_A12_F12
sed -e 's/^/mv flavicollis_CLocus_/' -e 's/$/.fa common/' common_loci_B02_F06 > common_loci_to_mv_B02_F06
sed -e 's/^/mv flavicollis_CLocus_/' -e 's/$/.fa common/' common_loci_H11_G06 > common_loci_to_mv_H11_G06
sed -e 's/^/mv flavicollis_CLocus_/' -e 's/$/.fa common/' common_loci_G02_D01 > common_loci_to_mv_G02_D01

#Move all common loci into the common folder
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/A12
bash ../common_loci_to_mv_A12_F12
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F12
bash ../common_loci_to_mv_A12_F12
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/B02
bash ../common_loci_to_mv_B02_F06
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F06
bash ../common_loci_to_mv_B02_F06
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/H11
bash ../common_loci_to_mv_H11_G06
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G06
bash ../common_loci_to_mv_H11_G06
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G02
bash ../common_loci_to_mv_G02_D01
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/D01
bash ../common_loci_to_mv_G02_D01


#Count common loci to both Duplicates
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/A12/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F12/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/B02/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F06/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/H11/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G06/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G02/common/flavicollis_CLocus*|wc -l
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/D01/common/flavicollis_CLocus*|wc -l

#Count non common loci to both Duplicates
ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/A12/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F12/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/B02/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F06/lavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/H11/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G06/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G02/flavicollis_CLocus*|wc -l

ls /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/D01/flavicollis_CLocus*|wc -l

#Those values will allow us to calculate the Locus error rate. From now on we will preparing the files needed for Allele error rate calculation
#Create consensus sequences
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/A12/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F12/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/B02/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F06/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/H11/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G06/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G02/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/D01/common/
for file in *.fa
do
name=${file%.fa}
perl ~/Documents/Software/Sequence-manipulation/Consensus.pl -in $file -out Consensus/$name_consensus.fa
done


#make files have a different name as well as the sequences inside, as it is needed for the R Script
cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/A12/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/A12_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\A12_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F12/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/F12_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\F12_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/B02/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/B02_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\B02_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/F06/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/F06_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\F06_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/H11/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/H11_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\H11_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G06/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/G06_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\G06_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/G02/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/G02_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\G02_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *

cd /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus/flavicollis/Duplicados/D01/common/Consensus/
mkdir mod
for file in *.fa; do sed -e 's/flavicollis/D01_flavicollis/' $file > mod/mod_$file; done
cd mod/
rename 's/\mod/\D01_mod_/' mod_consensus_flavicollis_CLocus_*
rename 's/ //g' *
