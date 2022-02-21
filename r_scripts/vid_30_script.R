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
    x = date,
    y = bus,
    color = factor(wday)
  ) +
  geom_boxplot()



#---#
#clean up by group

sub_dt <- dt[year == 2012]
sub_dt[, mean_by_wday := mean(bus), by = wday]

ggplot(sub_dt) +
  aes(
    x = date,
    y = bus - mean_by_wday, # lm(bus ~ factor(wday), data = sub_dt)$residuals
    color = factor(wday)
  ) +
  geom_point()

sub_dt[, not_outlier := bus %between% c(quantile(bus, 0.05), quantile(bus, 0.99)), by = wday]
sub_dt[not_outlier == TRUE][, .N, by = wday]

sub_dt <- sub_dt[not_outlier == TRUE]


#take a look:
ggplot(sub_dt) +
  aes(
    x = date,
    y = bus - mean_by_wday,
    color = factor(wday)
  ) +
  geom_point()

#----#

# window functions:
?runner::runner
?roll::roll_cor


ex_df <- 
  data.table(
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
]

######
ex_df %>% 
  select(-x) %>% 
  rownames_to_column() %>% 
  melt(id.vars = "rowname") %>% 
  ggplot() +
  aes(
    x = rowname, 
    y = value,
    color = variable,
    group = 
  ) +
  geom_line()

# how many bus trips was in 2014?
ggplot(sub_dt) +
  aes(
    x = date,
    y = runner(sub_dt$bus, f = mean, k = 14),
    color = factor(wday)
  ) +
  geom_point()




d <- dt[1:10]
d[, .(runner(bus, k = 5, sum))]


dt[,roll_cor := roll::roll_cor(bus, rail_boardings, width = 10)]
?roll_cor



n <- 15
x <- rnorm(n)
y <- rnorm(n)
weights <- 0.9 ^ (n:1)
# rolling regressions with complete windows
roll_lm(x, y, width = 5)


runner(
  1:10,
  sum
)


win_size = 3

dt[1:20, .(roll_sum = roll::roll_sum(bus, width = win_size),
       runner = runner(bus, f = sum, k = win_size))]


