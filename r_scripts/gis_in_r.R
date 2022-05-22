library(leaflet)
library(tidyr)
library(dplyr)
library(purrr)

x <- c(34.8, 34.9, 35, 35.1, 35, 34.9)
y <- c(32, 32.1, 32.1, 32, 31.9, 31.9)
labs <- c("p1", "p2", "p3", "p4", "p5", "p6")

locations_with_labs <- 
  data.frame(
    Long = x,
    Lat = y,
    labs = labs
    )

locations <- locations_with_labs[, -3]

# get unique coordinates
locations_distinct <- locations %>%
  distinct_all()

# get all combinations between any two points
combs <- combn(1:nrow(locations_distinct),2,simplify = FALSE)

# get pairs of coordinates
locations_paris <- map_df(combs,function(x){
  df <- bind_cols(
    locations_distinct[x[1],],locations_distinct[x[2],]
  )
  colnames(df) <- c("Long","Lat","Long1","Lat1")
  return(df)
})

map <- leaflet(locations_paris) %>%
  addTiles() 

for(i in 1 : nrow(locations_paris)){
  map <- map %>%
    addPolylines(
      lng = c(locations_paris$Long[i],locations_paris$Long1[i]),
      lat = c(locations_paris$Lat[i],locations_paris$Lat1[i])
    )
}

map %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) 



#--------#


x1 <- x[1]
y1 <- y[1]
x2 <- x[3]
y2 <- y[3]
h <- 0.05
w <-  0.1

m <- (y2-y1)/(x2-x1)
m_tag <- -1/m

b <- sqrt(w**2 / (1 + m_tag**2))
a <- m_tag*b

res_x <- c(x1 + b, x1 - b)
res_y <- c(y1 + a, y1 - a)

my_points <- 
  data.frame(
    x = res_x,
    y = res_y
  )

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(data = my_points,
             lng = ~x, lat= ~y,
             color = "red") 

cx <- res_x[1]
cy <- res_y[1]

b_c <- sqrt(h**2 / (1 + m**2))
a_c <- m*b_c

res_cx <- c(x1 + b + b_c, x1 + b - b_c)
res_cy <- c(y1 + a + a_c, y1 + a - a_c)

my_points_c <- 
  data.frame(
    x = res_cx,
    y = res_cy
  )

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(data = my_points,
                   lng = ~x, lat= ~y,
                   color = "red") %>%  
  addCircleMarkers(data = my_points_c,
                 lng = ~x, lat= ~y,
                 color = "green") 


res_dx <- c(x1 - b + b_c, x1 - b - b_c)
res_dy <- c(y1 - a + a_c, y1 - a - a_c)

my_points_d <- 
  data.frame(
    x = res_dx,
    y = res_dy
  )

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(data = my_points,
                   lng = ~x, lat= ~y,
                   color = "red") %>%  
  addCircleMarkers(data = my_points_c,
                   lng = ~x, lat= ~y,
                   color = "green")  %>%  
  addCircleMarkers(data = my_points_d,
                   lng = ~x, lat= ~y,
                   color = "black") 

#---#



# inputs:

x1 <- x[1]
y1 <- y[1]
x2 <- x[3]
y2 <- y[3]
h <- 0.05
w <-  0.1

# helpers
m <- (y2-y1)/(x2-x1)
m_tag <- -1/m

b <- sqrt(w**2 / (1 + m_tag**2))
a <- m_tag*b

b_c <- sqrt(h**2 / (1 + m**2))
a_c <- m*b_c



# outputs:

c1_x <- x1 + b + b_c
c2_x <- x1 + b - b_c
c3_x <- x1 - b + b_c
c4_x <- x1 - b - b_c

c1_y <- y1 + a + a_c
c2_y <- y1 + a - a_c
c3_y <- y1 - a + a_c
c4_y <- y1 - a - a_c

cx <- c(c1_x, c2_x, c3_x, c4_x)
cy <- c(c1_y, c2_y, c3_y, c4_y)

my_poly <- 
  data.frame(
    x = cx,
    y = cy
  )


