"
Homework 1
Blarry Wang

Collaboration with: 
  - Veronica
  - Kaley
  - Nikita
  - Kaisa
  - Batoul
  - Raina
  - Maha
"

library(gapminder)
library(dplyr)
library(ggplot2)

data(gapminder)

# Question 1
ID_list <- gapminder %>%
  mutate(ID_list = paste(country, year, sep = '_')) %>%
  select(ID_list) %>%
  distinct()

ID_list %>% count()
# There are 1704 unique IDs :))

# Question 2
pop_test <- gapminder %>%
  filter((continent == "Asia" | continent == "Africa") & (year < 1967 & year > 1952)) 
  
pop_test %>%
  summarize(mean = mean(pop), median = median(pop), minimum = min(pop), maximum = max(pop), diff = max(pop) - min(pop))

# Question 3
gapminder %>%
  filter(year >= 1972 & year <= 1977) %>%
  mutate(gdp = gdpPercap * pop) %>%
  group_by(country) %>%
  summarise(diff = max(gdp) - min(gdp)) %>%
  arrange(desc(diff))
# United States GDPchange of $724732708017

gapminder %>%
  filter(year >= 1972 & year <= 1977) %>%
  group_by(country) %>%
  summarise(diff = max(gdpPercap) - min(gdpPercap)) %>%
  arrange(desc(diff))
# Kuwait GDP per cap change of $50082

# Question 4
q4_res <- gapminder %>%
  group_by(continent, year) %>%
  summarise(meanGdpPercap = mean(gdpPercap)) 

View(q4_res)

# Question 5
" 
  This graph shows the mean GPD per capita over the years on each continent.
  This is helpful for looking at trends over each continent and compare relative values each year. 
"
ggplot(q4_res, aes(x = year, y = meanGdpPercap)) + 
  geom_point(aes(colour = continent)) + 
  geom_smooth(aes(colour = continent)) + 
  labs(x = "Year", y = "Mean GDP Per Capita ($)", 
     title = "Mean GDP (per capita) of each Continenet over Year") +
  theme(plot.title = element_text(hjust = 0.5)) 

# Question 6
" 
  This graph shows the mean GPD per capita over the years on each continent.
  This is helpful for looking at trends overall over year and the proportion of each continent's GDP compare to each other. 
"
ggplot(q4_res) + 
  geom_bar(aes(y = meanGdpPercap, x = year, fill = continent), stat = "identity") +
  scale_fill_manual(values=c("#49997c", "#1ebecd", "#027ab0", "#ae3918", "#d19c2f")) +
  labs(x = "Year", y = "Mean GDP Per Capita ($)", 
       title = "Mean GDP (per capita) of each Continenet over Year") +
  theme(plot.title = element_text(hjust = 0.5)) 



  
  
