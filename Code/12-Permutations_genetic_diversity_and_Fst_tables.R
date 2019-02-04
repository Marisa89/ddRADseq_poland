#Calculate average and standard deviation of genetic diversity parameters
setwd("~/Documents/Resultados/Apodemus_Poland/random/populations_stacks/")
He_Hack<-read.csv("diversity/He_Hacki", sep = "\t", header=FALSE)
He_Hack_average<-mean(data.matrix(He_Hack))
He_Hack_stdev<- sd(data.matrix(He_Hack))

He_Bory<-read.csv("diversity/He_Bory", sep = "\t", header=FALSE)
He_Bory_average<-mean(data.matrix(He_Bory))
He_Bory_stdev<- sd(data.matrix(He_Bory))

He_Bial<-read.csv("diversity/He_Bial", sep = "\t", header=FALSE)
He_Bial_average<-mean(data.matrix(He_Bial))
He_Bial_stdev<- sd(data.matrix(He_Bial))

Ho_Hack<-read.csv("diversity/Ho_Hacki", sep = "\t", header=FALSE)
Ho_Hack_average<-mean(data.matrix(Ho_Hack))
Ho_Hack_stdev<- sd(data.matrix(Ho_Hack))

Ho_Bory<-read.csv("diversity/Ho_Bory", sep = "\t", header=FALSE)
Ho_Bory_average<-mean(data.matrix(Ho_Bory))
Ho_Bory_stdev<- sd(data.matrix(Ho_Bory))

Ho_Bial<-read.csv("diversity/Ho_Bial", sep = "\t", header=FALSE)
Ho_Bial_average<-mean(data.matrix(Ho_Bial))
Ho_Bial_stdev<- sd(data.matrix(Ho_Bial))

Pi_Hack<-read.csv("diversity/Pi_Hacki", sep = "\t", header=FALSE)
Pi_Hack_average<-mean(data.matrix(Pi_Hack))
Pi_Hack_stdev<- sd(data.matrix(Pi_Hack))

Pi_Bory<-read.csv("diversity/Pi_Bory", sep = "\t", header=FALSE)
Pi_Bory_average<-mean(data.matrix(Pi_Bory))
Pi_Bory_stdev<- sd(data.matrix(Pi_Bory))

Pi_Bial<-read.csv("diversity/Pi_Bial", sep = "\t", header=FALSE)
Pi_Bial_average<-mean(data.matrix(Pi_Bial))
Pi_Bial_stdev<- sd(data.matrix(Pi_Bial))

Fis_Hack<-read.csv("diversity/Fis_Hacki", sep = "\t", header=FALSE)
Fis_Hack_average<-mean(data.matrix(Fis_Hack))
Fis_Hack_stdev<- sd(data.matrix(Fis_Hack))

Fis_Bory<-read.csv("diversity/Fis_Bory", sep = "\t", header=FALSE)
Fis_Bory_average<-mean(data.matrix(Fis_Bory))
Fis_Bory_stdev<- sd(data.matrix(Fis_Bory))

Fis_Bial<-read.csv("diversity/Fis_Bial", sep = "\t", header=FALSE)
Fis_Bial_average<-mean(data.matrix(Fis_Bial))
Fis_Bial_stdev<- sd(data.matrix(Fis_Bial))

Ind_Hack<-read.csv("diversity/Ind_Hacki", sep = "\t", header=FALSE)
Ind_Hack_average<-mean(data.matrix(Ind_Hack))
Ind_Hack_stdev<- sd(data.matrix(Ind_Hack))

Ind_Bory<-read.csv("diversity/Ind_Bory", sep = "\t", header=FALSE)
Ind_Bory_average<-mean(data.matrix(Ind_Bory))
Ind_Bory_stdev<- sd(data.matrix(Ind_Bory))

Ind_Bial<-read.csv("diversity/Ind_Bial", sep = "\t", header=FALSE)
Ind_Bial_average<-mean(data.matrix(Ind_Bial))
Ind_Bial_stdev<- sd(data.matrix(Ind_Bial))

Npa_Hack<-read.csv("diversity/Npa_Hacki", sep = "\t", header=FALSE)
Npa_Hack_average<-mean(data.matrix(Npa_Hack))
Npa_Hack_stdev<- sd(data.matrix(Npa_Hack))

Npa_Bory<-read.csv("diversity/Npa_Bory", sep = "\t", header=FALSE)
Npa_Bory_average<-mean(data.matrix(Npa_Bory))
Npa_Bory_stdev<- sd(data.matrix(Npa_Bory))

Npa_Bial<-read.csv("diversity/Npa_Bial", sep = "\t", header=FALSE)
Npa_Bial_average<-mean(data.matrix(Npa_Bial))
Npa_Bial_stdev<- sd(data.matrix(Npa_Bial))



#Build table

A<-c("Hacki","15",Npa_Hack_average, Ind_Hack_average, Ho_Hack_average,He_Hack_average, Pi_Hack_average, Fis_Hack_average)
B<-c("Bory","15",Npa_Bory_average, Ind_Bory_average, Ho_Bory_average,He_Bory_average, Pi_Bory_average, Fis_Bory_average)
C<-c("Bial","15",Npa_Bial_average, Ind_Bial_average, Ho_Bial_average,He_Bial_average, Pi_Bial_average, Fis_Bial_average)
table_genetic_diversity<- t(data.frame(A, B, C))
colnames(table_genetic_diversity)<-c("Population", "N", "Npa", "Indv per locus", "Ho", "He", "Pi", "Fis")
table_gen_div<- table_genetic_diversity[,-1]
rownames(table_gen_div) <- table_genetic_diversity[,1]


#read files for fst
Fst_Hack_Bory<-read.csv("fst/Fst_Hacki_Bory", sep = "\t", header=FALSE)
Fst_Hack_Bory_average<-mean(data.matrix(Fst_Hack_Bory))
Fst_Hack_Bory_stdev<- sd(data.matrix(Fst_Hack_Bory))

Fst_Hack_Bial<-read.csv("fst/Fst_Hacki_Bial", sep = "\t", header=FALSE)
Fst_Hack_Bial_average<-mean(data.matrix(Fst_Hack_Bial))
Fst_Hack_Bial_stdev<- sd(data.matrix(Fst_Hack_Bial))

Fst_Bory_Bial<-read.csv("fst/Fst_Bory_Bial", sep = "\t", header=FALSE)
Fst_Bory_Bial_average<-mean(data.matrix(Fst_Bory_Bial))
Fst_Bory_Bial_stdev<- sd(data.matrix(Fst_Bory_Bial))

D<-c(Fst_Hack_Bory_average, Fst_Hack_Bial_average)
E<-c('', Fst_Bory_Bial_average)

table_fst<- t(data.frame(D, E))
colnames(table_fst)<- c("Bory", "Bial")
rownames(table_fst)<- c("Hack","Bory")             
