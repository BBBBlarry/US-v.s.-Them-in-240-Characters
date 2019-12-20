#################################
# Bivariate Regression Analysis #
#################################

# Quick notes on replicability: install.packages()

library(ggplot2)
library(dplyr)
data(swiss)
head(swiss)

# Quick data clean up: rename

swiss <- swiss %>% rename(fertility = Fertility,
                          agriculture = Agriculture,
                          examination = Examination,
                          education = Education,
                          catholic = Catholic,
                          infant_mort = Infant.Mortality)

# Research question: what is the relationship between fertility and education?

ggplot(swiss, aes(x = education, y = fertility)) +
  geom_point() +
  theme_minimal() +
  labs(y = "Fertility Measure", x = "% Education Beyond Primary School") 

# Is there a negative or positive relationship between education
# and fertility? How strong is this relationship? What would "no
# relationship" look like visually?

### CORRELATION ###
# We can quantify this direction and strength by correlation:

swiss %>% summarise(cor(education, fertility))

# -Assumes linear relationship
# -Expresses linearity and direction, but not slope
# -Values range from -1 to 1
# -Correlation coefficient usually called r

# We can (and should!) test the significance of this finding -- i.e. we can
# see how confident we are that r *does not* equal 0.

cor.test(swiss$education, swiss$fertility, method = "pearson")

### BIVARIATE REGRESSION ###

# We can ask ggplot to plot an OLS regression line on top of our scatter.
# ALWAYS plot your data.

ggplot(swiss, aes(x = education, y = fertility)) + 
  geom_point() + 
  geom_smooth(method = lm) +
  theme_minimal()

# How does R draw this line? The clue is in the OLS (ordinary
# least squares). Minimizing summed squared distance of all
# points to a line.

basic_lm <- lm(fertility ~ education, data = swiss)
summary(basic_lm)

# Look at: 

# Sign of coefficient: negative or positive?

# P: is coefficient on your independent variable are really different from 0 
# (so the independent variables are having a genuine effect on your dependent 
# variable) or alternatively are any apparent differences from 0 just 
# due to random chance. 

# ***NOTE***: the size of the P value for a coefficient says nothing 
# about the size of the effect that variable is having on your dependent 
# variable - it is possible to have a highly significant result (very small 
# P-value) for a miniscule substantive effect.

# Coefficient here: if education goes up by 1 unit, change on fertility
# is -0.86 units. If education = 0, fertility = 79.6.

# In general, regression gives us:
# -Slope (substantive effect)
# -Statistical significance of the coefficients
# -Error estimates at various points along the line for whole regression
# -Prediction of the dependent variable values as a function of the 
# independent variable

# Important limits to when we can use OLS -- NOT on all data -- which
# we will dig into next week.

# % of variation in DV that is explained by IV

summary(basic_lm)$r.squared

# Finally, export this data as a .csv so you can use it next week in lab


write.csv(swiss, file = "swiss_data.csv")
