

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


# order

piv_1 <- 
  diam[, .N, by = .(color)]

piv_1[order(-N)]

setorder(piv_1, N)

# setnames

setnames(piv_1, "N", "NUM_OF_ROWS")
setnames(piv_1, c("NUM_OF_ROWS", "color"), c("N", "Color"))

# chaning
diam[, .N, by = .(color)][order(N)][, .(sum(N))]

diam[, .(sum_of_price = sum(price)), by = .(color)][, 
    ":="(tot_sum = sum(sum_of_price))][,
    ":="(prop = sum_of_price / tot_sum)][order(prop)]

# choose first of last row per group
diam[order(color, price)][, .SD[1], by = color]

diam[order(color, price)][, .SD[.N], by = color]

diam[order(color, price)][, .SD[c(1, .N)], by = color]

# shift

iris_dt[, ":="(reg_shift_SW = shift(Sepal.Width))]
iris_dt[, ":="(reg_shift_SW_4 = shift(Sepal.Width, 4))]
iris_dt[, ":="(reg_shift_SW_min_2 = shift(Sepal.Width, -2))]

iris_dt[, ":="(reg_shift_SW_by_group = shift(Sepal.Width)), by = Species]
