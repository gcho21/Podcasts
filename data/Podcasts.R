library(tidyverse)
library(rvest)
library(robotstxt)
library(stringr)
library(dplyr)

paths_allowed('https://player.fm/podcasts/Women-Of-Color')

podcasts_html <- read_html('https://player.fm/podcasts/Women-Of-Color')


podcasts <- podcasts_html %>%
  html_nodes('.series:nth-child(n-1) .title') %>%
  html_text()

podcasts <- podcasts %>%
  stringr::str_replace_all("\n", "") %>%
  stringr::str_replace_all('1', "") %>%
  stringr::str_replace_all("4", "") %>%
  stringr::str_replace_all("70", "")

x <- c(podcasts[])
podcasts <- unique(x)




description <- podcasts_html %>%
  html_nodes('.series:nth-child(n) .content-main') %>%
  html_text()

podcasts_dat <- data.frame(podcast = podcasts, description = description
                           , stringsAsFactors = FALSE) %>%
  mutate(together = paste('"', as.character(podcast), '" --'
                          , as.character(description), sep=""))

out_path <- "/home/class21/gcho21/git/Podcasts/data"
write_csv(x = podcasts_dat, path = paste0(out_path,"/Podcasts.csv"))


