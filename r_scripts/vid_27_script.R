
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

#forcats::fct_recode()
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
  ) + coord_flip()

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
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
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
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Mean Price by Property Type",
    subtitle = "airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
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
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Mean Price by Property Type",
    subtitle = "airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90") 
  )

#-------------------------------------------------------------#
ggplot(dt) +
  aes(x = property_type, y = mean_price) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Want to sleep in a boat? open your pockets!",
    subtitle = "Mean Price by Property Type, airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90") 
  )


dt$fill_color <- ifelse(dt$property_type == "Boat", "red", "blue")

ggplot(dt) +
  aes(x = property_type, y = mean_price, fill = fill_color) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Want to sleep in a boat? open your pockets!",
    subtitle = "Mean Price by Property Type, airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90") 
  )

ggplot(dt) +
  aes(x = property_type, y = mean_price, fill = I(fill_color)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Want to sleep in a boat? open your pockets!",
    subtitle = "Mean Price by Property Type, airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90") 
  )

ggplot(dt) +
  aes(x = property_type, y = mean_price, fill = fill_color) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  scale_fill_manual(values = c("blue", "black")) +
  labs(
    title = "Want to sleep in a boat? open your pockets!",
    subtitle = "Mean Price by Property Type, airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90")
  )


#------------------------------------------------------------#

my_plot <- 
  ggplot(dt) +
  aes(x = property_type, y = mean_price, fill = I(fill_color)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    expand = c(0, NA),
    breaks = seq(0, max(dt$mean_price), 25),
    labels = scales::dollar(seq(0, max(dt$mean_price), 25))
  ) +
  theme_classic() +
  easy_remove_x_axis(what = "ticks") +
  easy_remove_y_axis(what = c("ticks", "line")) +
  labs(
    title = "Want to sleep in a boat? open your pockets!",
    subtitle = "Mean Price by Property Type, airbnb, boston, 2008 - 2016",
    x = "",
    y = ""
  ) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
    panel.grid.major.y = element_line( size=0.75, color="gray90") 
  )

my_plot +
  geom_text(aes(label = mean_price))

my_plot +
  geom_text(
    aes(
      label = scales::comma(mean_price, accuracy = 0.1)
      )
    ) + 
  coord_cartesian(clip = "off")

my_plot +
  geom_text(
    aes(
      y = 0,
      label = scales::comma(mean_price, accuracy = 0.1)
    )
  ) + 
  coord_cartesian(clip = "off")

my_plot +
  geom_text(
    aes(
      label = scales::comma(mean_price, accuracy = 0.1)
    ),
    nudge_y = 5,
    fontface = "bold",
    size = 3
  ) + 
  coord_cartesian(clip = "off")

my_plot +
  geom_text(
    aes(
      label = scales::comma(mean_price, accuracy = 0.1)
    ),
    nudge_y = 5,
    fontface = "bold",
    size = 3
  ) + 
  annotate("text", x = 1.4, y = 85, label = "Hello!!") +
  coord_cartesian(clip = "off")

