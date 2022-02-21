

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


list$property_type %>% unique()

list$my_cut <- 
fcase(
  list$property_type %in% c("House", "Villa"), "a",
  list$property_type %in% c("Apartment", "Bed & Breakfast", "Loft"), "b",
  default = "c"
  )

list[, .(property_type, my_cut)] %>% View


?cut

cut(list$price_dollars,
    c(0, 50, 100, 200, Inf)
)

cut(list$price_dollars,
    c(0, 50, 100, 200, Inf),
    labels = c("low", "mid", "high", "extra high"))


factor(
fcase(
  list$price_dollars %between% c(0, 50), "low",
  list$price_dollars %between% c(50, 100), "mid",
  list$price_dollars %between% c(100, 200), "high",
  default = "extra high"
)
)
