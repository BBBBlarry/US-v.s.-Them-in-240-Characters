######################
# Additional ggplot2 #
######################

library(ggplot2)
library(gapminder)
data(gapminder)


# One variable

ggplot(gapminder, aes(x = gdpPercap)) + geom_histogram()

ggplot(gapminder, aes(x = year, y = gdpPercap)) +
                      geom_point()

ggplot(gapminder, aes(x = year, y = gdpPercap)) +
                      geom_point() +
                      geom_smooth()

# Two variables (i.e. plotting a relationship)

ggplot(gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point() +
  geom_smooth()

ggplot(gapminder, aes(x = continent, y = gdpPercap)) +
  geom_boxplot()

# Making prettier graphs: an introduction

plot1 <- ggplot(gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point(aes(colour = continent), size = .75) +
  geom_smooth(colour = "black") +
  theme_minimal(base_size = 14) +                       
  labs(x = "Life Expectancy", y = "GDP Per Capita", 
       title = "Relationship Between GDP (per capita) and Life Expectancy") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_colour_discrete(name = "Continent") +
  scale_y_continuous(breaks=c(30000, 60000, 90000),
                     labels=c("$30,000", "$60,000", "$90,000")) 
plot1

ggsave(filename = "lab4_plot.png", plot = plot1)

######################
# Cleaning Your Data #
######################

# Most of the data you acquire in the real world will be messy! Sad-but-true fact: 
# much of your data analysis time will be spent cleaning your data.

# Today we are learning another Hadley Wickham package called tidyr. It helps us
# put data into a "tidy" form. What is tidy data?

# 1. Each row is a observation.
# 2. Each column is a variable.
# (This data form is sometimes called "long".)

# In other words, all the data you've seen so far has been "tidy". Your data
# *must* be in a tidy format in order to analyze it.

library(tidyr) #install if needed
library(dplyr)

# Let's (manually) make a messy dataset that we want to use
# to study the change in population in Scandinavian countries:

messy <- data.frame(
  country = c("Sweden", "Norway", "Denmark"),
  pop_1980 = c(21, 30, 42),
  pop_1990 = c(28, 36, 47)
)

messy #what makes this dataset messy?

#There are three variables (country, year, and
#population) but only one is in a column.

#Here's another way this same data could be
#arranged: different, but still messy.

messy2 <- data.frame(
  year = c("1980", "1990"),
  Sweden = c(21, 28),
  Norway = c(30, 36),
  Denmark = c(42, 47)
)

messy2 #what's going on here?

# Mantra: each row should be one observation of your dependent variable.

# Let's make clean data!

clean <- messy %>%
  gather(year, population, pop_1980:pop_1990) 
  # 3 arguments: 1) key, 2) value, 3) variables to gather
  # It will return all other columns "as-is"

clean

# Great, except the "year" variable is now gibberishy -- all we need is a numeric value
# tidyr has a function called "separate" which works like Excel's "text-to-columns".
# (Again, as with most things, there's more than one way to do this.)

clean <- clean %>% 
  separate(year, c("junk", "year")) %>%
  select(country, year, population)

clean

# Each observation is a "country-year". This is the same format as the gapminder data
# that you've already seen, where each case was a "country-year".

head(gapminder)

# Let's work through cleaning up the other messy dataset, "messy2", getting it 
# into a tidy format using the function "gather".

messy2
messy2 %>% gather(country, population, Sweden:Denmark)

# There is another function, spread, which works basically as the inverse of gather

messy3 <- clean %>%
  mutate(temp_type = c(rep("min_temp", 4), rep("max_temp", 2))) %>%
  mutate(temp = c(12, 4, 7, 19, 88, 101))

messy3

# Here we want to give each type of temperature (minimum and maximum) its own
# column, since they represent two different variables.

messy3 %>% spread(temp_type, temp)
          # The first term here are the variable names, the second are the values

messy
clean_p <- messy %>% pivot_longer(-country, names_to = "year", values_to = "count", names_pattern = "pop_(.*)")
clean_p

messy2
clean_p <- messy2 %>% pivot_longer(-year, names_to = "country", values_to = "population")
clean_p


############################
# Additional tidyr Reading #
############################

# If you are looking to get clearer on what tidyr can do for you, I recommend the following:

# -Sections 2.2 and 2.3 of this online textbook on tidyr functions: http://garrettgman.github.io/tidying/

# -The "Tidying Messy Data" section -- the second half -- of this article by Hadley Wickham: http://tidyr.tidyverse.org/articles/tidy-data.html




