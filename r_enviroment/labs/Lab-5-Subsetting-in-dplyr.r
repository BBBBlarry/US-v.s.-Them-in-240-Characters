#################
# Lab 3 - dplyr #
#################

#Today we will be learning the R package dplyr,
#which is part of a suite of packages created
#by Hadley Wickham known as the tidyverse

#Our goal is to learn how to subset and manipulate
#our data in a variety of useful ways.

install.packages("dplyr") #if needed
install.packages("gapminder") #if needed
install.packages("magrittr") #if needed
library("dplyr")
library("gapminder")
library("magrittr")

##Load the new dataset we'll be working with today

data()
data("gapminder")
glimpse(gapminder)  #another function that allows you
#to get a snapshot of your data

##################################
##Basic dplyr functions: "filter"
#Subset data row-wise

filter(gapminder, lifeExp == 80)
#Comma in dplyr is basically like an "&" operator
#Just prints, does not save
?filter

two_countries <- filter(gapminder, 
                        country == "Rwanda" | country == "Afghanistan")

two_countries
#The "|" operator is basically an "or"
#Not changing original gapminder object

##Alternative syntax for using dplyr

gapminder %>%
  filter(country == "Cambodia") 

#The "%>%" is called a "pipe operator" and it
#is basically a "then" command

#Using the pipe operator is the best-practices
#way of using dplyr and you always use it.

#################################
##Basic dplyr functions: "select"
#Subset the data on variables or columns

gapminder %>%
  select(year, lifeExp) %>%
  head(10)

#Have to think like a chain of operations
#What if I want life expectancy for each year of data on Cambodia?

gapminder %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)

#How would I get the populations of all Asian
#countries in 1977? Save to an object called "asia_pop"

asia_pop <- gapminder %>%
  filter(continent == "Asia", year == 1977) %>%
  select(country, pop)


asia_pop <- gapminder %>%
  filter(year == 1977, continent == "Asia") %>%
  select(country, pop)

View(asia_pop)

################################
##Basic dplyr functions: "mutate"
#Create new variables

new_gap <- gapminder %>%
  mutate(gdp = pop * gdpPercap)

summary(new_gap$gdp)
options(scipen=999)  #to revert back to scientific
#notion, set scipen=0

summary(new_gap$gdp)


################################
##Basic dplyr functions: "rename"
#Change the names of variables to something easy!

new_gap <- new_gap %>%
  rename(life_exp = lifeExp, #new name comes first
         gdp_percap = gdpPercap)


################################
##Basic dplyr functions: "summarize"

new_gap %>% 
  group_by(country) %>%
  summarize(avg_life_exp = mean(life_exp)) %>%
  arrange(avg_life_exp)


#Summarize can do lots of things! See "useful functions"
#in the "summarize" help file.
#It's especially powerful when combined with the last function for today...

################################
##Basic dplyr functions: "group_by"
#Groups info by variable value

#What if I want data by continent?

new_gap %>%
  group_by(continent) %>%
  summarize(avg_life_exp = mean(life_exp),
            n_countries = n_distinct(country),
            avg_gdp_percap = mean(gdp_percap))

#What if I want data by country on changes in life expectancy in a given time period?

life_exp_delta <- new_gap %>%
  filter(year > 1952, year < 1973) %>%
  filter(continent != "Oceania") %>%
  group_by(country) %>%
  summarize(min_life = min(life_exp),
            max_life = max(life_exp)) %>%
  mutate(delta_life = max_life - min_life) 

life_exp_delta
summary(life_exp_delta$delta_life)