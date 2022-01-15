pacman::p_load(
  data.table,
  tidyverse,
  lubridate,
  visdat)

# POSIX vs Date
today()
today() %>% class()
now()
now() %>% class

# load data from github
Cohort <- 
  fread("https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/Cohort.csv")

uber <- 
  fread("https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/uber_train/uber-raw-data-apr14.csv")

# fix date-data-type
Cohort %>% str
mdy(Cohort$Date) %>% class()

Cohort[, ":="(Date = mdy(Date))]
Cohort %>% str

uber %>% str

uber$`Date/Time` %>% mdy_hms %>% class()

setnames(uber, "Date/Time", "time")

names(uber)

uber[, ":="(time = mdy_hms(time))]
uber %>% str

# get values from date column

Cohort$Date %>% day
Cohort$Date %>% wday
Cohort$Date %>% month
Cohort$Date %>% year
Cohort$Date %>% week
Cohort$Date %>% yday

uber$time %>% hour()
uber$time %>% minute()
uber$time %>% second()


# floor_date
uber$time_floor <- floor_date(uber$time, "2 hours")

uber[, .N, by = time_floor]



ggplot2::diamonds

table(diamonds$cut)
table(diamonds$cut, diamonds$color)
table(diamonds$color, diamonds$cut)


prop.table(table(diamonds$cut, diamonds$color))
prop.table(table(diamonds$cut, diamonds$color), 1)
prop.table(table(diamonds$cut, diamonds$color), 2)
0.10124224 + 0.13913043 + 0.19378882 + 0.19503106  + 0.18819876  +0.10869565 + 0.07391304


round(prop.table(table(diamonds$cut, diamonds$color), 1), 2)


my_data <- prop.table(table(diamonds$cut, diamonds$color))
my_data <- as.data.frame(my_data)



model <- lm(y ~ x, data = diamonds)
model %>% summary()

diamonds
cor(diamonds$x, diamonds$y)

diamonds
cor(diamonds[, c("price","x","y","z")])

cor

