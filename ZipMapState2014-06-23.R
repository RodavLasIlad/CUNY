require(ggplot2) #For pretty graphics
require(RColorBrewer)  # for brewer.pal(...) this helps make the pretty spectrum on the heatmap
require(zipcode) # lets us turn zipcodes into lat/long easily
require(maps) # I'm the map!
require(grid) # Needed for unit() function
library(plyr)
## This R file creates a heat map
data(zipcode)
studentZips = c("07728", "47909", "10023", "49417", "11355", "22980", "20814", "11211", "07070", "10706", "10598", "97119", "80031", "22205", "11415", "10006", "49456", "55347", "24502", "11413", "94550", "49424")
map('usa')
studentStates <- data.frame(sapply(1:length(studentZips), function(i) tolower(state.name[match((subset(zipcode, zip == studentZips[i])$state), state.abb)]))) # converts the state abbreviation into it's name in lower case (needed to match it to the region in the map)
tss <- table(studentStates) # so we can get a count
ssdf <- data.frame(sapply(1:length(tss), function(i) names(tss)[i]), sapply(1:length(tss), function(i) tss[i])) #dataframe containing the count
names(ssdf) <- c("state", "studentCount")
statesMap <- map_data("state")
merged <- merge(x=statesMap, y=ssdf, by.x="region", by.y="state", all.x=TRUE) #left join in R
merged$studentCount[is.na(merged$studentCount)] <- 0 

theme_clean <- function(base_size = 12) { # Makes the map look clean and spiffy
  theme_grey(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      #panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0, "cm"),
      axis.ticks.margin = unit(0, "cm"),
      panel.margin = unit(0, "lines"),
      plot.margin = unit(c(0, 0, 0, 0), "lines"),
      complete = TRUE
    )
}

ggplot(statesMap, aes(map_id = region, fill=merged$studentCount, x=long, y=lat))+
  geom_map(map=statesMap)+
  #geom_polygon(data = map_data("state"), fill="white", color="black")+
  #
  scale_fill_gradient2(low="white", high="red", midpoint = 0, name="Students")+
  #
  coord_map("polyconic")+
  theme_clean()+
  labs(title="Number of MSDA students residing in each state state")