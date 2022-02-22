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

# clean duplicates
dt <- unique(dt)
dt_2016 <- dt[year == 2016]

# cor
cor(
  dt_2016$bus,
  dt_2016$rail
)

# אגד מצהירה

# כדי לשפר ההכנסות שלנו, אנחנו בוחרים לתרום מליארד דולר לרכבת ישראל
# (בצחוק)


# קורלציה היא לא סיבתיות
# (אבל אנחנו עדיין אוהבים אותה)
# https://www.tylervigen.com/spurious-correlations