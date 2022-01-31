
pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            scales,
            ggeasy,
            visdat)


list <- 
  fread(
    'https://raw.githubusercontent.com/ophirbetser/EinBDW_github/master/datasets/listings_clean.csv'
  )

(list[, .(mean_price = mean(price_dollars)), by = property_type])
list$property_type[list$property_type == ""] <- "Other"
(dt <- list[,
            .(mean_price = mean(price_dollars)), 
            by = property_type])


ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity")

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity")

dt$property_type <- 
  fct_reorder(
  dt$property_type,
  dt$mean_price
)

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity")

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  theme_classic()

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  theme_classic() +
  labs(
    title = "Mean Price by Property Type",
    subtitle = "airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  )

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25)
  ) +
  theme_classic() +
  labs(
    title = "Mean Price by Property Type",
    subtitle = "airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  )

ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  labs(
    title = "Mean Price by Property Type",
    subtitle = "airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  )


ggplot(dt) +
  aes(x = beds, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(
    expand = c(0, NA)
  ) +
  theme_classic()






list$property_type %>% unique()
