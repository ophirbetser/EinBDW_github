

plot_1 <- 
  dt %>% ggplot() +
    aes(sepal_length, sepal_width, color = species) +
    geom_point()
