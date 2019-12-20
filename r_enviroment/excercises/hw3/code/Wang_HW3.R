# Q1
library(dplyr)
library(tidyr)
library(ggplot2)

data(anscombe)

#Q2
anscombe2 <- anscombe %>%
  # we need to keep the obervation number
  mutate(obs = row_number()) %>%
  # make a thin tabe to keep track of (obs, variable name + dataset name, value) mapping
  gather(variable_dataset, value, -obs) %>%
  # split variable name + dataset name into two columns
  separate(variable_dataset, c("variable", "dataset"), sep=1L) %>%
  # remap to (obs, dataset name, x value, y vcalue) 
  spread(variable, value) %>%
  # sort by dataset name then the obervation number
  arrange(dataset, obs)

# Q3.1
anscombe2 %>%
  group_by(dataset) %>%
  summarise(mean_x = mean(x), mean_y = mean(y), std_x = sd(x), std_y = sd(y))

# Q3.2
anscombe2 %>%
  group_by(dataset) %>%
  summarise(correlation = cor(x, y))

# Q3.3
# dataset 1: coef = 0.5001, p = 0.00217 
summary(lm(y ~ x, data = anscombe2 %>% filter(dataset == 1)))
# dataset 2: coef = 0.5001, p = 0.00218 
summary(lm(y ~ x, data = anscombe2 %>% filter(dataset == 2)))
# dataset 3: coef = 0.4997, p = 0.00218
summary(lm(y ~ x, data = anscombe2 %>% filter(dataset == 3)))
# dataset 4: coef = 0.4999, p = 0.00216
summary(lm(y ~ x, data = anscombe2 %>% filter(dataset == 4)))

# Q3.4
"
They look very similar. The means and std devs are exactly the same while the fitted lines
have very similiar coefs and p-values. 
"
anscombe2 %>%
  filter(dataset == 1) %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) + 
  labs(title = "Anscombe Dataset 1 x-y relationship") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) 

anscombe2 %>%
  filter(dataset == 2) %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) + 
  labs(title = "Anscombe Dataset 2 x-y relationship") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) 

anscombe2 %>%
  filter(dataset == 3) %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) + 
  labs(title = "Anscombe Dataset 3 x-y relationship") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) 

anscombe2 %>%
  filter(dataset == 4) %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = lm) + 
  labs(title = "Anscombe Dataset 4 x-y relationship") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) 


