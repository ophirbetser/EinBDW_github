
pacman::p_load(
          pacman, 
          ggplot2,
          ggeasy,
          patchwork,
          esquisse,
          glue,
          ggtext,
          showtext,
          ragg,
          plotly
          )

x <- 1:36
y <- rep(seq(-2, 2, 0.5), 4)
y_multi <- y*4
y_rev <- rep(seq(2, -2, -0.5), 4)
y_rand <- rnorm(36, 0, 0.01)

dt <- 
  data.table(
    x = x,
    y = y,
    y_multi = y_multi,
    y_rev = y_rev,
    y_rand = y_rand
    )

p <- 
dt %>% 
  melt(id = "x") %>% 
  ggplot() +
  geom_point(aes(x = x, y = value, color = variable))
  
ggplotly(p)

cor(y, y_multi)**2
cor(y, y_rev)**2
cor(y, y_rand)**2

mean((y - y_multi)**2)
mean((y - y_rev)**2)
mean((y - y_rand)**2)




