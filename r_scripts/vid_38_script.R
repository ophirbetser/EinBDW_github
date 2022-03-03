pacman::p_load(
  data.table,
  tidyverse,
  openxlsx,
  lubridate,
  skimr,
  DT,
  shiny,
  caret,
  visdat)

# load data
dt <- diamonds %>% as.data.table() # the same as `as.data.table(diamonds)`s

# print the prop table of 'cut' column
print(unique(dt$cut))
dt[, .(prop = .N/nrow(dt)), by = cut][order(prop)]

# using 'cut' prop to create split of the data:
intrain <- createDataPartition(y=dt$cut, p=0.7, list=FALSE)
train <- dt[intrain,]
test <- dt[!intrain,]

# verify we have the right prop 
train[, .(prop = .N/nrow(train)), by = cut][order(prop)]
test[, .(prop = .N/nrow(test)), by = cut][order(prop)]

rm(list = ls())
################################################################################

####################
# cross validation #
####################

#INTRO

DT <- diamonds %>% as.data.table()
sample <- sample.int(n = nrow(DT), size = floor(.85*nrow(DT)), replace = F)
trainDT <- DT[sample, ]
testDT  <- DT[-sample, ]


# create 5 fold from my data, using 'createFolds' function for 'caret' library
# use the prop of 'color'
folds <- createFolds(trainDT$color, k = 5,
                     list = TRUE, returnTrain = FALSE)
# no prop consideration
folds <- createFolds(as.integer(row.names(trainDT)), k = 5,
                     list = TRUE, returnTrain = FALSE)


#simple example: train on fold 1,2,3,4 and prediction model on fold 5:
model <- lm(price ~ .,
            data = trainDT[-folds$Fold5])

# model R^2:
summary(model)$r.squared
#  R^2 of training data
cor(trainDT[folds$Fold5, price], predict(model, trainDT[folds$Fold5]))**2
################################################################################

# BUILD CROSS VALIDATION

# I will use 5 folds...
folds_number <- 5

# create the folds with 'caret' 'createFolds' function:
folds <- createFolds(as.integer(row.names(trainDT)), 
                     k = folds_number,
                     list = TRUE, 
                     returnTrain = FALSE)

# create a empty data.table to store my results:
results <- data.table(Fold = numeric(), 
                      model_R_2 = numeric(), 
                      fold_R_2 = numeric())

# run the cross validation
for(i in 1:folds_number){
  # train a model:
  model <- lm(price ~ .,
              data = trainDT[-folds[[paste0("Fold", i)]]])
  # put model scores in 'results' table:
  results <- rbind(results,
                   data.table(Fold = i, 
                              model_R_2 = summary(model)$r.squared, 
                              fold_R_2 = cor(trainDT[folds[[paste0("Fold", i)]], price], 
                                             predict(model, trainDT[folds[[paste0("Fold", i)]]]))**2))
  
}
results
results$fold_R_2 %>% mean()

rm(list = ls())
################################################################################

##################
# the caret way: #
##################

# load the iris data set:
DT <- diamonds %>% as.data.table()
sample <- sample.int(n = nrow(DT), size = floor(.85*nrow(DT)), replace = F)
trainDT <- DT[sample, ]
testDT  <- DT[-sample, ]

# build trainControl
train.control <- trainControl(method = "cv",
                              number = 10,
                              savePredictions = TRUE)

# Train the model
model <- train(price ~ ., 
               data = trainDT, 
               method = "lm",
               trControl = train.control)

# view folds scores!
model$resample
model$resample$Rsquared %>% mean()

summary(model)
summary(lm(price ~ ., data = trainDT))
