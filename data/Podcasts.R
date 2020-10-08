library(tidyverse)
library(rvest)
library(robotstxt)

paths_allowed('https://player.fm/podcasts/Women-Of-Color')

podcasts_html <- read_html('https://player.fm/podcasts/Women-Of-Color')

podcasts <- podcasts_html %>%
  html_nodes('.title') %>%
  html_text()

description <- podcasts_html %>%
  html_nodes('series.content-main') %>%
  html_text()

podcasts_dat <- data.frame(podcast = podcasts, description = descriptions
                           , stringsAsFactors = FALSE) %>%
  mutate(together = paste('"', as.character(podcast), '" --'
                          , as.character(description), sep=""))

out_path <- "/home/class21/gcho21/git/Podcasts/data"
write_csv(x = podcasts_dat, path = paste0(out_path,"/Podcasts.csv"))


