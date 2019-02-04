setwd("~/Documents/Resultados/Phylogeography_apodemus/sylvaticus/results_parameters/")
#read individual data
m<-read.table("resultados_m_mod")
Mi<-read.table("resultados_Mi")
n<-read.table("resultados_n_mod")
str(m)
#Convert the second colunm into a factor
m$V2<-as.factor(m$V2)
Mi$V2<-as.factor(Mi$V2)
n$V2<-as.factor(n$V2)

#Read population data
m_pop<-read.table("results_pop_filtered_m_mod")
Mi_pop<-read.table("results_pop_filtered_Mi")
n_pop<-read.table("results_pop_filtered_n_mod")


#Convert the second and third colunm into a factor
m_pop$V2<-as.factor(m_pop$V2)
m_pop$V3<-as.factor(m_pop$V3)
Mi_pop$V2<-as.factor(Mi_pop$V2)
Mi_pop$V3<-as.factor(Mi_pop$V3)
n_pop$V2<-as.factor(n_pop$V2)
n_pop$V3<-as.factor(n_pop$V3)

library("ggplot2")

#m_Assembled_loci
#m_ind_graph<- ggplot(m, aes(x = V2, y = V3)) +
#  geom_boxplot()
#m_ind_graph + xlab("m") + ylab("Assembled loci")

#m_pop_graph<-ggplot(m_pop, aes(x=V2, y=V4))+
#  geom_point()
#m_pop_graph + geom_point(aes(colour = factor(m_pop$V3)))

m_comb_assembled <- ggplot() +
  # individual data
  geom_boxplot(data=m, aes(x=V2, y=V3))+
  xlab("m") + ylab("Assembled loci")+
  #population data
  geom_point(data=m_pop, aes(x=V2, y=V4, color= factor(m_pop$V3)))+ 
  guides(color=FALSE)

#p+guides(color = FALSE, size = FALSE)#m_Polymorphic_loci
m_comb_poly <- ggplot() +
  # individual data
  geom_boxplot(data=m, aes(x=V2, y=V4))+
  xlab("m") + ylab("Polymorphic loci")+
  #population data
  geom_point(data=m_pop, aes(x=V2, y=V6, color= factor(m_pop$V3)))+ 
  guides(color=FALSE)
#m_SNPs_loci
m_comb_snps <- ggplot() +
  # individual data
  geom_boxplot(data=m, aes(x=V2, y=V5))+
  xlab("m") + ylab("SNPs")+
  #population data
  geom_point(data=m_pop, aes(x=V2, y=V5, color= factor(m_pop$V3)))+ 
  guides(color=FALSE)

#Mi
Mi_comb_assembled <- ggplot() +
  # individual data
  geom_boxplot(data=Mi, aes(x=V2, y=V3))+
  xlab("M") + ylab("Assembled loci")+
  #population data
  geom_point(data=Mi_pop, aes(x=V2, y=V4, color= factor(Mi_pop$V3)))+ 
  guides(color=FALSE)

Mi_comb_poly <- ggplot() +
  # individual data
  geom_boxplot(data=Mi, aes(x=V2, y=V4))+
  xlab("M") + ylab("Polymorphic loci")+
  #population data
  geom_point(data=Mi_pop, aes(x=V2, y=V6, color= factor(Mi_pop$V3)))+ 
  guides(color=FALSE)

Mi_comb_snps <- ggplot() +
  # individual data
  geom_boxplot(data=Mi, aes(x=V2, y=V5))+
  xlab("M") + ylab("SNPs")+
  #population data
  geom_point(data=Mi_pop, aes(x=V2, y=V5, color= factor(Mi_pop$V3)))+ 
  guides(color=FALSE)

#n
n_comb_assembled <- ggplot() +
  # individual data
  geom_boxplot(data=n, aes(x=V2, y=V3))+
  xlab("n") + ylab("Assembled loci")+
  #population data
  geom_point(data=n_pop, aes(x=V2, y=V4, color= factor(n_pop$V3)))+ 
  guides(color=FALSE)

n_comb_poly <- ggplot() +
  # individual data
  geom_boxplot(data=n, aes(x=V2, y=V4))+
  xlab("n") + ylab("Polymorphic loci")+
  #population data
  geom_point(data=n_pop, aes(x=V2, y=V6, color= factor(n_pop$V3)))+ 
  guides(color=FALSE)

n_comb_snps <- ggplot() +
  # individual data
  geom_boxplot(data=n, aes(x=V2, y=V5))+
  xlab("n") + ylab("SNPs")+
  #population data
  geom_point(data=n_pop, aes(x=V2, y=V5, color= factor(n_pop$V3)))+ 
  guides(color=FALSE)

library(cowplot)
plot_grid(m_comb_assembled,m_comb_poly, m_comb_snps, Mi_comb_assembled, Mi_comb_poly
          ,Mi_comb_snps, n_comb_assembled, n_comb_poly, n_comb_snps, 
          labels = c("A", "B", "C","D", "E", "F", "G", "H", "I"),
          ncol = 3, nrow = 3)

#plot coverage
setwd("~/Documents/Resultados/Phylogeography_apodemus/sylvaticus/")
m_cov_initial<- read.table("coverage_initial_m", dec=".", stringsAsFactors = FALSE)
m_cov_initial$V2<-as.factor(m_cov_initial$V2)
str(m_cov_initial)
m_cov_initial
m_cov_final<- read.table("coverage_final_m", dec=".", stringsAsFactors = FALSE)
m_cov_final$V2<-as.factor(m_cov_final$V2)

#m_cov_final$V8<-as.numeric(m_cov_final$V8)
str(m_cov_final)


coverage_total_initial<-cbind.data.frame(m_cov_initial$V2,m_cov_initial$V3, m_cov_initial$V6, stringsAsFactors = FALSE)
str (coverage_total_initial)
names(coverage_total_initial)[1]<-paste ("V1")
names(coverage_total_initial)[2]<-paste ("V2")
names(coverage_total_initial)[3]<-paste ("V3")
names(coverage_total_initial)
coverage_total_initial
coverage_total_final<-cbind.data.frame(m_cov_final$V3, m_cov_final$V8,stringsAsFactors = FALSE)
#names(coverage_total_final)[1]<-paste ("V1")
names(coverage_total_final)[1]<-paste ("V4")
names(coverage_total_final)[2]<-paste ("V5")
names(coverage_total_final)
coverage_total_final
coverage_total<-cbind(coverage_total_initial, coverage_total_final, stringsAsFactors = FALSE)
coverage_total
str(coverage_total)
coverage_total
coverage_total$V3 =as.numeric(gsub("\\;", "", coverage_total$V3 ))
coverage_total
names(coverage_total)
library(reshape2)
cov.m <- melt(coverage_total, id.vars = 'V1', measure.vars = c("V3", 'V5'))
cov.m$variable =as.character(gsub("\\V3", "Mean_coverage", cov.m$variable ))
cov.m$variable=as.character(gsub("\\V5", "Mean_merged_coverage", cov.m$variable ))
cov.m$value=as.character(gsub(";", "", cov.m$value ))

str(cov.m)
cov.m$variable <- as.factor(cov.m$variable)
cov.m$value <- as.integer(cov.m$value)

#grouped boxplot
ggplot(cov.m, aes(x=V1, y=value, fill=variable)) +
  geom_boxplot()
#m_coverage
coverage_plot<-ggplot(data=cov.m, aes(x=V1, y=value, fill= variable))+
  geom_boxplot()
coverage_plot
coverage_plot + xlab ("m") +ylab ("Coverage")+
  theme(legend.title=element_blank())
#initial+final
geom_boxplot()


