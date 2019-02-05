# Calculating mean sequence divergence based on a single fasta file

library(ape)
library(plyr)
library(seqinr)
setwd("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus")


#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/Duplicados/A12/common/Consensus/mod/")
sylva <- list.files("flavicollis/Duplicados/F12/common/Consensus/mod/")

Compare_bb_bs_old={}
for (i in 1:32416)
{
  ffile <- read.fasta(paste0("flavicollis/Duplicados/A12/common/Consensus/mod/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("flavicollis/Duplicados/F12/common/Consensus/mod/",sylva[i]), set.attributes = FALSE)
  
  Names_f<-names(ffile)
  Names_s<-names(sfile)
  fs_divergence<-c(sfile, ffile)
  Names_fs <- names(fs_divergence)
  for (j in 1:length(ffile)){
    for (k in (length(ffile) +1):length(fs_divergence)){
      Compare_bb_bs_old[i] <-sum(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))) != eval(parse(text=paste0("fs_divergence$", Names_fs[k]))))/length(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))))*100
      
    }
  }
}

Compare_bb_bs_old

#calculate statistics
min(Compare_bb_bs_old)
max(Compare_bb_bs_old)
mean(Compare_bb_bs_old)
median(Compare_bb_bs_old)
sd(Compare_bb_bs_old)

#Link the loci name with the divergence values
df_locus_divergence <- melt(data.frame(flavi,Compare_bb_bs_old))
df_locus_divergence

#Identify loci with 0 differences
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])
#Identify loci with 1 differences
df_locus_divergence[df_locus_divergence$value <1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
#Identify loci with 2 differences
df_locus_divergence[df_locus_divergence$value <2,]
length(df_locus_divergence$value[df_locus_divergence$value <2])
#Identify loci with 3 differences
df_locus_divergence[df_locus_divergence$value <2.5,]
length(df_locus_divergence$value[df_locus_divergence$value <2.5])
#Identify loci with 4 differences
df_locus_divergence[df_locus_divergence$value <3,]
length(df_locus_divergence$value[df_locus_divergence$value <3])
#Identify loci with 5 differences
df_locus_divergence[df_locus_divergence$value <4,]
length(df_locus_divergence$value[df_locus_divergence$value <4])
#Identify loci with 6 differences
df_locus_divergence[df_locus_divergence$value <5,]
length(df_locus_divergence$value[df_locus_divergence$value <5])
#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/Duplicados/G02/common/Consensus/mod/")
sylva <- list.files("flavicollis/Duplicados/D01/common/Consensus/mod/")

Compare_bb_bs_old={}
for (i in 1:34189)
{
  ffile <- read.fasta(paste0("flavicollis/Duplicados/G02/common/Consensus/mod/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("flavicollis/Duplicados/D01/common/Consensus/mod/",sylva[i]), set.attributes = FALSE)
  
  Names_f<-names(ffile)
  Names_s<-names(sfile)
  fs_divergence<-c(sfile, ffile)
  Names_fs <- names(fs_divergence)
  for (j in 1:length(ffile)){
    for (k in (length(ffile) +1):length(fs_divergence)){
      Compare_bb_bs_old[i] <-sum(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))) != eval(parse(text=paste0("fs_divergence$", Names_fs[k]))))/length(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))))*100
      
    }
  }
}

Compare_bb_bs_old

#calculate statistics
min(Compare_bb_bs_old)
max(Compare_bb_bs_old)
mean(Compare_bb_bs_old)
median(Compare_bb_bs_old)
sd(Compare_bb_bs_old)

#Link the loci name with the divergence values
df_locus_divergence <- melt(data.frame(flavi,Compare_bb_bs_old))
df_locus_divergence

