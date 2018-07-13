#!/usr/bin/env python3
#Script för att skapa setID fil till Almas projekt
import pandas as pd
import numpy as np
import sys

resultList=[]
lookupList=[]
#Loopa över kromosom 1..22
for chr in np.arange(1,12,1):
    #Öppna fil med gen namn och positionsinfo
    str_GENE_POS="/home/alma/projekt/"+str(chr)+"_SetID.txt"
    GENE_POS_DF=pd.read_csv(str_GENE_POS, delimiter=' ',header=None)
    
    #Öppna fil med snp-ID och positionsinfo
    str_ID_POS_DF="/home/alma/projekt/chr"+str(chr)+".bim"
    ID_POS_DF=pd.read_csv(str_ID_POS_DF, delimiter='\t',header=None)
    
    #Loopa över snp-ID filen
    for index, row in ID_POS_DF.iterrows():
        snp_ID=str(row[1])
        snp_POS=int(row[3])
        #För varje snp, leta i gen-namn och positionsfilen
        for i,r in GENE_POS_DF.iterrows():
            gene_START=int(r[1])
            gene_END=int(r[2])
            gene_NAME=str(r[3])
            #Om snp position ligger mellan gene start och gene end är det en match
            if snp_POS > gene_START and snp_POS < gene_END:
                #Isåfall; bygg en resultattext som
                #"Gen-namn <tab> snp ID"   
                resultStr=gene_NAME+"\t"+snp_ID
                #spara det i en list
                resultList.append(resultStr)
                #Spara lite extra information i en annan lista
                #För att kunna dubbelkolla saker
                #extraResultStr=gene_NAME+"\t"+str(gene_START)+"\t"+str(gene_END)+"\t"+snp_ID+"\t"+str(snp_POS)
                #lookupList.append(extraResultStr)
                print(resultStr, flush=True)
                continue

#Obs, istället för nedan lösning pipeade jag resultatet till fil istället, såhär:
#./create_setID.py > alma_setID.txt

##När allt är färdigt, skriv ut listan till en fil
#resultFile=open("manual_setID.txt","w")
#for elem in resultList:
#    resultFile.write(elem)
#resultFile.close()
#
#resultFile2=open("lookupList.txt","w")
#for elem in lookupList:
#    resultFile2.write(elem)
