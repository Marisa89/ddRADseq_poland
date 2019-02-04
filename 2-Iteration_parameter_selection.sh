#!bin/bash
#This script will run process_radtags from stacks 
echo "This script starts with your Raw data. It will demultiplex the reads between individuals and will run a exploratory analysis to find the best parameters to your dataset, base on Paris 2017 paper Lost in parameters space"
read -p "Insert full path to pop map:" m
read -p "Insert number of threads:" q
read -p "Insert number for the batch:" r


#Here we will create the folder structure needed to reproduce J.Paris(2017) analysis

mkdir -p Parameters/{m/{2,3,4,5,6,7},Mi/{0,1,2,3,4,5,6,7,8},n/{0,1,2,3,4,5,6,7,8,9}}


# And now we will start running denovo_map changing only one parameter at a time. The default parameters will be m=3, M=2 and n=0


# For m
for i in {2..7}
	do
	denovo_map.pl --samples ./ -b $r -o Parameters/m/$i/ -O $m -T $q -m $i -M 2 -n 1 -t -S
done

# For M
for j in {0..8}
	do
	denovo_map.pl --samples ./ -b $r -o Parameters/Mi/$j/ -O $m -T $q -m 3 -M $j -n 1 -t -S
done


# For n
for k in {0..9}
	do
	denovo_map.pl --samples ./ -b $r -o Parameters/n/$k/ -O $m -T $q -m 3 -M 2 -n $k -t -S
done


read -p "Insert full path to Parameter/m/ folder:" a
read -p "Insert full path to Parameter/Mi/ folder:" b
read -p "Insert full path to Parameter/n/ folder:" c
read -p "Insert number of individuals included on the analysis:" d

#create a list with the name of all the individuals.
for file in *.fq.gz
do
name=${file%.fq.gz}
echo $name >> names.txt
done


#for m
cd $a
for i in {2..7}
do 
	cd $i
	for file in $(cat ../../../names.txt)
		echo "Individual $file"
		echo "assembled_loci"
		zcat $file.tags.tsv.gz|grep model|wc -l
		echo "polymorphic_loci"
		zcat $file.tags.tsv.gz |grep model|grep E| wc -l
		echo "SNPs"
		zcat $file.snps.tsv.gz|grep E| wc -l		
	done >>metrics_stacks_m_$i.txt
pwd
cd ../
done

#for M
cd $b
for j in {0..8}
do
     cd $j
	for file in $(cat ../../../names.txt)
		do 
		echo "Individual $file"
		echo "assembled_loci"
		zcat $file.tags.tsv.gz|grep model|wc -l
		echo "polymorphic_loci"
		zcat $file.tags.tsv.gz |grep model|grep E| wc -l
		echo "SNPs"
		zcat $file.snps.tsv.gz|grep E| wc -l		
	done >>metrics_stacks_Mi_$j.txt
pwd 
cd ../	
done

#for n
cd $c
for k in {1..9}
do
     cd $k
	for file in $(cat ../../../names.txt)
		do 
		echo "Individual $file"
		echo "assembled_loci"
		zcat $file.tags.tsv.gz|grep model|wc -l
		echo "polymorphic_loci"
		zcat $file.tags.tsv.gz |grep model|grep E| wc -l
		echo "SNPs"
		zcat $file.snps.tsv.gz|grep E| wc -l		
	done >>metrics_stacks_n_$k.txt
	pwd
	cd ../
done

# For m
cd $a
for i in {2..7}
do
	cd $i
	for file in metrics_stacks_m_$i.txt
		do
	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -Eo '[0-9]+' > results_analysis_filtered_m_$i

	#Afterwards, we can observed a four line patterns (samples id number, assebled loci, polymorphic loci and snps).
	#Using awk we can #extract the second line every four lines (assembled), the third line every four lines (snps) or the 	the #		fourth line every four lines (polymorphic loci)
		cat results_analysis_filtered_m_$i|awk '(NR%4==2)' > assembled_loci_m_$i.txt
		cat results_analysis_filtered_m_$i|awk '(NR%4==3)' > polymorphic_loci_m_$i.txt
		cat results_analysis_filtered_m_$i|awk '(NR%4==0)' > snps_m_$i.txt
		yes "m"|head -n $d > parameter.txt
		yes ""$i""|head -n $d > value_parameter.txt
	#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste parameter.txt value_parameter.txt assembled_loci_m_$i.txt polymorphic_loci_m_$i.txt snps_m_$i.txt >results_m_$i
		cat results_m_$i >>../resultados_m
		done
		pwd
		cd ../
done

