
pacman::p_load(
            data.table,
            tidyverse)


# WIDE TO LONG: ----

# the data:
(dt <- as.data.table(iris,keep.rownames = "ind"))

# simple melt
melt(
  dt
)

# use id.vars to choose what
# is youe base linw
melt(
  dt,
  id.vars = c(6)
)  
  
melt(
  dt,
  id.vars = c(1)
)  

melt(
  dt,
  id.vars = c(1,6)
)  

melt(
  dt,
  id.vars = c("ind", "Species")
)  %>% ggplot() +
  aes(x = Species, y = value) +
  geom_boxplot() +
  facet_wrap(~ variable)

# use measure.vars to choose which
# columns to keep

melt(
  dt,
  id.vars = c(1, 6),
  measure.vars = c(2, 3)
) # $variable %>% unique 

# change col names

melt(
  dt,
  id.vars = c("ind", "Species"),
  variable.name = "this_is_variable.names",
  value.name = "this_is_value.names"
)  

# for more Examples:
?data.table::melt()

# LONG TO WIDE: ----

(dt <- as.data.table(diamonds)[, 
          .(max_p = max(price),
            min_p = min(price)), 
          by = .(cut,color)])

dcast(
  dt,
  cut ~ color)

dcast(
  dt,
  cut ~ color,
  value.var = "max_p")

# for more Examples:
?data.table::dcast()