#Identify loci with 0 differences
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])
#Identify loci with 1 differences
df_locus_divergence[df_locus_divergence$value <1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
#Identify loci with 2 differences
df_locus_divergence[df_locus_divergence$value <2,]
length(df_locus_divergence$value[df_locus_divergence$value <2])
#Identify loci with 3 differences
df_locus_divergence[df_locus_divergence$value <2.5,]
length(df_locus_divergence$value[df_locus_divergence$value <2.5])
#Identify loci with 4 differences
df_locus_divergence[df_locus_divergence$value <3,]
length(df_locus_divergence$value[df_locus_divergence$value <3])
#Identify loci with 5 differences
df_locus_divergence[df_locus_divergence$value <4,]
length(df_locus_divergence$value[df_locus_divergence$value <4])
#Identify loci with 6 differences
df_locus_divergence[df_locus_divergence$value <5,]
length(df_locus_divergence$value[df_locus_divergence$value <5])

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/Duplicados/F06/common/Consensus/mod/")
sylva <- list.files("flavicollis/Duplicados/B02/common/Consensus/mod/")

Compare_bb_bs_old={}
for (i in 1:31747)
{
  ffile <- read.fasta(paste0("flavicollis/Duplicados/F06/common/Consensus/mod/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("flavicollis/Duplicados/B02/common/Consensus/mod/",sylva[i]), set.attributes = FALSE)
  
  Names_f<-names(ffile)
  Names_s<-names(sfile)
  fs_divergence<-c(sfile, ffile)
  Names_fs <- names(fs_divergence)
  for (j in 1:length(ffile)){
    for (k in (length(ffile) +1):length(fs_divergence)){
      Compare_bb_bs_old[i] <-sum(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))) != eval(parse(text=paste0("fs_divergence$", Names_fs[k]))))/length(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))))*100
      
    }
  }
}

Compare_bb_bs_old

#calculate statistics
min(Compare_bb_bs_old)
max(Compare_bb_bs_old)
mean(Compare_bb_bs_old)
median(Compare_bb_bs_old)
sd(Compare_bb_bs_old)

#Link the loci name with the divergence values
df_locus_divergence <- melt(data.frame(flavi,Compare_bb_bs_old))
df_locus_divergence

#Identify loci with 0 differences
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])
#Identify loci with 1 differences
df_locus_divergence[df_locus_divergence$value <1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
#Identify loci with 2 differences
df_locus_divergence[df_locus_divergence$value <2,]
length(df_locus_divergence$value[df_locus_divergence$value <2])
#Identify loci with 3 differences
df_locus_divergence[df_locus_divergence$value <2.5,]
length(df_locus_divergence$value[df_locus_divergence$value <2.5])
#Identify loci with 4 differences
df_locus_divergence[df_locus_divergence$value <3,]
length(df_locus_divergence$value[df_locus_divergence$value <3])
#Identify loci with 5 differences
df_locus_divergence[df_locus_divergence$value <4,]
length(df_locus_divergence$value[df_locus_divergence$value <4])
#Identify loci with 6 differences
df_locus_divergence[df_locus_divergence$value <5,]
length(df_locus_divergence$value[df_locus_divergence$value <5])

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/Duplicados/G02/common/Consensus/mod/")
sylva <- list.files("flavicollis/Duplicados/D01/common/Consensus/mod/")

Compare_bb_bs_old={}
for (i in 1:34189)
{
  ffile <- read.fasta(paste0("flavicollis/Duplicados/G02/common/Consensus/mod/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("flavicollis/Duplicados/D01/common/Consensus/mod/",sylva[i]), set.attributes = FALSE)
  
  Names_f<-names(ffile)
  Names_s<-names(sfile)
  fs_divergence<-c(sfile, ffile)
  Names_fs <- names(fs_divergence)
  for (j in 1:length(ffile)){
    for (k in (length(ffile) +1):length(fs_divergence)){
      Compare_bb_bs_old[i] <-sum(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))) != eval(parse(text=paste0("fs_divergence$", Names_fs[k]))))/length(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))))*100
      
    }
  }
}

Compare_bb_bs_old

#calculate statistics
min(Compare_bb_bs_old)
max(Compare_bb_bs_old)
mean(Compare_bb_bs_old)
median(Compare_bb_bs_old)
sd(Compare_bb_bs_old)

