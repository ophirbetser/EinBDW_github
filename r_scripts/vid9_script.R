

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            visdat)


dt <- data.table(a = c(1, 2), b = c("a", "b"))

class(dt)

iris %>% class()

iris_dt <- as.data.table(iris)
iris_dt %>% class()

fwrite(iris_dt, "datasets/iris_dt.csv")

rm(list = ls())

iris_dt <- fread("datasets/iris_dt.csv")

diam <- as.data.table(ggplot2::diamonds)
diam %>% class()
names(diam)
head(diam)

# i
diam$cut %>% unique()
diam[(carat > 0.5 | carat < 0.3) & cut %in% c("Premium", "Fair")]

# j

# לבחור עמודות
diam %>% names()

diam[, carat] %>% class()
diam[, .(carat)] %>% class()

diam[, .(carat)]
diam[, .(carat, price)]
diam[, .(carat, p_of_diam = price)]

# חישובים על עמודות
diam[, .(mean(carat), p_of_diam = max(price))]

diam[, .(mean_of_caret = mean(carat), max_of_price = max(price))]

# הוספה של עמודות
diam[, ":="(voulme = x*y*z)]


# by
str(diam)
diam[, .(mean_of_caret = mean(carat), min_of_price = min(price)),
     by = cut]

res_of_my_analys <- 
diam[, .(mean_of_caret = mean(carat), min_of_price = min(price)),
     by = .(cut, color)]

diam[, ":="(mean_of_caret = mean(carat)),
     by = .(cut, color)]

diam[, .N,
     by = .(color)]

diam[, .(A = uniqueN(carat), NUM = .N),
     by = .(color)]
