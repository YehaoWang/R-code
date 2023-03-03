library(vegan)
library(ggplot2)
library(ggbiplot)
library(data.table)
library(orditools)

setwd("D:/wang/R/Otsuchi_water/")
df=read.csv("2022_Otsuchi_water.csv", sep=",", header = TRUE, row.names=1)

env <- df[1:16, 1:3]
com <- df[1:16, 4:7]
#trans to matrix
m_com <- as.matrix(com)

#nMDS analysis
set.seed(123)
nmds <- metaMDS(m_com, distance="bray")

# plot species and sites
ordiplot(nmds, type = "n", xlim=c(-1, 1),display = "sites")
# may need to run one more time for text code
text(nmds$points, labels = row.names(m_com), cex = 0.8, pos = 3)
ordiplot(nmds, type = "p", xlim=c(-1, 1),display = "species", add = TRUE)
text(nmds$species, labels=colnames(m_com), pos=3, cex=1, col="red")

points(nmds$points, col = "black", pch = 19)

# add environmental variables
envfit_obj <- envfit(nmds, env, perm = 999, na.rm = TRUE)
plot(envfit_obj, add = TRUE, cex = 0.8, xlim=c(-1, 1),col = "blue")