#Link the loci name with the divergence values
df_locus_divergence <- melt(data.frame(flavi,Compare_bb_bs_old))
df_locus_divergence

#Identify loci with 0 differences
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])
#Identify loci with 1 differences
df_locus_divergence[df_locus_divergence$value <1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
#Identify loci with 2 differences
df_locus_divergence[df_locus_divergence$value <2,]
length(df_locus_divergence$value[df_locus_divergence$value <2])
#Identify loci with 3 differences
df_locus_divergence[df_locus_divergence$value <2.5,]
length(df_locus_divergence$value[df_locus_divergence$value <2.5])
#Identify loci with 4 differences
df_locus_divergence[df_locus_divergence$value <3,]
length(df_locus_divergence$value[df_locus_divergence$value <3])
#Identify loci with 5 differences
df_locus_divergence[df_locus_divergence$value <4,]
length(df_locus_divergence$value[df_locus_divergence$value <4])
#Identify loci with 6 differences
df_locus_divergence[df_locus_divergence$value <5,]
length(df_locus_divergence$value[df_locus_divergence$value <5])

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/Duplicados/H11/common/Consensus/mod/")
sylva <- list.files("flavicollis/Duplicados/G06/common/Consensus/mod/")

Compare_bb_bs_old={}
for (i in 1:33859)
{
  ffile <- read.fasta(paste0("flavicollis/Duplicados/H11/common/Consensus/mod/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("flavicollis/Duplicados/G06/common/Consensus/mod/",sylva[i]), set.attributes = FALSE)
  
  Names_f<-names(ffile)
  Names_s<-names(sfile)
  fs_divergence<-c(sfile, ffile)
  Names_fs <- names(fs_divergence)
  for (j in 1:length(ffile)){
    for (k in (length(ffile) +1):length(fs_divergence)){
      Compare_bb_bs_old[i] <-sum(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))) != eval(parse(text=paste0("fs_divergence$", Names_fs[k]))))/length(eval(parse(text=paste0("fs_divergence$", Names_fs[j]))))*100
      
    }
  }
}

Compare_bb_bs_old

#calculate statistics
min(Compare_bb_bs_old)
max(Compare_bb_bs_old)
mean(Compare_bb_bs_old)
median(Compare_bb_bs_old)
sd(Compare_bb_bs_old)

#Link the loci name with the divergence values
df_locus_divergence <- melt(data.frame(flavi,Compare_bb_bs_old))
df_locus_divergence

#Identify loci with 0 differences
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])
#Identify loci with 1 differences
df_locus_divergence[df_locus_divergence$value <1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
#Identify loci with 2 differences
df_locus_divergence[df_locus_divergence$value <2,]
length(df_locus_divergence$value[df_locus_divergence$value <2])
#Identify loci with 3 differences
df_locus_divergence[df_locus_divergence$value <2.5,]
length(df_locus_divergence$value[df_locus_divergence$value <2.5])
#Identify loci with 4 differences
df_locus_divergence[df_locus_divergence$value <3,]
length(df_locus_divergence$value[df_locus_divergence$value <3])
#Identify loci with 5 differences
df_locus_divergence[df_locus_divergence$value <4,]
length(df_locus_divergence$value[df_locus_divergence$value <4])
#Identify loci with 6 differences
df_locus_divergence[df_locus_divergence$value <4.5,]
length(df_locus_divergence$value[df_locus_divergence$value <4.5])
#Identify loci with 7 differences
df_locus_divergence[df_locus_divergence$value <5,]
length(df_locus_divergence$value[df_locus_divergence$value <5])
#Identify loci with 8 differences
df_locus_divergence[df_locus_divergence$value <6,]
length(df_locus_divergence$value[df_locus_divergence$value <6])
#Identify loci with 9 differences
df_locus_divergence[df_locus_divergence$value <7,]
length(df_locus_divergence$value[df_locus_divergence$value <7])
