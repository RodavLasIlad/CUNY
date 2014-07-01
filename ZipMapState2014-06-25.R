library(ggplot2)
require(ggplot2) #For pretty graphics
require(RColorBrewer)  # for brewer.pal(...) this helps make the pretty spectrum on the heatmap
require(zipcode) # lets us turn zipcodes into lat/long easily
require(maps) # I'm the map!
require(grid) # Needed for unit() function
## This R file creates a heat map using student zip codes
data(zipcode) # this turns the zipcode data into something thats readable.
map('usa') #'Merica!
all_states <- map_data('state') 
studentZips = c("07728", "47909", "10023", "49417", "11355", "22980", "20814", "11211", "07070", "10706", "10598", "97119", "80031", "22205", "11415", "10006", "49456", "55347", "24502", "11413", "94550", "49424") #Current zip codes from 2014-06-21

studentLongs <- sapply(1:length(studentZips), function(i) subset(zipcode, zip == studentZips[i])$longitude) #Vectorized: reads in student zips and spits out longitude
studentLats <- sapply(1:length(studentZips), function(i) subset(zipcode, zip == studentZips[i])$latitude) #see above but with lat
zipdf <- data.frame(Longitude = studentLongs, Latitude = studentLats)
library(ggmap)
x <- get_map(location="United States", zoom=(3), maptype="terrain")

cols <- rev(colorRampPalette(brewer.pal(8, 'RdYlGn'))(100))
alpha <- seq.int(0.5, 0.95, length.out=100)
alpha <- exp(alpha^6-1)
cols2 <- addalpha(cols, alpha)
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
ggmap(x, extent="normal") + 
  stat_density2d(
    aes(x=Longitude, y=Latitude, fill = ..level.., alpha = ..level..),
    size = 1, bins = 10, geom="polygon", data = zipdf) +
  geom_point(data=zipdf, aes(x=Longitude, y=Latitude), color="red") +
  xlim(-125,-65) +
  ylim(25, 50) +
  scale_fill_gradient(low="red", high = "orange") +
  scale_alpha()+
  theme_clean()+
  theme(legend.position="none")+
  labs(title="Number of MSDA students residing in each state state")