#For M
cd $b
for j in {0..8}
do
	cd $j
	for file in metrics_stacks_Mi_$j.txt
		do
	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -Eo '[0-9]+' > results_analysis_filtered_Mi_$j

	#Afterwards, we can observed a four line patterns (samples id number, assebled loci, polymorphic loci and snps).
	#Using awk we can #extract the second line every four lines (assembled), the third line every four lines (snps) or the 	the #		fourth line every four lines (polymorphic loci)
		cat results_analysis_filtered_Mi_$j|awk '(NR%4==2)' > assembled_loci_Mi_$j.txt
		cat results_analysis_filtered_Mi_$j|awk '(NR%4==3)' > polymorphic_loci_Mi_$j.txt
		cat results_analysis_filtered_Mi_$j|awk '(NR%4==0)' > snps_Mi_$j.txt
		yes "Mi"|head -n $d > parameter.txt
		yes ""$j""|head -n $d> value_parameter.txt
	#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste parameter.txt value_parameter.txt assembled_loci_Mi_$j.txt polymorphic_loci_Mi_$j.txt snps_Mi_$j.txt >results_Mi_$j
		cat results_Mi_$j >>../resultados_Mi
		done
		pwd
		cd ../
done

# For n
cd $c
for k in {1..9}
do
	cd $k
	for file in metrics_stacks_n_$k.txt
		do
	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -Eo '[0-9]+' > results_analysis_filtered_n_$k

	#Afterwards, we can observed a four line patterns (samples id number, assebled loci, polymorphic loci and snps).
	#Using awk we can #extract the second line every four lines (assembled), the third line every four lines (snps) or the 	#	the fourth line every four lines (polymorphic loci)
		cat results_analysis_filtered_n_$k|awk '(NR%4==2)' > assembled_loci_n_$k.txt
		cat results_analysis_filtered_n_$k|awk '(NR%4==3)' > polymorphic_loci_n_$k.txt
		cat results_analysis_filtered_n_$k|awk '(NR%4==0)' > snps_n_$k.txt
		yes "n"|head -n $d > parameter.txt
		yes $k|head -n $d> value_parameter.txt
	#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste parameter.txt value_parameter.txt assembled_loci_n_$k.txt polymorphic_loci_n_$k.txt snps_n_$k.txt >results_n_$k
		done
		cat results_n_$k >>../resultados_n
		pwd
		cd ../
done



#Now we are running the population package from stacks v1.48

#For m
cd $a
for i in {2..7}
	do
	cd $i
	mkdir {p8/,p6/,p4/}
	populations -P ./ -b $r -M  $m -O p4/ -t $q -p 2 -r 0.40 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p6/ -t $q -p 2 -r 0.60 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p8/ -t $q -p 2 -r 0.80 --vcf --vcf_haplotypes --plink
	pwd
	cd ..
done


#for M
cd $b
for j in {0..8}
	do
	cd $j
	mkdir {p8/,p6/,p4/}
	populations -P ./ -b $r -M  $m -O p4/ -t $q -p 2 -r 0.40 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p6/ -t $q -p 2 -r 0.60 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p8/ -t $q -p 2 -r 0.80 --vcf --vcf_haplotypes --plink
	pwd
	cd ..
	done
	
#For n
cd $c
for k in {0..9}
	do
	cd $k
	mkdir {p8/,p6/,p4/}
	populations -P ./ -b $r -M  $m -O p4/ -t $q -p 2 -r 0.40 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p6/ -t $q -p 2 -r 0.60 --vcf --vcf_haplotypes --plink
	populations -P ./ -b $r -M  $m -O p8/ -t $q -p 2 -r 0.80 --vcf --vcf_haplotypes --plink
	pwd
	cd ..
	done

#For m
cd $a
for i in {2..7}
	do
	cd $i
		for l in ./{p4,p6/,p8/}
	do
	cd $l
	echo $i $l
	echo assembled loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |wc -l
	echo polymorphic loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |grep -v consensus|wc -l
	echo snps
	grep -v "^#" batch_*.vcf |wc -l
	cd ..
	done
	cd ..
done >>results_populations_m

#For M
cd /$b
for j in {0..8}
	do
	cd $j
		for m in ./{p4,p6/,p8/}
	do
	cd $m
	echo $j $m
	echo assembled loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |wc -l
	echo polymorphic loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |grep -v consensus|wc -l
	echo snps
	grep -v "^#" batch_*.vcf |wc -l
	cd ..
	done
	cd ..
done >>results_populations_Mi

#For n
cd $n
for k in {1..9}
	do
	cd $k
		for n in ./{p4,p6/,p8/}
	do
	cd $n
	echo $k $n
	echo assembled loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |wc -l
	echo polymorphic loci
	awk '{if(NR>1)print}' batch_*.haplotypes.tsv |grep -v consensus|wc -l	
	echo snps
	grep -v "^#" batch_*.vcf |wc -l
	cd ..
	done
	cd ..
