
# k means clustering

# what is k means clustering?
# https://www.youtube.com/watch?v=nXY6PxAaOk0&ab_channel=JohanHagelb%C3%A4ck
# https://www.naftaliharris.com/blog/visualizing-k-means-clustering/
# https://www.youtube.com/watch?v=4b5d3muPQmA&ab_channel=StatQuestwithJoshStarmer

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            BBmisc,
            shiny,
            visdat)

dt <- fread("/Users/ophirbetser/Ophir/Teaching/IDC_2022/Data_Science_for_Busines/datasets/Mall_Customers.csv")

names(dt)

# make gender numeric
dt$is_male <- 
  ifelse(
    dt$Gender == "Male",
    1,
    0
  )


# keep col for model
dt_for_k_means <- 
  dt[, -c("CustomerID", "Gender")]

# normalize:
# Normalizing method. Available are:
# “center”: Subtract mean.
# “scale”: Divide by standard deviation.
# “standardize”: Center and scale.
# “range”: Scale to a given range.
dt_for_k_means <- normalize(dt_for_k_means, method = "standardize") # method: 


# creat the model
kmeans3 <- kmeans(dt_for_k_means, centers = 3)
kmeans3$centers



# add cluster to the data set
dt <- cbind(dt, clusters_k3 = factor(kmeans3$cluster))
names(dt)

# vis
ggplot(dt) +
  aes(`Annual Income (k$)`, 
      `Spending Score (1-100)`, 
      color = clusters_k3, 
      shape = factor(is_male)) +
  geom_point()



# vis
ggplot(dt) +
  aes(`Age`, 
      `Spending Score (1-100)`, 
      color = clusters_k3, 
      shape = factor(is_male)) +
  geom_point()



#Elbow Method for finding the optimal number of clusters
set.seed(123)
# Compute and plot wss for k = 1 to k = 15.
k.max <- 15
data <- dt_for_k_means
wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15)$tot.withinss})

wss
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")


