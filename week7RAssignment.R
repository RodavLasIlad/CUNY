#Part 1
library(RSQLite)
setwd('C:/Users/Brett/Dropbox/CUNY')
sqlite <- dbDriver("SQLite")
workingdb <- dbConnect(sqlite, "simplecharter.sqlite")
dbListTables(workingdb)
results <- dbSendQuery(workingdb, "SELECT * FROM ALLCHARTERS")
resultsdf <- data.frame(fetch(results, -1))
dbDisconnect(workingdb)
#Part 2
library(MASS)
newdb <- dbConnect(sqlite, "newdb.sqlite")
dbWriteTable(newdb, "Boston", Boston)
dbDisconnect(newdb)