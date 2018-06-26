#!/bin/bash
#Kommando för att hämta hem kromosom vcf och ta bort duplikat
vcftools --gzvcf /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/FinalSet.recode.vcf.gz --chr 1 --remove /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/FinalSetMissingIndv.below95 --remove /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/MDS/MDS2/DuplicatesToRemove_uniq.ids --recode --recode-INFO-all --stdout | gzip -c > ~/projekt/chr1.vcf.gz

#Filtrera
vcftools --gzvcf ~/projekt/chr1.vcf.gz --minGQ 20 --minDP 8 --recode --recode-INFO-all --stdout | gzip -c > ~/projekt/chr1a.vcf.gz

vcftools --gzvcf ~/projekt/chr1a.vcf.gz --max-missing 0.9 --recode --recode-INFO-all --stdout | gzip -c > ~/projekt/chr1b.vcf.gz

#Ta bort sites utan PASS på filter
vcftools --gzvcf ~/projekt/chr1b.vcf.gz --remove-filtered-all --recode --recode-INFO-all --stdout | gzip -c > ~/projekt/chr1c.vcf.gz

#Ta bort negativa training sites
#vcftools --gzvcf ~/projekt/chr1c.vcf.gz --remove-INFO NEGATIVE_TRAIN_SITE --recode --recode-INFO-all --stdout | gzip -c >  ~/projekt/chr1d.vcf.gz

#Skapa .ped/.fam/.bim (plink.filer) OBS ej .gzippad fil 
plink --vcf chr1d.vcf.gz --double-id --set-missing-var-ids @:#[hg19]\$1,\$2 --make-bed --out chr1
