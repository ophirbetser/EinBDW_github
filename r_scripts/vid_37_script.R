
pacman::p_load(
  data.table,
  tidyverse,
  openxlsx,
  lubridate,
  skimr,
  Synth,
  DT,
  gt,
  stargazer,
  shiny,
  visdat)

# https://he.wikipedia.org/wiki/%D7%90%D7%98%22%D7%90
# https://www.rdocumentation.org/packages/Synth/versions/1.1-5/topics/basque
#GET DATA
data("basque") # package 'Synth' required
basque <- as.data.table(basque)

basque %>% head %>% gt
#TAKE A LOOK ON THE DATA
vis_dat(basque) #see structure & NA's

names(basque) #read col names
unique(basque$regionname) # 18 diff regions
summary(basque$year) # year: 1955 - 1997

###############################################
# hypothesis:                                 #
# The terrorist attacks have affected the GDP #
###############################################

# first differences
ggplot(basque[regionname == "Basque Country (Pais Vasco)"]) +
  aes(year, gdpcap) +
  geom_point() +
  geom_vline(xintercept = 1975, color = "red") +
  theme_bw()

# compre Basque vs Cataluna
ggplot(basque[regionname %in% c("Basque Country (Pais Vasco)", "Cataluna")]) +
  aes(year, gdpcap, color = regionname) +
  geom_line() +
  geom_vline(xintercept = 1975, color = "red") +
  theme_bw() +
  theme(legend.position = "bottom", legend.title=element_blank())


# add relevant new col's:
mod_data <- basque[regionname %in% c("Basque Country (Pais Vasco)", "Cataluna")]
mod_data$after <- ifelse(mod_data$year > 1975, 1, 0)
mod_data$basque_regions <- ifelse(mod_data$regionname == "Basque Country (Pais Vasco)", 1, 0)



# First Differences
# Y = a0 + a1*after
mod1 <- lm(gdpcap ~ after,
           data = mod_data)
summary(mod1)    

# Control region affect
# Y = a0 + a1*after + a2*basque_regions
mod2 <- lm(gdpcap ~  after + basque_regions,
           data = mod_data)
summary(mod2)    

# Diff-in-Diff
# Y = a0 + a1*after + a2*basque_regions + a3*after*basque_regions
mod3 <- lm(gdpcap ~ after + basque_regions + after*basque_regions,
           data = mod_data)
summary(mod3)    

# maybe invest will help?
# Y = a0 + a1*invest a2*after + a3*basque_regions + a4*after*basque_regions
mod4 <- lm(gdpcap ~ invest + after + basque_regions + after*basque_regions,
           data = mod_data)
summary(mod4)    

# The regression simply calculates averages:
mod_data[, .(avr_gdpcap = mean(gdpcap)), 
         by = .(regionname, after)]


#take a look on the models side by side:
stargazer(mod1, mod2, mod3, type = "text")

