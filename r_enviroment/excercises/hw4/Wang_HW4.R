library(ggplot2)
library(lindia)
library(tidyr)
library(dplyr)

setwd("~/Documents/CAPPP/r_enviroment/excercises/hw4")

democracy <- read.csv(file = "hw4_democracy.csv", header = TRUE,
                      stringsAsFactors = FALSE, na.strings = ".")


# Q1 
"
  I select CIVLIB as my dependent variable to study. 
  There were 128 rows including NA rows, and 101 rows without NA rows. 
"
democracy_1980_all <- democracy %>%
  filter(YEAR == 1980) 

democracy_1980 <- democracy %>%
  filter(YEAR == 1980) %>%
  drop_na()

democracy_1980_all %>% nrow()
democracy_1980 %>% nrow()

#Q3
democracy_1980 %>%
  ggplot(aes(x = GDPW, y = CIVLIB)) + 
  geom_point() + 
  labs(title="The Relationship between GPD Per Worker and the Level of Civil Liberties") + 
  xlab("Real GDP Per Worker ($)") + 
  ylab("Civil Liberty Score") + 
  theme_classic()

#Q4
civlib_lm <- lm(CIVLIB ~ GDPW + BRITCOL + EDT, data = democracy_1980)
summary(civlib_lm)

#Q5
ggplot(civlib_lm) + geom_point(aes(x = .fitted, y = .resid)) + 
  geom_hline(yintercept = 0, color = "red") + 
  labs(title="Residual Plot of the Linear Model") + 
  xlab("Fitted") + 
  ylab("Residual") + 
  theme_classic()

ggplot(democracy_1980, aes(x = CIVLIB)) +
  geom_histogram() +
  labs(title="Residual Plot of the Linear Model") + 
  xlab("Civil Liberty Score") + 
  ylab("Count") + 
  theme_classic()

democracy_1980_cor <- democracy_1980 %>% select(c(GDPW, BRITCOL, EDT)) 
cor(democracy_1980_cor)

gg_cooksd(civlib_lm, label = TRUE, show.threshold = TRUE,
          threshold = "convention", scale.factor = 0.5)


