
library(stats)
library(ade4)
library(ape)
library(adegenet)
library(phangorn)
library(hierfstat)
library(vcfR)
library(pegas)
library(poppr)
library(radiator)

#Convert from vcf to my_dnabin
vcf_file <- ("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/pop_species_!/repetition_paper/filtering/batch_124.vcf_lowind_maf_hwe_DP.recode.vcf")
vcf_file
vcf <- read.vcfR(vcf_file, verbose = FALSE)
vcf

#Upload population map
pop_apodemus<- read.csv ("~/Documents/Resultados/Apodemus_Poland/pop_map_apodemus", sep = "\t", header = FALSE)
pop_apodemus
pop_map_ordered <- pop_apodemus[order(pop_apodemus$V1),]
pop_map_ordered

#Convert into genind
my_genind<-vcfR2genind(vcf)
my_genind

#Upload the population map in the correct order into genind object
names <- as.vector(indNames(my_genind))
names_order<-data.frame(samples=names, row.names = NULL)
names_order
pop_apodemus_ordered<- pop_apodemus[ order(match(pop_apodemus$V1, names_order$samples)),]
pop_apodemus_ordered
stopifnot(all(indNames(my_genind) == pop_apodemus_ordered$V1))
row.names(pop_apodemus_ordered)=pop_apodemus_ordered$V1
species_ordered<- pop_apodemus_ordered
pop_apodemus_ordered$V1<-NULL
pop_apodemus_ordered$V3<-NULL
pop_apodemus_ordered


my_genind@pop<- as.factor(pop_apodemus_ordered$V2)
my_genind
my_genind@pop


species_ordered
strata(my_genind)<- data.frame(species_ordered$V3)
my_genind

my_genind@strata
#Barplot number of samples per population
barplot(table(pop(my_genind)), col = funky(5), las=3,xlab="Populations", ylab = "Sample size")
barplot(table(my_genind@strata), col = funky(5), las=3,xlab="Species", ylab = "Sample size")

#pca
x.apo<- tab(my_genind, freq=TRUE, NA.method="mean")
pca.apo <- dudi.pca(x.apo, center = TRUE, scale = FALSE)
#Exact results from dudi.pca(df = x.apo, center = TRUE, scale = FALSE, scannf = FALSE, nf = 3)
#Calculate % of ech component
eig.perc <- 100*pca.apo$eig/sum(pca.apo$eig)
head(eig.perc)
#plot pca
theme<-theme(panel.background = element_blank(),panel.border=element_rect(fill=NA),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),strip.background=element_blank(),axis.text.x=element_text(colour="black"),axis.text.y=element_text(colour="black"),axis.ticks=element_line(colour="black"),plot.margin=unit(c(1,1,1,1),"line"))
p<-ggplot(pca.apo$li,aes(x=Axis1,y=Axis2,color=my_genind$pop, shape=as.factor(species_ordered$V3)))
p<-p+geom_point(size=3)+theme+xlab("PCA1=8.03")+ylab("PCA2=5.10")+ theme(legend.title=element_blank())
p<-p+scale_color_manual(labels = c("Bial", "Bory_S", "Bory_F", "Hack", "Kadz"), values = c("brown2", "olivedrab4","seagreen3", "deepskyblue3","orchid3"))
p<-p+scale_shape_manual(labels = c("flavicollis", "sylvaticus"), values = c(19, 17))
p
setwd("~/Desktop/")

ggsave("pca_species_apo.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)

ggsave("pca_species_apo_small.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)

#PCA testing species differentiation with european samples
vcf_file <- ("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/populations/try_europe/analysis_whole_dataset_2_pop/refiltered.recode.vcf")
vcf <- read.vcfR(vcf_file, verbose = FALSE)
vcf


#Upload population map
pop_apodemus<- read.csv ("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/apodemus/Best_parameter_Paris/test_m2_M4_n5/divergence/populations/try_europe/analysis_whole_dataset_2_pop/pop_map_europe_try", sep = "\t", header = FALSE)
pop_apodemus
pop_map_ordered <- pop_apodemus[order(pop_apodemus$V1),]
pop_map_ordered

my_genind<-vcfR2genind(vcf)
my_genind
names <- as.vector(indNames(my_genind))
names_order<-data.frame(samples=names, row.names = NULL)
names_order
pop_apodemus_ordered<- pop_apodemus[ order(match(pop_apodemus$V1, names_order$samples)),]
pop_apodemus_ordered
stopifnot(all(indNames(my_genind) == pop_apodemus_ordered$V1))
row.names(pop_apodemus_ordered)=pop_apodemus_ordered$V1
species_ordered<- pop_apodemus_ordered
pop_apodemus_ordered$V1<-NULL
pop_apodemus_ordered$V3<-NULL
pop_apodemus_ordered


my_genind@pop<- as.factor(pop_apodemus_ordered$V2[1:106])
my_genind
my_genind@pop


#pca
x.apo<- tab(my_genind, freq=TRUE, NA.method="mean")
pca.apo <- dudi.pca(x.apo, center = TRUE, scale = FALSE)
#dudi.pca(df = x.apo, center = TRUE, scale = FALSE, scannf = FALSE, nf = 2)

theme<-theme(panel.background = element_blank(),panel.border=element_rect(fill=NA),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),strip.background=element_blank(),axis.text.x=element_text(colour="black"),axis.text.y=element_text(colour="black"),axis.ticks=element_line(colour="black"),plot.margin=unit(c(1,1,1,1),"line"))
p<-ggplot(pca.apo$li,aes(x=Axis1,y=Axis2,color=my_genind$pop))
p<-p+geom_point(size=1.8)+theme+xlab("PCA1=65.24")+ylab("PCA2=1.8")+ theme(legend.title=element_blank())
p<-p+scale_color_manual(labels = c("Flavicollis Europe","Flavicollis Poland", "Sylvaticus Europe", "Sylvaticus Poland"), values = c("blue","lightblue", "darkgreen", "lightgreen"))
p<-p+scale_shape_manual(labels = c("flavicollis", "sylvaticus", "F", "S"), values = c(19, 17, 14, 10))
p

ggsave("pca_species_apo_europe.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)

ggsave("pca_species_apo_small_europe.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)
