##########
# Lab 2! #
##########

#Begin by opening a new script file (file naming conventions)

## Loading data ##

#Let's go through and look at a help file.

?read.csv

#Now we are going to read a .csv file into R 
#as a data frame object.

getwd()
setwd("/Users/blarry/Dropbox/CAPPP 2019-2020")
democracy_data <- read.csv(file = "lab2_democracy.csv", 
                           header = TRUE, 
                           stringsAsFactors = FALSE, 
                           na.strings = ".")
class(democracy_data)
democracy_data 



# Way too big to ask it to print in the console. 
# We can click on the table icon in the Global Environment
# and it will open a new tab where we can look at our data 
# frame.
#alternately:

View(democracy_data)
# Beginning to explore our data: what do we have?

dim(democracy_data) #Gives number of rows and number of columns
names(democracy_data) #Gives variable names
summary(democracy_data) #Gives summary data on each variable
head(democracy_data) #Shows the top of the table
str(democracy_data) #Compactly displays the structure of the object

# How many countries and years are there in this data set?

?unique
year_list <- unique(democracy_data$YEAR)
?length
length(year_list)

country_list <- unique(democracy_data$CTYNAME)
length(country_list)

# Let's look at one particular variable: GDP

democracy_data$GDPW
mean(democracy_data$GDPW)
median(democracy_data$GDPW)
sd(democracy_data$GDPW)
min(democracy_data$GDPW)
max(democracy_data$GDPW)
quantile(democracy_data$GDPW)

?quantile
quantile(democracy_data$GDPW, .30)
quantile(democracy_data$GDPW, .30, .70) 
quantile(democracy_data$GDPW, probs = c(.30, .70)) 


## Visualizing GDP ##

# install.packages("ggplot2") But only do this if you need to
library("ggplot2")

GDP_plot <- ggplot(democracy_data, 
                   aes(x = GDPW)) + geom_histogram()
GDP_plot
GDP_plot + facet_wrap


##how do I pick fix my binwidth issue?
?stat_bin
##what changes if I make the bins bigger or smaller?

## Visualizing the relationship between education and GDP

ed_GDP_plot <- ggplot(democracy_data, aes(y = EDT, 
                           x = log(GDPW))) +
                      geom_point() +
                      geom_smooth()
ed_GDP_plot

ggsave(filename = "education_gdp.png", plot = ed_GDP_plot)

## Small Exercises 

# 1) Go complete the Datacamp intro lesson on ggplot2 -- just the free "Introduction":
# https://www.datacamp.com/courses/data-visualization-with-ggplot2-1

# 2) Create two new types of graphs based on this dataset.
# You can use any variable you want.
# You will perhaps find this cheatsheet on ggplot useful:
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# Remember: google is your friend! You can find lots of 
# examples of how to use ggplot online.
# Save each plot to your working directory as a .png file
# with the filenames: rodman_plot1.png and rodman_plot2.png
# (except replace my last name with yours) and email to me 
# along with your script file that contains your plot code
# before next week's lab.





