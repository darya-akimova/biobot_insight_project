library(tidyverse)
library(viridis)
library(mgcv)

raw_town_data <- read_csv("../../clean_data/ma_death_count_w_coord.csv")
town_data <- raw_town_data %>%
  select(-X1) %>%
  gather(key="year", value="death_count", -c(town:y)) %>% 
  mutate(year = as.numeric(year))
town_data %>% 
  ggplot(aes(x, y, color=death_count)) +
  geom_point(size=2) +
  facet_wrap(~year)
copy_base_model <- gam(death_count ~ s(x, y) + s(year, k=2), data = town_data, family = poisson, method="REML")
town_data$model_fit <- predict(copy_base_model, town_data,type = "response")


ggplot(aes(x, y, color = model_fit), data = town_data) +
  geom_point() +
  facet_wrap(~year) +
  scale_color_viridis()
summary(copy_base_model)
  
