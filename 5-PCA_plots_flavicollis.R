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
vcf_file <- ("~/Documents/Resultados/Apodemus_Poland/Demultiplex/concatenated/flavicollis/Best_parameters/p3r0.8/hwe_maf_dp.recode.vcf")
vcf <- read.vcfR(vcf_file, verbose = FALSE)
vcf
record <- 130

#Upload population map
pop_apodemus<- read.csv ("~/Documents/Resultados/Apodemus_Poland/pop_map_apodemus_fla", sep = "\t", header = FALSE)
dim(as.data.frame(pop_apodemus))
pop_map_ordered <- pop_apodemus[order(pop_apodemus$V1),]
pop_apodemus
pop_map_ordered

my_genind<-vcfR2genind(vcf)
my_genind

names <- as.vector(indNames(my_genind))
names_order<-data.frame(samples=names, row.names = NULL)
names_order
pop_apodemus_ordered<- pop_apodemus[ order(match(pop_apodemus$V1, names_order$samples)),]
as.data.frame(pop_apodemus_ordered)
stopifnot(all(indNames(my_genind) == pop_apodemus_ordered$V1))
row.names(pop_apodemus_ordered)=pop_apodemus_ordered$V1

my_genind@pop<- as.factor(pop_apodemus_ordered$V2)
my_genind
my_genind@pop


#my_genind@strata
#Barplot number of samples per population
barplot(table(pop(my_genind)), col = funky(5), las=3, ylab = "Sample size")
#pca
x.apo<- tab(my_genind, freq=TRUE, NA.method="mean")
pca.apo <- dudi.pca(x.apo, center = TRUE, scale = FALSE)

eig.perc <- 100*pca.apo$eig/sum(pca.apo$eig)
head(eig.perc)
theme<-theme(panel.background = element_blank(),panel.border=element_rect(fill=NA),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),strip.background=element_blank())
p<-ggplot(pca.apo$li, aes(x=Axis1,y=Axis2, label=indNames(my_genind)))+
  theme+xlab("PCA1=7.23")+
  theme+ylab("PCA2=5.72")+
  #geom_text(label=indNames(my_genind))+
  geom_point((aes(color=my_genind$pop)), size=4)+
  theme(legend.title=element_blank())
p





###
ggsave("pca_species_apo_europe.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)

ggsave("pca_species_apo_small_europe.tiff", p,
       scale = 1, width = 180, height = NA, units = c("mm"),
       dpi = "retina", limitsize = TRUE, device = "tiff", path = NULL)
