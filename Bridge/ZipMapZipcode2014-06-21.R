require(ggplot2) #For pretty graphics
require(RColorBrewer)  # for brewer.pal(...) this helps make the pretty spectrum on the heatmap
require(zipcode) # lets us turn zipcodes into lat/long easily
require(maps) # I'm the map!
require(grid) # Needed for unit() function
## This R file creates a heat map using student zip codes
data(zipcode) # this turns the zipcode data into something thats readable.
map('usa') #'Merica!
all_states <- map_data('state') 
studentZips = c("07728", "47909", "10023", "49417", "11355", "22980", "20814", "11211", "07070", "10706", "10598", "97119", "80031", "22205", "11415", "10006", "49456", "55347", "24502", "11413", "94550") #Current zip codes from 2014-06-21

studentLongs <- sapply(1:length(studentZips), function(i) subset(zipcode, zip == studentZips[i])$longitude) #Vectorized: reads in student zips and spits out longitude
studentLats <- sapply(1:length(studentZips), function(i) subset(zipcode, zip == studentZips[i])$latitude) #see above but with lat
zipdf <- data.frame(Longitude = studentLongs, Latitude = studentLats)

theme_clean <- function(base_size = 12) { # Makes the map look clean and spiffy
  theme_grey(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0, "cm"),
      axis.ticks.margin = unit(0, "cm"),
      panel.margin = unit(0, "lines"),
      plot.margin = unit(c(0, 0, 0, 0), "lines"),
      complete = TRUE
    )
}

ggplot(zipdf, aes(x=Longitude, y=Latitude))+ # Sets x and y as long/lat
  geom_polygon(data=all_states, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ # Draws the map
  stat_density2d(aes(fill = ..level..), alpha=0.4, geom="polygon", contour=T)+ # Adds the heatmap
  scale_fill_gradientn(colours=rev(brewer.pal(7,"Spectral")))+ #Makes the heatmap scale with spectral (other color schemes are available), and allows up to 7 gradations
  geom_point(colour="red", fill="black", shape = 21, size=2)+ # This is kinda ugly but displays the information--These are the points the zips are located at
  xlim(-125,-65)+ # So we don't include alaska/hawaii
  ylim(25, 50)+ # See above
  coord_fixed()+ # Makes sure the points don't scale
  guides(fill = F)+ # Clean!
  theme_clean() # Cleaner!

