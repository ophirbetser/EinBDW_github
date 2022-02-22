options(scipen=999) # Disables scientific notation          

pacman::p_load(
  data.table,
  tidyverse,
  openxlsx,
  lubridate,
  skimr,
  runner,
  roll,
  DT,
  gt,
  shiny,
  visdat)

# load the data
dt <- fread("~/Ophir/R PROJECTS/EinBDW22/EinBDW_github/datasets/rail_dataset.csv")
dt %>% head %>% gt

# add some date cols
dt$year <- year(dt$date)
dt$wday <- wday(dt$date)
dt$month <- month(dt$date)
dt$week <- week(dt$date)

# clean duplicates
dt <- unique(dt)
dt_2019 <- dt[year == 2019]
dt <- dt[year <= 2018]

#------#

# sample
sample(1:6, 1)
sample(1:6, 2)

sample(1:6, 7)
sample(1:6, 7, replace = T)

set.seed(12345)
sample(1:6, 1)


# split data
points_for_train <- sample(1:nrow(dt), 0.75*nrow(dt))
train <- dt[points_for_train]
test <- dt[-points_for_train]

# model
model1 <- 
  lm(bus ~ factor(wday)*factor(week) + year,
     data = train)

model %>% summary()
mean((model$residuals)**2)**0.5 # rmse

# predict
test$pred_model1 <- predict(model,
                            test)
mean((test$bus - test$pred_model1)**2)**0.5 # rmse

dt_2019$pred_model1 <- predict(model,
                               dt_2019)
mean((dt_2019$bus - dt_2019$pred_model1)**2)**0.5 # rmse
