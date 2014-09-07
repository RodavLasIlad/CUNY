##### Loading in the data #####
library(ggplot2)
setwd("C:\\Users\\Brett\\Dropbox\\CUNY\\608")
df <- read.csv("inc5000_data.csv")

df$State <- factor(df$State, levels=rev(levels(df$State)))
###### Plot 1 #####
png(filename="assign1_plot1.png")
ggplot(df, aes(factor(State))) + geom_histogram() + xlab("State") + ylab("Total Companies Residing") + ggtitle("5,000 Fastest Growing Companies in the US") + coord_flip()
dev.off()
ny <-subset(df[complete.cases(df),], State=='NY')
##### Detects the outliers #####
is.outlier<-with(ny, ave(Employees, Industry, FUN=function(x) {
  st<-boxplot.stats(x)$stats
  x < st[1] | x > st[5]
}))
##### Removes the outliers #####
ny <- ny[!is.outlier, ]
##### Plot 2 #####
png(filename="assign1_plot2.png")
ggplot(ny, aes(x=factor(Industry), y=Employees)) + 
  geom_boxplot(outlier.size=0) + # As it would be nearly impossible to constantly remove all outliers, I've made the few that were generated in the new set invisible
  ylim(0, 950) + # Scaled it down after removing outliers
  xlab("Industry") + 
  ggtitle("Employees in NY by Industry") + 
  coord_flip() # Setting it on the same axis as the original
dev.off()


nyr <-subset(df[complete.cases(df),], State=='NY')
nyr$profit.per.employee <- nyr$Revenue / nyr$Employees
##### Plot 3 #####
png(filename="assign1_plot3.png")
ggplot(nyr, aes(x=factor(Industry), y=profit.per.employee)) + 
  geom_boxplot(outlier.size=0) + 
  ylim(0,1000000) +
  xlab("Industry") +
  ylab("Profit per Employee") +
  ggtitle("Total Profit as a function of Employees") +
  coord_flip()
dev.off()