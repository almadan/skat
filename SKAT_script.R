#Ladda paketet
library(SKAT)
Generate_SSD_SetID(File.Bed = "~/projekt/chr1.bed", File.Bim = "~/projekt/chr1.bim", File.Fam = "~/projekt/chr1.fam", File.SetID = "~/projekt/chr_1_setID.txt", File.SSD = "~/projekt/chr1.SSD", File.Info = "~/projekt/chr1.Info")

#Läs .fam fil
FAM<-Read_Plink_FAM("~/projekt/chr1.fam", Is.binary=FALSE)

#Hitta case
caseNames <- read.csv("~/cbio3/projects/Britt-Marie/WES/data/lundMMcasesN_29.txt",stringsAsFactors = FALSE, header = FALSE)
#Skriv det här för att se vilka rader som innehåller casen
FAM[which(FAM$IID %in% caseNames$V1),]

#Öppna SSD fil
SSD.INFO<-Open_SSD("~/projekt/chr1.SSD", "~/projekt/chr1.Info")

#Sätt alla phenotyper till 0
FAM$Phenotype[] <- 0
#Sätt casen till 1
FAM$Phenotype[3307:3329] <- 1

#Spara phenotyper i variabel y
y<-FAM$Phenotype
#Fitta en model till y~1
obj<-SKAT_Null_Model(y ~ 1, out_type = "C")
#Samla in resultaten
out<-SKAT.SSD.All(SSD.INFO, obj)
#Visa resultat
#out

#out$results
out$results[out$results$P.value < 0.00000005,]

