# script info and options ----
## File Name:   Cohort Analyses                 
## Date:        2022-04-10                
## Author:      Ophir Betser              
## Author Mail: ophir.betser@gmail.com   

# set options & load packages ----
## options
options(scipen=999) # Disables scientific notation          
options(digits=6)   # Limits the number of digits printed       
##  packages 
if (!require("pacman")){                                  
  install.packages("pacman")}
pacman::p_load(
            data.table,
            tidyverse,
            lubridate,
            skimr,
            gt,
            readr,
            visdat)

# Data loading & processing ----
## load data
github_path <- "https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/Cohort.csv"
cohort_dt <- fread(github_path)

## first look at the data
cohort_dt %>% dim()
cohort_dt %>% names()
cohort_dt %>% str()
cohort_dt %>% head()
cohort_dt %>% skim()

## fix date
cohort_dt$Date <- mdy(cohort_dt$Date)

## order the data by CustomerID + Date
setorder(cohort_dt, CustomerID, Date)

## quick research
### how many customers?
uniqueN(cohort_dt$CustomerID) # 272
### avr revenue per transaction
mean(cohort_dt$Amount) # 407.1$
### avr revenue per user
sum(cohort_dt$Amount) / uniqueN(cohort_dt$CustomerID)# 1344.3
### distribution: N transactions per user
cohort_dt[, .(N_transactions = .N), by = CustomerID][
  , .N, by = N_transactions] %>% 
  ggplot() + 
  aes(x = N_transactions,
      y = N) +
  geom_bar(stat = "identity") +
  theme_classic()
### distribution: N revenue per transaction
ggplot(cohort_dt) +
  geom_histogram(aes(Amount))
### distribution: N revenue per user
cohort_dt[, .(sum_Amount = sum(Amount)), by = CustomerID] %>% 
ggplot() +
  geom_histogram(aes(sum_Amount))

## building a feature for analysis
### purchase_rate == purchase # per user
### cohort == date for the first purchase per user
### customer_age == how mach time has passed between this purchase and the first purchase
cohort_dt[, ":=" (
  purchase_rate = 1:.N,
  cohort = min(Date)
  ),
  by = CustomerID]

cohort_dt[, ":=" (
  customer_age = interval(cohort, Date) %/% months(1)
  )
]

cohort_dt %>% View()

# Cohort Analysis ----
## How many transaction in each month?
cohort_dt[, .(number_of_transaction = .N), by = Date][order(Date)]
## How many transaction in each cohort?
cohort_dt[, .(number_of_transaction = .N), by = cohort][order(cohort)]
## How many unique customers in each cohort?
cohort_dt[, .(number_of_customers = uniqueN(CustomerID)), by = cohort][order(cohort)]

## Retention
retention_abs <- 
  cohort_dt[, 
            .(number_of_transaction = .N),
            by = .(cohort, customer_age)]
### make data "wide"
retention_abs_wide <- 
  retention_abs %>% 
  dcast(
    cohort ~ customer_age,
    value.var = "number_of_transaction",
    fill = 0
    )

## Retention in percentage
retention_prec_wide <- 
  cbind(
    retention_abs_wide[,1],
    round(retention_abs_wide[,2:9] / retention_abs_wide[[2]], 3)
  )

### or like that:
retention_abs[, ":="(first_month = head(number_of_transaction, 1)), by = cohort]
retention_abs[, ":="(prec_transaction = round(number_of_transaction / first_month, 2))]

### take a viz look
#### abs
retention_abs %>% 
  ggplot() + 
  aes(
    x = factor(customer_age), 
    y = reorder(cohort, desc(cohort))
    ) +
  geom_raster(
    aes(fill = number_of_transaction),
    show.legend = F
    ) +
  scale_fill_gradientn(
    colours=c("red","blue")
    ) +
  geom_text(
    aes(label = number_of_transaction), 
    color = "black"
    ) +
  theme_classic()

#### percentage
retention_abs %>% 
  ggplot() + 
  aes(
    x = factor(customer_age), 
    y = reorder(cohort, desc(cohort))
  ) +
  geom_raster(
    aes(fill = prec_transaction),
    show.legend = F
  ) +
  scale_fill_gradientn(
    colours=c("red","blue")
  ) +
  geom_text(
    aes(label = prec_transaction), 
    color = "black"
  ) +
  theme_classic()

### Cohort Analysis Plot
retention_abs %>% # not good...
  ggplot() +
  aes(customer_age, 
      prec_transaction, 
      color = factor(cohort)) +
  geom_line(size = 1.5) +
  geom_point(size = 3) +
  scale_y_continuous(breaks = seq(0, 1, 0.1)) +
  scale_x_continuous(breaks = seq(1, 7, 1)) +
  theme_classic()

# https://github.com/rstudio/cheatsheets/blob/main/tidyr.pdf
retention_abs %>% # great!
  tidyr::complete(
  cohort,
  nesting(customer_age),
  fill = list(prec_transaction = 0)) %>% 
  ggplot() +
  aes(customer_age, 
      prec_transaction, 
      color = factor(cohort)) +
  geom_line(size = 1.5) +
  geom_point(size = 3) +
  scale_y_continuous(breaks = seq(0, 1, 0.1)) +
  scale_x_continuous(breaks = seq(1, 7, 1)) +
  theme_classic()

# LTV - customer life time value ----
## simple approach:
### ARPU - average revenue per user
ARPU_raw <- sum(cohort_dt$Amount) / uniqueN(cohort_dt$CustomerID)
ARPU_raw

### let assume ours  marginal cost is 30% of etch sale... so:
ARPU <- ARPU_raw * (1 - 0.3)
ARPU

## ARPU per cohort approach:
cohort_dt[, 
          .(
            unique_customers = uniqueN(CustomerID),
            total_revenue = sum(Amount),
            ARPU_raw = sum(Amount) / uniqueN(CustomerID),
            ARPU = (sum(Amount) / uniqueN(CustomerID)) * 0.7
            ),
       by = cohort][order(cohort)] %>% gt()

# clearing env ----
rm(list = ls())         # Clear environment                           
pacman::p_unload(all)   # Clear packages                  
dev.off()               # Clear plots      
cat("\014")             # Clear console               


