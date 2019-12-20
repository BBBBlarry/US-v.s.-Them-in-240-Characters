library(dplyr)
library(tidyr)
library(ggplot2)
library(gapminder)

# Q1
data(gapminder)
data <- gapminder

data <- data %>% mutate(
  "econ" = rep_len(c("IMF_loan", "WTO_member"), nrow(data)),
  "econ_value" = rep_len(c(0, 1, 1), nrow(data)))

data <- data %>% spread(econ, econ_value)
data <- data %>% select(-c(WTO_member, IMF_loan))


#Q2
titanic <- read.csv("./Desktop/CAPPP/r_enviroment/excercises/ex4/lab5_titanic.csv", header = TRUE, stringsAsFactors = FALSE)
stats <- titanic %>% group_by(survived) %>% 
  summarise(mean = mean(age), std = sd(age))
stats

titanic %>%
  ggplot() +
  geom_histogram(aes(age)) + 
  facet_wrap(~survived, ncol = 1) + 
  labs(title = "The Distribution of Age for People Who Survived and Died in the Titanic")
  
died <- titanic %>% filter(survived == 0)
lived <- titanic %>% filter(survived == 1)
diff <- mean(died$age) - mean(lived$age)

t.test(died$age, lived$age)

"
The p-value of there is a difference between the two age groups
is 0.07834. This fails to reject the null hypothesis, which means 
there is likely no difference between the two means. 

We are ~92% sure that we can reject the null.

Our confidence interval is (-0.1966269  3.6569075). The 
margin of error is +/-1.9267672. 

According to our data, there is probably not a relationship 
between age and whether they will survive. There is 92% chance 
that the fact we saw there is a difference is just a fluke.
"

#Q3
library(readstata13)
state_pol <- read.dta13("./Desktop/CAPPP/data/polarization/Shor & McCarthy/shor_mc.sta")
state_pol %>%
  filter(year == 2016) %>%
  ggplot(aes(h_diffs)) +
  geom_histogram(bins = 20) +
  labs(
    x = "House Difference", y = "Count", 
    title = "The Distribution of House Ideology Difference Amongst States") + 
  theme(plot.title = element_text(hjust = 0.5)) 

state_pol %>%
  filter(year == 2016 | year == 2014) %>%
  ggplot() +
  geom_histogram(aes(h_diffs, fill = factor(year)), position = "dodge") +
  labs(
    x = "House Difference", y = "Count", 
    title = "The Distribution of House Ideology Difference Amongst States") + 
  theme(plot.title = element_text(hjust = 0.5)) 

