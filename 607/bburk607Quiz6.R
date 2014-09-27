# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

# install.packages("XML")
require(XML)
library(dplyr)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

##### 1. What type of data structure is bowlpool? 
class(bowlPool)
# A data frame

##### 2. Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below

theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)
# What is the type of variable returned in hvalues?
class(hvalues)
# A list

##### 3. Write R code that shows how many HTML tables are represented in hvalues
length(hvalues)

##### 4. Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe
theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL, which=1)
hvalues

##### 5. Modify the returned data frame so only the Last Name and Points columns are shown.
hvalues <- select(hvalues, get('Last Name'), Points)
hvalues

##### 6 Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  

# http://www.mountaindragon.com/html/tables2.htm

# 7 How many HTML tables does that page contain?
theNewURL <- "http://www.mountaindragon.com/html/tables2.htm"
nvalues <- readHTMLTable(theNewURL)
length(nvalues)
# 43

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.

# I primarily use Mozilla Firefox (in windows 8.1), and I usually use ctrl+u, but you can also 
# right click and click 'view page source' when trying to view a pages source