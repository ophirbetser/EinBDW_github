
pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            lubridate,
            shiny,
            visdat)

dt <- as.data.table(ggplot2::diamonds)
dt

ggplot(dt) +
  aes(x = cut) +
  geom_bar()

dt[, .N, by = cut] %>% 
  ggplot() +
  aes(x = cut, y = N) +
  geom_bar(stat = "identity")


dt[, .(max_price = max(price)), by = cut] %>% 
  ggplot() +
  aes(x = cut, y = max_price) +
  geom_bar(stat = "identity")

names(dt)

dt[, .N, by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity")

dt[, .N, by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
          position = position_dodge2(preserve = "single"))

dt[, .N, by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
           position = "dodge2")

dt[, .N, by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
           position = "fill")

dt[, .N, by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
           position = "stack")

dt[,.(max_price = max(price)), by = .(cut, color)] %>% 
  ggplot() +
  aes(x = cut, y = max_price, fill = color) +
  geom_bar(stat = "identity",
           position = "dodge2")

names(dt)
dt[,.(max_price = max(price)), by = .(cut, color, clarity)] %>% 
  ggplot() +
  aes(x = cut, y = max_price, fill = color) +
  geom_bar(stat = "identity",
           position = "dodge2") +
  facet_wrap(~clarity)

dt[,.N, by = .(cut, color, clarity)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = cut) +
  geom_bar(stat = "identity",
           position = "dodge2") +
  facet_grid(color~clarity)


dt[,.N, by = .(cut, color, clarity)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
           position = "dodge2") +
  facet_grid(.~clarity)

dt[,.N, by = .(cut, color, clarity)] %>% 
  ggplot() +
  aes(x = cut, y = N, fill = color) +
  geom_bar(stat = "identity",
           position = "dodge2") +
  facet_grid(clarity~.) +
  theme_classic()


dt %>% 
  ggplot() +
  aes(x = x, y = y, color = cut) +
  geom_point() + 
  facet_grid(color~clarity)
