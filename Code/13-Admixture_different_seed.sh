#!/bin/bash/
#Convert vcf to ped12 with plink version 1.9
plink --vcf hwe_maf_dp.recode.vcf --recode 12 --out plink --allow-extra-chr


#1st run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture1/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 43 $K | tee log${K}.out
done

#2nd run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture2/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 22 $K | tee log${K}.out
done

#3th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture3/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 333 $K | tee log${K}.out
done

#4th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture4/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 4444 $K | tee log${K}.out
done

#5th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture5/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 55555 $K | tee log${K}.out
done

#6th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture6/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 666666 $K | tee log${K}.out
done

#7th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture7/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 7777777 $K | tee log${K}.out
done

#8th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture8/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 88888888 $K | tee log${K}.out
done

#9th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture9/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 999999999 $K | tee log${K}.out
done

#10th run
cd ~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/admixture10/
for K in 1 2 3 4 5;
do 
admixture --cv ../plink.ped -s 1010 $K | tee log${K}.out
done