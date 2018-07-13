#!/bin/bash
#Kommando för att hämta hem kromosom vcf
vcftools --gzvcf /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/FinalSet.recode.vcf.gz --chr 1 --recode --recode-INFO-all --stdout | gzip -c > ~/projekt/chr1.vcf.gz

#Kommando för att te bort duplikat
vcftools --gzvcf ~/projekt/chr1.vcf.gz --remove /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/FinalSetMissingIndv.below95 --remove /home/alma/cbio3/projects/Britt-Marie/WES/results/intermediate/MDS/MDS2/DuplicatesToRemove_uniq.ids --stdout | gzip -c > ~/projekt/chr1a.vcf.gz


nu gör jag dum ändring
