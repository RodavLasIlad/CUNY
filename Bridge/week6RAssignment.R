# http://en.wikipedia.org/wiki/United_States_men%27s_national_soccer_team

library(XML)
url <- "http://en.wikipedia.org/wiki/United_States_men%27s_national_soccer_team"
currentUSTeam <- readHTMLTable(url, which=4, header=T, skip.rows = 1)
names(currentUSTeam)[1] <- "Num"
currentUSTeam[complete.cases(currentUSTeam),]