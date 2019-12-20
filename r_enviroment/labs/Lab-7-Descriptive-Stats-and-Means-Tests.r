#############################################
# Descriptive Stats & Tests Between 2 Means #
#############################################

library("dplyr")
library("ggplot2")
data(mtcars)
head(mtcars)

# Quick reminders about your data: 
# One column for each ________.
# One row for each ________.

# We are trying to explain the differences in the values of 
# your dependent variable. In other words, what we are really 
# asking is the following: is the difference so large that we 
# should reject the notion that it was due to chance?"

# General research topic: gas mileage

mtcars %>% group_by(am) %>%       # 0 = auto; 1 = manual
           summarise(mean(mpg),
                     sd(mpg))

auto <- mtcars %>% filter(am == 0)
manual <- mtcars %>% filter(am == 1)

# But is this result really more robust than a coin flip?

# Research question: is there a statistically meaningful difference
# in gas mileage given transmission type?

# Overlaid histograms
ggplot(mtcars, aes(x = mpg, fill = factor(am))) +
  geom_histogram(binwidth = 2, alpha=.5, position="identity")

# Interleaved histograms
ggplot(mtcars, aes(x = mpg, fill = factor(am))) +
  geom_histogram(binwidth=1, position="dodge")

# Density plots
ggplot(mtcars, aes(x = mpg, colour = factor(am))) + 
  geom_density()

# Density plots with semi-transparent fill
ggplot(mtcars, aes(x = mpg, fill = factor(am))) + 
  geom_density(alpha=.3) 

# Density plot with means added
ggplot(mtcars, aes(x = mpg, fill = factor(am))) + 
  geom_density(alpha=.5) +
  geom_vline(xintercept = mean(auto$mpg), color = "red") +
  geom_vline(xintercept = mean(manual$mpg), color = "blue")

## Testing whether these differences are statistically significant

mean(manual$mpg) - mean(auto$mpg)

# Find the 95% confidence interval for the true difference of
# means in the population.

auto$mpg
manual$mpg

t.test(manual$mpg, auto$mpg)

# How confident are we that we can reject the null hypothesis
# that the two population means are, in fact, equal?

# What is our margin of error, with 95% confidence, around
# the difference in means?

# Questions from homework?
