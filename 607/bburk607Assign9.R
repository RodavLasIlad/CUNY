library(rmongodb)
library(plyr)

mongo <- mongo.create()

if (mongo.is.connected(mongo) == TRUE){
  mongo.get.database.collections(mongo, db = "unitedstates")
}

alldata <- data.frame(stringsAsFactors = FALSE)
dbns <- "unitedstates.unitedstates"

cursor = mongo.find(mongo, dbns)
i <- 1

while(mongo.cursor.next(cursor)) {
  tmp <- mongo.bson.to.list(mongo.cursor.value(cursor))
  tmp.df <- as.data.frame(t(unlist(tmp)), stringsAsFactors = F)
  alldata <- rbind.fill(alldata, tmp.df)
}
alldata <- alldata[,-1]

district <- split(alldata, alldata$federal_district)[[1]]
district <- district[1,]
district <- district[,colSums(is.na(district))<nrow(district)]
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
