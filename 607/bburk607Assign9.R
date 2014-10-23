library(rmongodb)
library(plyr)

mongo <- mongo.create()
# connecting to the database
if (mongo.is.connected(mongo) == TRUE){
  mongo.get.database.collections(mongo, db = "unitedstates")
}

alldata <- data.frame(stringsAsFactors = FALSE)
# setting the namespace
dbns <- "unitedstates.unitedstates"
# putting the cursor in the ns
cursor = mongo.find(mongo, dbns)
i <- 1


# converting mongo to list, then to df
while(mongo.cursor.next(cursor)) {
  tmp <- mongo.bson.to.list(mongo.cursor.value(cursor))
  tmp.df <- as.data.frame(t(unlist(tmp)), stringsAsFactors = F)
  alldata <- rbind.fill(alldata, tmp.df)
}

#removing the ids
alldata <- alldata[,-1]

#I initially tried to set up a function to do this, but it wasn't working properly (weird error) so I just did it with some copy and pastes
#I split each by the value I wanted (as there were nas in the other spots), converted them to data frames, then I removed all columns that only had nas
district <- split(alldata, alldata$federal_district)[[1]]
district <- district[,colSums(is.na(district))<nrow(district)]
# The only problem I saw was that washington dc retained the quotes from the original file
district["federal_district"] <- "Washington, D.C."
district

territories <- split(alldata, alldata$territory)
territories <- do.call(rbind.data.frame, territories)
territories <- territories[,colSums(is.na(territories))<nrow(territories)]
territories

states <- split(alldata, alldata$state)
states <- do.call(rbind.data.frame, states)
states <- states[,colSums(is.na(states))<nrow(states)]
states