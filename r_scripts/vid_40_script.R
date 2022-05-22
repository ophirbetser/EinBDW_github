# https://rstudio.github.io/leaflet/map_widget.html

pacman::p_load(
            data.table,
            tidyverse,
            lubridate,
            tidygeocoder,
            rgdal,
            rgeos,
            rmapshaper,
            leaflet)

address <- tribble(
  ~street, ~cty, ~country,
  "70 איינשטיין", "Tel Aviv", "Israel",
  "Chaim Levanon 300", "Tel Aviv", "Israel"
)

df <- address %>%
  tidygeocoder::geocode(
    street = street,
    city = cty,
    country = country, 
    method = "osm")

df

leaflet(df) %>%
  # addTiles() %>% 
  addMarkers(df,
             lng = ~long, 
             lat= ~lat) 