done >>results_populations_n

#For m
cd $a
	for file in results_populations_m
		do
#	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -v /home/| grep -Eo '[0-9]+' > results_analysis_filtered_populations_m

#	#Afterwards, we can observed a five line patterns (parameter, populations r value, assebled loci, polymorphic loci and snps).
#	#Using awk we can extract them
		cat results_analysis_filtered_populations_m|awk '(NR%5==1)' > parameter.txt
		cat results_analysis_filtered_populations_m|awk '(NR%5==2)' > rvalue.txt
		cat results_analysis_filtered_populations_m|awk '(NR%5==3)' > assembled_loci.txt
		cat results_analysis_filtered_populations_m|awk '(NR%5==4)' > polymorphic_loci.txt
		cat results_analysis_filtered_populations_m|awk '(NR%5==0)' > snps.txt
		yes m |head -21 > para.txt
	#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste para.txt parameter.txt rvalue.txt assembled_loci.txt polymorphic_loci.txt snps.txt >results_pop_filtered_m
		done


#For M
cd $b
	for file in results_populations_Mi
		do
#	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -v /home/| grep -Eo '[0-9]+' > results_analysis_filtered_populations_Mi
#	#Afterwards, we can observed a five line patterns (parameter, populations r value, assebled loci, polymorphic loci and snps).
#	#Using awk we can extract them
		cat results_analysis_filtered_populations_Mi|awk '(NR%5==1)' > parameter.txt
		cat results_analysis_filtered_populations_Mi|awk '(NR%5==2)' > rvalue.txt
		cat results_analysis_filtered_populations_Mi|awk '(NR%5==3)' > assembled_loci.txt
		cat results_analysis_filtered_populations_Mi|awk '(NR%5==4)' > polymorphic_loci.txt
		cat results_analysis_filtered_populations_Mi|awk '(NR%5==0)' > snps.txt
		yes Mi |head -27 > para.txt
	#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste para.txt parameter.txt rvalue.txt assembled_loci.txt polymorphic_loci.txt snps.txt >results_pop_filtered_Mi
		done


#For n
cd $c
	for file in results_populations_n
		do
	#First we can extract only the numbers that appeared in the results file.
		cat $file | grep -v /home/| grep -Eo '[0-9]+' > results_analysis_filtered_populations_n

	#Afterwards, we can observed a five line patterns (parameter, populations r value, assebled loci, polymorphic loci and snps).
	#Using awk we can extract them
		cat results_analysis_filtered_populations_n|awk '(NR%5==1)' > parameter.txt
		cat results_analysis_filtered_populations_n|awk '(NR%5==2)' > rvalue.txt
		cat results_analysis_filtered_populations_n|awk '(NR%5==3)' > assembled_loci.txt
		cat results_analysis_filtered_populations_n|awk '(NR%5==4)' > polymorphic_loci.txt
		cat results_analysis_filtered_populations_n|awk '(NR%5==0)' > snps.txt
		yes n |head -33 > para.txt

#Then we can paste the results to concatenate the thee files, adding each new file to a different column
		paste para.txt parameter.txt rvalue.txt assembled_loci.txt polymorphic_loci.txt snps.txt >results_pop_filtered_n
		done


#Here we extract the initial and final coverage fir each value of m

cd $a
for i in {2..7}
do
	cd $i
		pwd
		cat denovo_map.log |grep "Initial coverage mean" >Initial_coverage_$i 
		cat denovo_map.log |grep "After merging, coverage depth Mean" >Final_coverage_$i
		yes "m"|head -n "$d" > parameter.txt
		yes ""$i""|head -n "$d" > value_parameter.txt
		paste parameter.txt value_parameter.txt Initial_coverage_$i >> ../coverage_initial_m
		paste parameter.txt value_parameter.txt Final_coverage_$i >> ../coverage_final_m
		pwd
		cd ../	
done


#run analysis with the selected parameters

echo "This script starts with your Raw data. It will demultiplex the reads between individuals and will run a exploratory analysis to find the best parameters to your dataset, base on Paris 2017 paper Lost in parameters space"
read -p "Insert full path to pop map:" m
read -p "Insert number of threads:" q
read -p "Insert number for the batch:" r
read -p "Insert full path to the desired output folder:" a
read -p "Insert value of m:" z
read -p "Insert value of M:" x
read -p "Insert value of n:" y

	denovo_map.pl --samples ./ -b $r -o $a -O $m -T $q -m $z -M $x -n $y -t -S
	populations -P ./ -b $r -M  $m -O $a -t $q -p 1 -r 0.5 --vcf --fstats --plink
