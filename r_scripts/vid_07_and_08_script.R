

install.packages("pacman")
library(ggplot2)

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            visdat)

f(x, y)

x %>% f(y)


sample(1:100, 200)
1:100 %>% sample(10)


sample(1:100, 200, replace = T)
1:100 %>% sample(10)
1:100 %>% sample(200, replace = T)


sum(sample(1:100, 200, replace = T))


1:100 %>% sample(200, replace = T) %>% sum
