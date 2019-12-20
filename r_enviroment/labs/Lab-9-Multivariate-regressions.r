####################################################
# Multivariate Regression Analysis & Limits of OLS #
####################################################

library(ggplot2)
library(dplyr)
library(lindia) # install.packages, if needed

setwd("~/Documents/CAPPP/r_enviroment/labs/")
swiss <- read.csv(file = "swiss_data.csv",
         header = TRUE,
         stringsAsFactors = FALSE)

##no dice? run the following
swiss

"swiss <- swiss %>% rename(fertility = Fertility,
                          agriculture = Agriculture,
                          examination = Examination,
                          education = Education,
                          catholic = Catholic,
                          infant_mort = Infant.Mortality)"


# Same research question: does education impact fertility in Swiss provinces?

## Last week: bivariate model

basic_lm <- lm(fertility ~ education, data = swiss)
summary(basic_lm)
# Remind me: what's in the console now?
"
There is a significant negative relationship between education and fertility rate. 
"

## This week: multivariate model

# We can additional variables to this model, to "control" for their effect on the DV.
# In essence, we hold their effect constant, and then look at the remaining
# effect that the IV of interest has on the DV.

multiple_lm <- lm(fertility ~ education + agriculture + catholic + infant_mort, data = swiss)
summary(multiple_lm)

# What do we see? How can we talk about each variable?
# What happened to the intercept?
# What's happened to the R-squared value?
# How can we describe the output of this model?

## Assumptions and Limits of OLS

# What does "lm" stand for? 
# ASSUMPTION: relationship between DV and IV is linear
# How to check: scatter plot

ggplot(swiss, aes(x = education, y = fertility)) +
  geom_point() +
  theme_minimal() +
  labs(y = "Fertility Measure", x = "% Education Beyond Primary School") 

# ASSUMPTION: homoscedastic (residuals are equal across length of regression line)
# How to check: residual plot

ggplot(multiple_lm) + geom_point(aes(x = .fitted, y = .resid)) + 
                      geom_hline(yintercept = 0, color = "red")

# ASSUMPTION: normally distributed data in your dependent variable
# How to check: histogram

ggplot(swiss, aes(x = fertility)) +
  geom_histogram() +
  theme_minimal()

# Is a binary outcome variable (like voted/didn't vote)
# normally distributed?

# ASSUMPTION: independent and control variables aren't highly correlated
# How to check: correlation matrix on numeric variables

# Quick exercise: make a new data set called "swiss_cor" 
# that removes the dependent variable from swiss

swiss_cor <- swiss %>% select(-c(fertility, X))

swiss_cor
cor(swiss_cor)

# ASSUMPTION: no major outliers in the data (OLS is sensitive)
# How to check: Cook's distance

gg_cooksd(multiple_lm, label = TRUE, show.threshold = TRUE,
          threshold = "convention", scale.factor = 0.5)

# Overall: can we use OLS for this data?


