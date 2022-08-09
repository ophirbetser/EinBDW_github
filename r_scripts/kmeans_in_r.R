library(BBmisc)
library(ISLR)
library(data.table)
library(GGally)
library(ggplot2)

spotify <- fread('/Users/ophirbetser/Downloads/spotifySongsData (2).csv')

spotify$V1 <- NULL
spotify <- normalize(spotify, method = "standardize")

ggpairs(spotify[,1:14], 
        lower = list(continuous = wrap("points", color = "black", alpha = 0.1), 
                     combo = wrap("box", color = "orange", alpha = 0.3), 
                     discrete = wrap("facetbar", color = "yellow", alpha = 0.3) ), 
        diag = list(continuous = wrap("densityDiag",  color = "blue", alpha = 0.5) ))




kmeans3 <- kmeans(spotify[,1:14], centers = 3)
spotify$kmeans3_pred <-  factor(kmeans3$cluster)

ggpairs(spotify[,c(1:14, 17)], 
        columns = 1:14,
        mapping = ggplot2::aes(color = kmeans3_pred),
        lower = list(continuous = wrap("points", alpha = 0.2), 
                     combo = wrap("box", alpha = 0.3), 
                     discrete = wrap("facetbar", alpha = 0.3) ), 
        diag = list(continuous = wrap("densityDiag", alpha = 0.5) ))


kmeans4 <- kmeans(spotify[,1:14], centers = 4)
spotify$kmeans4_pred <-  factor(kmeans4$cluster)

ggpairs(spotify[,c(1:14, 18)], 
        columns = 1:14,
        mapping = ggplot2::aes(color = kmeans4_pred),
        lower = list(continuous = wrap("points", alpha = 0.2), 
                     combo = wrap("box", alpha = 0.3), 
                     discrete = wrap("facetbar", alpha = 0.3) ), 
        diag = list(continuous = wrap("densityDiag", alpha = 0.5) ))


kmeans4$centers
