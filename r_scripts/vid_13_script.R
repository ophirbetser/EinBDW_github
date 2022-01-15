pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            visdat)


ggplot(iris) +
  aes(Sepal.Length,Sepal.Width) +
  geom_point()

ggplot(iris) +
  aes(Sepal.Length,Sepal.Width) +
  geom_line()

ggplot(iris, aes(Sepal.Length,Sepal.Width)) +
  geom_point()

ggplot(iris) +
  aes(Sepal.Length,Sepal.Width, color = Species) +
  geom_point()

ggplot(iris) +
  aes(Sepal.Length,Sepal.Width, color = Species, size = Petal.Length) +
  geom_point()

