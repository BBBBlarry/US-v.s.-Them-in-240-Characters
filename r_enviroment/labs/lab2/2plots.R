setwd("~/Documents/CAPPP/r_enviroment/labs/lab2")

library(ggplot2)


democracy_data <- read.csv(file = "~/Dropbox/CAPPP 2019-2020/lab2_democracy.csv", 
                           header = TRUE, 
                           stringsAsFactors = FALSE, 
                           na.strings = ".")

ggplot(data = democracy_data, aes(x = YEAR, y = GDPW)) + geom_point() + geom_smooth()
ggplot(data = democracy_data, aes(x = YEAR, y = GDPW)) + geom_bar(stat = "identity")
