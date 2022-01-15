pacman::p_load(
  ggplot2,
  esquisse,
  ggthemes,
  scales
)

my_plot <- 
  ggplot(iris) +
  aes(y = Sepal.Length, x = Species, color = Species) +
  geom_boxplot(fill = "#B984E1") + 
  theme_classic()

my_plot

my_plot +
  scale_y_continuous(
    limits = c(0, 100)
  )

my_plot +
  scale_y_continuous(
    limits = 
      c(
        min(iris$Sepal.Length) * 0.95,
        max(iris$Sepal.Length) * 1.05
        )
  )



my_plot +
  scale_y_continuous(
    limits = 
      c(
        min(iris$Sepal.Length) * 0.95,
        max(iris$Sepal.Length) * 1.05
      ),
    breaks = seq(0, 10, 0.25)
  )


my_plot +
  scale_y_continuous(
    breaks = seq(0, 10, 0.25),
    labels = paste0(seq(0, 10, 0.25), " wow")
  )


my_plot +
  scale_y_continuous(
    breaks = seq(0, 10, 0.25),
    labels = scales::comma(10000*seq(0, 10, 0.25))
  )