map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(data = my_poly,
                   lng = ~x, lat= ~y,
                   color = "red") 

# create function:

create_my_poly_reg <- 
  function(x1, x2, y1, y2, h, w){
    m <- (y2-y1)/(x2-x1)
    m_tag <- -1/m
    
    b <- sqrt(w**2 / (1 + m_tag**2))
    a <- m_tag*b
    
    b_c <- sqrt(h**2 / (1 + m**2))
    a_c <- m*b_c
    
    c1_x <- x1 + b + b_c
    c2_x <- x1 + b - b_c
    c3_x <- x1 - b + b_c
    c4_x <- x1 - b - b_c
    
    c1_y <- y1 + a + a_c
    c2_y <- y1 + a - a_c
    c3_y <- y1 - a + a_c
    c4_y <- y1 - a - a_c
    
    cx <- c(c1_x, c2_x, c3_x, c4_x)
    cy <- c(c1_y, c2_y, c3_y, c4_y)
    
    my_poly <- 
      data.frame(
        x = cx,
        y = cy
      )
    
    return(my_poly)
  }

create_my_poly_x1_is_x2 <- 
  function(x1, x2, y1, y2, h, w){
    c1_x <- x1 + w
    c2_x <- x1 + w
    c3_x <- x1 - w
    c4_x <- x1 - w
    
    c1_y <- y1 + h
    c2_y <- y1 - h
    c3_y <- y1 + h
    c4_y <- y1 - h
    
    cx <- c(c1_x, c2_x, c3_x, c4_x)
    cy <- c(c1_y, c2_y, c3_y, c4_y)
    
    my_poly <- 
      data.frame(
        x = cx,
        y = cy
      )
  }

create_my_poly_y1_is_y2 <- 
  function(x1, x2, y1, y2, h, w){
    c1_x <- x1 + h
    c2_x <- x1 + h
    c3_x <- x1 - h
    c4_x <- x1 - h
    
    c1_y <- y1 + w
    c2_y <- y1 - w
    c3_y <- y1 + w
    c4_y <- y1 - w
    
    cx <- c(c1_x, c2_x, c3_x, c4_x)
    cy <- c(c1_y, c2_y, c3_y, c4_y)
    
    my_poly <- 
      data.frame(
        x = cx,
        y = cy
      )
  }


create_my_poly <- 
  function(x1, x2, y1, y2, h, w){
    if(x1 == x2){
      res <- create_my_poly_x1_is_x2(x1, x2, y1, y2, h, w)
      return(res)  
    }
    if(y1 == y2){
      res <- create_my_poly_y1_is_y2(x1, x2, y1, y2, h, w)
      return(res)  
    }
    res <- create_my_poly_reg(x1, x2, y1, y2, h, w)
    return(res)  
  }
    

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(
    data = 
      create_my_poly(
        x1 = x[1],
        x2 = x[4],
        y1 = y[1],
        y2 = y[4],
        h = 0.01,
        w = 0.05
      ),
      lng = ~x, lat= ~y,
      color = "red"
    )

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(
    data = 
      create_my_poly(
        x1 = x[2],
        x2 = x[6],
        y1 = y[2],
        y2 = y[6],
        h = 0.01,
        w = 0.05
      ),
    lng = ~x, lat= ~y,
    color = "red"
  )

map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(
    data = 
      create_my_poly(
        x1 = x[2],
        x2 = x[5],
        y1 = y[2],
        y2 = y[5],
        h = 0.01,
        w = 0.05
      ),
    lng = ~x, lat= ~y,
    color = "red"
  )


map %>% 
  addGraticule(interval = 0.1,
               options = 
                 pathOptions(
                   pointerEvents = "none",
                   clickable = T)) %>% 
  addMarkers(data = locations_with_labs,
             lng = ~x, lat= ~y, label = ~labs) %>% 
  addCircleMarkers(
    data = 
      create_my_poly(
        x1 = x[2],
        x2 = x[5],
        y1 = y[2],
        y2 = y[5],
        h = 0.01,
        w = 0.1
      ),
    lng = ~x, lat= ~y,
    color = "red"
  )
