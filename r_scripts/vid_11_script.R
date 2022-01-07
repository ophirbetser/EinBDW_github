

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            palmerpenguins,
            visdat)

peng_dt <- as.data.table(palmerpenguins::penguins_raw)

peng_dt_change <- peng_dt
peng_dt_change$`Sample Number`[20:80] <- 0

vis_dat(peng_dt)
vis_miss(peng_dt)
vis_miss(peng_dt, cluster = TRUE)
vis_compare(peng_dt, peng_dt_change)
vis_expect(peng_dt, ~.x >= 25)
peng_dt %>% select_if(is.numeric) %>% vis_cor()
