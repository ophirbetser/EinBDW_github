# https://www.geogebra.org/m/g5FH2ESK
# https://www.geogebra.org/m/CkFJxQva

pacman::p_load(
            data.table,
            tidyverse,
            openxlsx,
            DT,
            shiny,
            GGally,
            visdat)

dt <- as.data.table(iris)

ggpairs(dt) 
ggpairs(dt, columns = 1:4, ggplot2::aes(colour=Species)) 

names(dt)

model_1 <- 
  lm(Sepal.Length ~ Petal.Length,
     data = dt)

summary(model_1)

cor(dt$Sepal.Length, dt$Petal.Length)**2

model_2 <- 
  lm(Sepal.Length ~ Petal.Length -1,
     data = dt)

summary(model_2)

model_3 <- 
  lm(Sepal.Length ~ Petal.Length + Petal.Width,
     data = dt)

summary(model_3)


model_4 <- 
  lm(Sepal.Length ~ Petal.Length + Petal.Width + Species,
     data = dt)

summary(model_4)

model_5 <- 
  lm(Sepal.Length ~ Petal.Length*Species,
     data = dt)

summary(model_5)


ggplot(dt) +
  aes(x = Petal.Length, y = Sepal.Length) +
  geom_point() +
  geom_smooth(method='lm', se = F)

ggplot(dt) +
  aes(x = Petal.Length, y = Sepal.Length, color = Species) +
  geom_point() +
  geom_smooth(method='lm', se = F)


model_5$coefficients
model_5$residuals
model_5$effects
model_5$fitted.values

dt$pred_mod_1 <- model_1$fitted.values
dt$pred_mod_5 <- model_5$fitted.values


ggplot(dt) +
  geom_point(aes(x = Petal.Length, y = Sepal.Length), color = "black") +
  geom_point(aes(x = Petal.Length, y = pred_mod_1), color = "red") +
  geom_point(aes(x = Petal.Length, y = pred_mod_5), color = "green")


predict(model_1, dt)
