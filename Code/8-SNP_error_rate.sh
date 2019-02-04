#!/bin/bash/
# Create vcf file in each one of the duplciates samples by separatE. This could have been done easier using --keep instead of remove
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeF06 --recode --out F06
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeB02 --recode --out B02
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeA12 --recode --out A12
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeF12 --recode --out F12
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeH11 --recode --out H11
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeG06 --recode --out G06
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeG02 --recode --out G02
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeD01 --recode --out D01

#Create vcf with the pairs of duplicates
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeF06_b02 --recode --out F06_B02
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeA12_F12 --recode --out A12_F12
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeH11_G06 --recode --out H11_G06
vcftools --vcf ../batch_124.vcf_lowind_maf_hwe_DP.recode.vcf --remove list_to_removeG02_D01 --recode --out G02_D01

#GZ VCF FILES
bgzip -c F06.recode.vcf > F06.vcf.gz
bgzip -c B02.recode.vcf > B02.vcf.gz
bgzip -c A12.recode.vcf > A12.vcf.gz
bgzip -c F12.recode.vcf > F12.vcf.gz
bgzip -c H11.recode.vcf > H11.vcf.gz
bgzip -c G06.recode.vcf > G06.vcf.gz
bgzip -c G02.recode.vcf > G02.vcf.gz
bgzip -c D01.recode.vcf > D01.vcf.gz

#GET TABIX
tabix -p vcf F06.vcf.gz 
tabix -p vcf B02.vcf.gz
tabix -p vcf A12.vcf.gz 
tabix -p vcf F12.vcf.gz 
tabix -p vcf H11.vcf.gz 
tabix -p vcf G06.vcf.gz 
tabix -p vcf G02.vcf.gz 
tabix -p vcf D01.vcf.gz 


#VCF-COMPARE
vcf-compare -g F06.vcf.gz B02.vcf.gz -m F06:B02 > F06_B02.RESULTS
vcf-compare -g A12.vcf.gz F12.vcf.gz -m A12:F12 > A12_F12.RESULTS
vcf-compare -g H11.vcf.gz G06.vcf.gz -m H11:G06 > H11_G06.RESULTS
vcf-compare -g G02.vcf.gz D01.vcf.gz -m G02:D01 > G02_D01.RESULTS

#Get the number of snps with missing data common to both duplicates
vcftools --gzvcf B02_F06.vcf.gz --max-missing 1 
vcftools --gzvcf A12_F12.recode.vcf --max-missing 1
vcftools --vcf H11_G06.recode.vcf --max-missing 1
vcftools --vcf G02_D01.recode.vcf --max-missing 1

#Get the number of snps with missing data that are not shared between samples
vcftools --gzvcf B02_F06.vcf.gz --max-missing 0.5 
vcftools --vcf A12_F12.recode.vcf --max-missing 0.5
vcftools --vcf H11_G06.recode.vcf --max-missing 0.5
vcftools --vcf G02_D01.recode.vcf --max-missing 0.5

