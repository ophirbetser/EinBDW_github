# exploratory descriptive analysis

pacman::p_load(
  data.table,
  tidyverse,
  openxlsx,
  DT,
  shiny,
  skimr,
  psych,
  ExPanDaR,
  ggpubr,
  devtools,
  DescTools,
  Rcpp,
  visdat)


list <- 
  fread(
    'https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/listings_clean.csv'
  )

dim(list)

index_df <- 
  data.table(
    names = names(list),
    minning = rep("", length(names(list)))
  )

index_df %>% datatable()

list %>% names
list %>% vis_dat
list %>% vis_miss
list %>% skim
list %>% summary
list %>% describe
list %>% describeBy(list$beds)
ExPanD(list, export_nb_option = TRUE)


ggecdf(list, x = "price_dollars")
hist(list$price_dollars)
table(list$neighbourhood)
list[, .N, by = neighbourhood]

table(list$neighbourhood, list$host_is_superhost)


prop.table(
  table(list$neighbourhood, list$host_is_superhost)
) # %>% sum

prop.table(
  table(list$neighbourhood, list$host_is_superhost),
  1
) #%>% sum

prop.table(
  table(list$neighbourhood, list$host_is_superhost),
  2
) # %>% sum




# na's
?data.table::nafill()

dt <-
  data.table(x = c(1:10, 1000))

dt$x[c(1:2, 5:6, 9:10)] = NA

dt[, .(x, 
       nafill(x, type ="const", fill = 0),
       nafill(x, "locf"),
       nafill(x, "nocb"))]

dt$x[dt$x > 500] <- 10





