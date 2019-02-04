# Calculating mean sequence divergence based on a multiple fasta files

library(ape)
library(plyr)
library(seqinr)
library(reshape2)
setwd("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/apodemus/CLocus")

# ------------------------------------------------
#--------------------------------------------------

#trying to calculate sequence divergence with a for loop
flavi <- list.files("flavicollis/common/consensus/")
sylva <- list.files("sylvaticus/common/consensus/")

Compare_bb_bs_old={}
for (i in 1:21377)
{
  ffile <- read.fasta(paste0("flavicollis/common/consensus/",flavi[i]),set.attributes = FALSE)
  sfile <- read.fasta(paste0("sylvaticus/common/consensus/",sylva[i]), set.attributes = FALSE)
  
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
colnames(df) <- c(x_name, y_name)
df_locus_divergence

#Identify loci with the highest divergence (>6)
df_locus_divergence[df_locus_divergence$value > 6,]
length(df_locus_divergence$value[df_locus_divergence$value > 6])

#Identify loci with 0 divergence
df_locus_divergence[df_locus_divergence$value ==0,]
length(df_locus_divergence$value[df_locus_divergence$value ==0])


#identify loci with a divergence lower than 1%
df_locus_divergence[df_locus_divergence$value < 1,]
length(df_locus_divergence$value[df_locus_divergence$value <1])
