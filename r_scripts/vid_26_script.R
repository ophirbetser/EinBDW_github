

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            lubridate,
            shiny,
            visdat)

1:20

map_dbl(1:20, function(x) x + 4)

map_dbl(1:20, ~ .x + 4)

map_dbl(1:20, ~ ..1 + 4)

map_dbl(iris, mean)

map_dbl(iris %>% select_if(is.numeric), mean)

map2_dbl(1:20, 2:21, ~ .x * .y)
map2_dbl(1:20, 2:21, ~ ..1 * ..2)

pmap_dbl(list(1:10, 2:11, 3:12), ~ ..1 * ..2 * ..3)


list <- 
  fread(
    'https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/listings_clean.csv'
  )

list$host_since <- as_date(list$host_since)

list <- list[order(host_since)]

list <- list[!is.na(price_dollars)]
list <- list[!is.na(review_scores_rating)]

map_dbl(2:nrow(list),  ~ cor(list[1:.x]$review_scores_rating, 
                             list[1:.x]$price_dollars))


ggplot(list) +
  geom_point(aes(x = host_since, y = review_scores_rating)) +
  geom_point(aes(x = host_since, y = price_dollars), color = "red")

ggplot(list) +
  geom_point(aes(x = price_dollars, y = review_scores_rating, color = host_since))
  

map_dbl(1:(nrow(list) - 100),  ~ cor(list[.x:(.x + 100)]$review_scores_rating, 
                             list[.x:(.x + 100)]$price_dollars))
