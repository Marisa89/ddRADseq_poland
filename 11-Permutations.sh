#!/bin/bash
#Select 10 random samples from each population. We will do it 100 times per population and we will concatenate the resulting list to make the population map for the denovo_analysis. Due to the lack of a seed the results won't be replicable.
mkdir admixture log pops randomize_ind vcf_files

cd randomize_ind/
read -p "Insert the number of samples that you want to randomly extract:
" z
read -p "Insert full path to the population file from which you want to randomly extract the individuals: 
" a 
read -p "Insert full path to the population file from which you want to randomly extract the individuals: 
" b 
read -p "Insert full path to the population file from which you want to randomly extract the individuals: 
" c
read -p "Insert full path to save the output: 
" y

i=1
for file in {1..100}
do
shuf -n $z $a > $y_$file
shuf -n $z $b >> $y_$file
shuf -n $z $c >> $y_$file
let "i+=1"
done


#prepare vcf 
for file in {1..100}
do
vcftools --vcf /home/marisa/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/hwe_maf_dp.recode.vcf --keep $file --recode --out ../vcf_files/$file
done

mv *.log ../log

#convert to plink 
cd vcf_files/
for file in {1..100}.vcf
do 
name=${file%.vcf}
~/Documents/Software/plink1.90/plink --vcf $file --recode12 --out ~/Documents/Resultados/Apodemus_Poland/random/admixture/$name --allow-extra-chr
done

#run admixture

for file in {1..100}.ped; do name=${file%.ped}; for K in 1 2 3 4 5; do ~/Documents/Software/admixture_linux-1.3.0/admixture --cv $file $K |tee $name.$K.out; done; done

#Check Cv errors
for file in {1..100}.*.out;do  grep -h CV $file.*.out; done

#run populations package for fst and stats
for file in {1..100}; do name=${file%.vcf}; populations -V $name.vcf -M ../randomize_ind/$name -O ../populations_stacks/ --fstats; done

#Extract the values of Ho, He, Pi, Fis, Ind, Npa obtained for each replicate
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f9; done > Ho_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f9; done > Ho_Bory
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f9; done > Ho_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f15; done > He_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f15; done > He_Bory
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f15; done > He_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f21; done > Pi_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f21; done > Pi_Bory
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f21; done > Pi_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f24; done > Fis_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f24; done > Fis_Bory
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f24; done > Fis_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f3; done > Ind_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f3; done > Ind_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f3; done > Ind_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 5|tail -n 1 |cut -f2; done > Npa_Bial
for file in *.sumstats_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f2; done > Npa_Hacki
for file in *.sumstats_summary.tsv; do cat $file|head -n 4|tail -n 1 |cut -f2; done > Npa_Bory

#Extract Fst values

for file in *.fst_summary.tsv; do cat $file|head -n 2|tail -n 1 |cut -f3; done > Fst_Hacki_Bory
for file in *.fst_summary.tsv; do cat $file|head -n 2|tail -n 1 |cut -f4; done > Fst_Hacki_Bial
for file in *.fst_summary.tsv; do cat $file|head -n 3|tail -n 1 |cut -f4; done > Fst_Bory_Bial

#prepare file for trees

#create folder structure
mkdir -p bis/bis_{1..100}

#copy the files to avoid future problems
for file in *.vcf; do  name=${file%.vcf}; cp $file bis/bis_$name.vcf; done


#change un for 1 in the chr slot
for file in bis_*.vcf; do  name=${file%.vcf}; sed -i -e 's/un/1/g' $file; done

#run SNPhylo for each permutation.
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_1/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_1.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_2/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_2.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_3/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_3.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_4/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_4.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_5/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_5.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_6/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_6.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_7/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_7.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_8/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_8.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_9/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_9.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_10/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_10.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_11/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_11.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_12/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_12.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_13/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_13.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_14/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_14.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_15/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_15.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_16/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_16.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_17/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_17.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_18/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_18.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_19/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_19.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_20/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_20.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_21/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_21.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_22/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_22.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_23/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_23.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_24/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_24.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_25/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_25.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_26/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_26.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_27/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_27.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_28/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_28.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_29/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_29.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_30/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_30.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_31/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_31.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_32/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_32.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_33/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_33.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_34/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_34.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_35/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_35.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_36/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_36.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_37/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_37.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_38/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_38.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_39/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_39.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_40/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_40.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_41/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_41.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_42/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_42.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_43/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_43.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_44/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_44.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_45/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_45.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_46/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_46.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_47/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_47.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_48/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_48.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_49/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_49.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_50/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_50.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_51/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_51.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_52/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_52.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_53/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_53.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_54/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_54.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_55/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_55.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_56/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_56.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_57/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_57.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_58/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_58.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_59/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_59.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_60/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_60.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_61/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_61.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_62/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_62.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_63/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_63.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_64/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_64.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_65/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_65.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_66/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_66.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_67/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_67.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_68/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_68.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_69/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_69.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_70/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_70.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_71/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_71.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_72/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_72.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_73/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_73.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_74/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_74.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_75/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_75.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_76/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_76.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_77/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_77.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_78/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_78.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_79/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_79.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_80/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_80.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_81/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_81.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_82/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_82.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_83/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_83.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_84/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_84.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_85/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_85.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_86/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_86.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_87/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_87.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_88/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_88.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_89/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_89.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_90/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_90.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_91/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_91.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_92/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_92.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_93/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_93.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_94/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_94.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_95/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_95.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_96/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_96.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_97/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_97.vcf -r -l 1 -m 0 -M 1 -b 100
cd /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_98/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_98.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_99/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_99.vcf -r -l 1 -m 0 -M 1 -b 100
cd  /home/marisa/Documents/Resultados/Apodemus_Poland/random/vcf_files/bis/bis_100/
~/Documents/Software/SNPhylo/snphylo.sh -v ../bis_100.vcf -r -l 1 -m 0 -M 1 -b 100
