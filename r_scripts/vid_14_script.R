pacman::p_load(
          ggplot2,
          esquisse
          )

# עושה ל ר ריסיט בלי לסגור אותו באמת
.rs.restartR()


dt <- iris
esquisse::esquisser()

ggplot(dt) +
  aes(x = Sepal.Length) +
  geom_density(adjust = 1.5, fill = "red") +
  theme_classic()

esquisse::esquisser()


dt %>%
  filter(Sepal.Length >= 4.3 & Sepal.Length <= 5.8) %>%
  ggplot() +
  aes(x = Species, y = Sepal.Length) +
  geom_boxplot(shape = "circle", fill = "#B22222") +
  labs(
    x = "dddddd",
    y = "aaaaaa",
    title = "sdfsdf",
    subtitle = "sdfsdf",
    caption = "qweqwe"
  ) +
  theme_minimal()


?esquisser
esquisse::esquisser(viewer = "pane")
esquisse::esquisser(viewer = "browser")
