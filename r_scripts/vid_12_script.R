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
