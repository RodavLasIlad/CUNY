library(ggplot2)
library(grid)
library(gridExtra)

##### Loading in the data #####
# I realize it's already built in, but I wasn't sure if we were supposed to load it from the site, so I did anyway.
setwd("C:\\Users\\Brett\\Dropbox\\CUNY\\607")
m <- read.table("movies.tab", sep="\t", header=TRUE, quote="", comment="")

##### Question 1 #####
# Grouping by decade (as factors for easy graphing):
m$decade <- as.factor((m$year %/% 10) * 10)
ggplot(data = m, aes(x=decade)) + 
  geom_bar(binwidth=10, position="dodge") + 
  xlab("Decade") + 
  ylab("Movies") +
  ggtitle("Movies made in each decade")
  
###### Question 2 #####
# Setting zeroes to NAs for easier calculating of the mean
m[,c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")][m[,c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")] == 0] <- NA

Get.Ratings <- function(df){
  # Finds the means of the different Genres, removing the NAs (which were previously zeroes)
  Ratings <- c(mean(df$Action * df$rating, na.rm=T), 
              mean(df$Animation * df$rating, na.rm=T), 
              mean(df$Comedy * df$rating, na.rm=T), 
              mean(df$Drama * df$rating, na.rm=T), 
              mean(df$Documentary * df$rating, na.rm=T), 
              mean(df$Romance * df$rating, na.rm=T), 
              mean(df$Short * df$rating, na.rm=T))
  return (t(Ratings))
}

ratings.over.time <- data.frame(numeric(0), numeric(0), numeric(0), numeric(0), numeric(0), numeric(0), numeric(0), numeric(0))
overall.avg <- Get.Ratings(m)
for (i in 1:(length(levels(m$decade)))){
  # This could be vectorized, but this works quickly
  ratings.over.time <- rbind(ratings.over.time, c(as.numeric(levels(m$decade)[i]), Get.Ratings(subset(m, decade==levels(m$decade)[i]))))
}
names(ratings.over.time) <- c("Decade", "Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")

# Plotting all in one graph:
ggplot(data=ratings.over.time, aes(Decade)) + 
  geom_line(aes(y=Action, col="Action"), size=1.5) + 
  geom_line(aes(y=Animation, col="Animation"), size=1.5) + 
  geom_line(aes(y=Comedy, col="Comedy"), size=1.5) + 
  geom_line(aes(y=Drama, col="Drama"), size=1.5) + 
  geom_line(aes(y=Documentary, col="Documentary"), size=1.5) + 
  geom_line(aes(y=Romance, col="Romance"), size=1.5) + 
  geom_line(aes(y=Short, col="Short"), size=1.5) +
  ggtitle("Ratings over Time") +
  ylab("Average rating") + 
  theme(legend.title=element_blank())

# Plotting them seperately With the red line as the mean rating for the genre over all time
action.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Action, col="Action"), color="Black") + geom_line(y=overall.avg[1], color="Red")
animation.plot <- ggplot(data=ratings.over.time, aes(Decade)) +  geom_line(aes(y=Animation, col="Animation"), color="Black") + geom_line(y=overall.avg[2], color="Red")
comedy.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Comedy, col="Comedy"), color="Black") + geom_line(y=overall.avg[3], color="Red")
drama.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Drama, col="Drama"), color="Black") + geom_line(y=overall.avg[4], color="Red")
documentary.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Documentary, col="Documentary"), color="Black") + geom_line(y=overall.avg[5], color="Red")
romance.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Romance, col="Romance"), color="Black") + geom_line(y=overall.avg[6], color="Red")
short.plot <- ggplot(data=ratings.over.time, aes(Decade)) + geom_line(aes(y=Short, col="Short"), color="Black") + geom_line(y=overall.avg[7], color="Red")

grid.arrange(action.plot, animation.plot, comedy.plot, drama.plot, documentary.plot, romance.plot, short.plot, ncol=3)

##### Answer to question 2 #####
# The average ratings of the different genres have indeed changed over time

##### Question 3 #####
cor(m$length, m$rating)
# The longer a movie is, the worse the rating

# Quickly removing some outliers
m.short <- m[m$length < 500,]
ggplot(data=m.short, aes(x=length, y=jitter(rating))) + geom_point() + geom_smooth(method=lm)
ggplot(data=m.short, aes(x=length, y=jitter(rating))) + geom_point() + geom_smooth()
#Seems like movies would do well to add a few minutes so that they're at 100, or cut a few to be less than 50

##### Question 4 #####
# Please ignore the rather strange color choices, I was having fun going through the options
# Removing the outliers
ggplot(data=m) + 
  geom_boxplot(aes(x="Action", y=length[m$Action == 1]), outlier.shape = NA, fill="coral3") + 
  geom_boxplot(aes(x="Animation", y=length[m$Animation == 1]), outlier.shape = NA, fill="chartreuse4") + 
  geom_boxplot(aes(x="Comedy", y=length[m$Comedy == 1]), outlier.shape = NA, fill="darkslategray") + 
  geom_boxplot(aes(x="Drama", y=length[m$Drama == 1]), outlier.shape = NA, fill="royalblue3") + 
  geom_boxplot(aes(x="Documentary", y=length[m$Documentary == 1]), outlier.shape = NA, fill="darkolivegreen1") + 
  geom_boxplot(aes(x="Romance", y=length[m$Romance == 1]), outlier.shape = NA, fill="purple3") + 
  geom_boxplot(aes(x="Short", y=length[m$Short == 1]), outlier.shape = NA, fill="firebrick3") +
  ylim(0, 175) +
  xlab("Genre") +
  ylab("Length (in minutes)") +
  ggtitle("Average length of movie by genre")
# There does appear to be a relationship between movie length and genre--documentaries cover a large range, short films and animations are significantly shorter on average, etc.

##### Question 5 #####
# I am not including the rating percentiles (r1, r2, etc.), as I'm not sure how that would help measure the votes.
year.plot <- ggplot(data=m, aes(x=votes)) + geom_smooth(aes(y=year), col="coral3")
length.plot <- ggplot(data=m, aes(x=votes)) + geom_smooth(aes(y=length), col="chartreuse4")
rating.plot <-  ggplot(data=m, aes(x=votes)) + geom_smooth(aes(y=rating), col="royalblue3")
budget.plot <-  ggplot(data=m, aes(x=votes)) + geom_smooth(aes(y=budget), col="purple3")
decade.plot  <- ggplot(data=m, aes(x=votes)) +   geom_smooth(aes(y=as.numeric(decade)), col="firebrick3")
mpaa.plot <- ggplot(data=m, aes(y=votes, x=mpaa)) + geom_boxplot()

grid.arrange(year.plot, length.plot, rating.plot, budget.plot, decade.plot, mpaa.plot)

# Unsurprisingly budget seems to have the most dramatic effect on the amount of votes