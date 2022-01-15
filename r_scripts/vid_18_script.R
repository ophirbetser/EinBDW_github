pacman::p_load(
  ggplot2,
  esquisse,
  ggthemes
)

my_plot <- 
  ggplot(iris) +
  aes(y = Sepal.Length, x = Species, color = Species) +
  geom_boxplot(fill = "#B984E1") + 
  theme_classic()

my_plot +
  labs(
    title = "my title",
    subtitle = "my subtitle",
    x = "Species of iris",
    y = "Sepal Length Dist",
    color = "species",
    caption = "goodbye!!!"
  )



