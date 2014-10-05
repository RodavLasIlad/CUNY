# devtools::install_github("rvest")
library("rvest")

# Brand new video game: "Middle Earth: Shadow or Mordor"
shadowOfMordor <- html("http://www.ign.com/games/middle-earth-shadow-of-mordor/pc-20008394")
rating <- shadowOfMordor %>% 
  html_nodes(".ratingValue")  %>%
  html_text() %>%
  as.numeric()
rating[1]

simGames <- shadowOfMordor %>%
  html_nodes(".gamesYouMayLike-name") %>%
  html_text()
simGames <- gsub("^\\s+", "", simGames)
simGames <- gsub("\\s+$", "", simGames)
simGames

summary <- shadowOfMordor %>%
  html_nodes(".gameInfo p") %>%
  html_text()
summary <- gsub("^\\s+", "", summary)
summary <- gsub("\\s+$", "", summary)
summary