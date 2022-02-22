options(scipen=999) # Disables scientific notation          

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            lubridate,
            skimr,
            runner,
            roll,
            DT,
            gt,
            shiny,
            visdat)

# load the data
dt <- fread("~/Ophir/R PROJECTS/EinBDW22/EinBDW_github/datasets/rail_dataset.csv")
dt %>% head %>% gt

# add some date cols
dt$year <- year(dt$date)
dt$wday <- wday(dt$date)
dt$month <- month(dt$date)
dt$week <- week(dt$date)

# what??? this is wierd...
dt[,.N, by = year] # 2011 and 2014
dt[,.N, by = .(year, month)] %>% dcast(year ~ month)

dt %>% nrow
unique(dt) %>% nrow # unique(dt, by = "wday") %>% nrow

# let fix the duplictes!
dt <- unique(dt)



#---#

# looking bad:
ggplot(dt) +
  aes(
    x = date,
    y = bus
  ) +
  geom_point()


# make sense, but still bad
ggplot(dt) +
  aes(
    x = date,
    y = bus,
    color = factor(wday)
  ) +
  geom_point()


# better...
ggplot(dt) +
  aes(
    x = wday,
    y = bus,
    color = factor(wday)
  ) +
  geom_boxplot()


ggplot(dt) +
  aes(
    x = factor(wday),
    y = bus
  ) +
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=2), 
               geom="errorbar", width=0.25) +
  geom_jitter(aes(color = factor(wday)),width = 0.15, alpha = 0.2) +
  theme_classic()


ggplot(dt[year %between% c(2001, 2005)]) +
  aes(
    x = factor(wday),
    y = bus
  ) +
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=2), 
               geom="errorbar", width=0.25) +
  geom_jitter(aes(color = factor(wday)),width = 0.1, alpha = 0.5) +
  theme_classic() +
  facet_grid(year~.)


#---#
#clean up by group

sub_dt <- dt[year == 2012]
sub_dt[, res_wday := bus - mean(bus), by = wday]

ggplot(sub_dt) +
  aes(
    x = date,
    y = res_wday, # lm(bus ~ factor(wday), data = sub_dt)$residuals
    color = factor(wday)
  ) +
  geom_point() +
  theme_classic() +
  scale_y_continuous(limits = c(-800000, 500000))

sub_dt[, not_outlier := bus %between% c(quantile(bus, 0.05), quantile(bus, 0.99)), by = wday]
sub_dt[not_outlier == TRUE][, .N, by = wday]

sub_dt_clean <- sub_dt[not_outlier == TRUE]

#----#

# window functions:
?runner::runner # https://cran.r-project.org/web/packages/runner/vignettes/apply_any_r_function.html
?roll::roll_cor


ex_df <- 
  data.table(
    index = 1:20,
    x = rep(c(1:5), 4)
  )

ex_df %>% gt()
ex_df[,
      ":="(
        runner_sum_no_k = runner(x, f = sum),
        runner_mean_no_k = runner(x, f = mean),
        runner_mean_k_2 = runner(x, f = mean, k = 2),
        runner_mean_k_3 = runner(x, f = mean, k = 3),
        runner_mean_k_5 = runner(x, f = mean, k = 5),
        roll_cor = roll_cor(x, 1:20, width = 5)
      )
] %>% gt



ggplot(sub_dt) +
  geom_line(aes(x = date, y = bus))

ggplot(sub_dt[wday %in% 2:6]) +
  geom_line(aes(x = date, y = bus))

ggplot(sub_dt[wday %in% 2:6]) +
  geom_point(aes(x = date, y = bus)) +
  geom_line(aes(x = date, y = runner(bus, f = mean, k = 7)), color = "purple") +
  geom_line(aes(x = date, y = runner(bus, f = mean, k = 14)), color = "green") +
  geom_line(aes(x = date, y = mean(bus)), color = "red") +
  theme_classic()


