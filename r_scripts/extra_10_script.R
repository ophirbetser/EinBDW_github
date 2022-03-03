### scraping:

library(rvest)

sky_news <- read_html("https://news.sky.com/")
sky_news_14_30 <- data.frame(sky_news %>% html_nodes(".sdc-site-tile__headline-link") %>% html_text())

