

g <- ggplot(iris) +
  aes(y = Sepal.Length, x = Species)


g

g_b <- 
  g + geom_boxplot()

g_v <- 
  g + geom_violin()

g_v

g_b +
  labs(
    title = "hello"
  )


ggplot(iris) +
  aes(y = Sepal.Length, x = Species) +
  geom_boxplot()


ggplot(iris) +
  aes(y = Sepal.Length, x = Species, fill = Species) +
  geom_boxplot()

ggplot(iris) +
  aes(y = Sepal.Length, x = Species) +
  geom_boxplot(fill = "green")

ggplot(iris) +
  aes(y = Sepal.Length, x = Species, color = Species) +
  geom_boxplot()

ggplot(iris) +
  aes(y = Sepal.Length, x = Species) +
  geom_boxplot(color = "green")

ggplot(iris) +
  aes(y = Sepal.Length, x = Species, color = Species) +
  geom_boxplot(fill = "#B984E1")


# https://htmlcolorcodes.com/