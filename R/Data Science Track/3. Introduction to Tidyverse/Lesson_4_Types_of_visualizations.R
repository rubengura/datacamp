# Title     : Types of visualizations
# Objective : Introduction to main visualization types with ggplot2
# Created by: ruben
# Created on: 31/08/2020

library(gapminder)
library(dplyr)
library(ggplot2)

# Line plots

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x=year, y=medianGdpPercap)) + geom_line() + expand_limits(y = 0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x=year, y=medianGdpPercap, color=continent)) + geom_line() + expand_limits(y = 0)


# Bar plots

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>%
  filter(year==1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(y=medianGdpPercap, x=continent)) + geom_col()

# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>%
  filter(year==1952, continent=='Oceania')

# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, aes(x=country, y=gdpPercap)) + geom_col()


# Histograms

gapminder_1952 <- gapminder %>%
  filter(year == 1952) %>%
  mutate(pop_by_mil = pop / 1000000)

# Create a histogram of population (pop_by_mil)
ggplot(gapminder_1952, aes(x=pop_by_mil)) + geom_histogram(bins=50)

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x=pop)) + geom_histogram(bins=50) + scale_x_log10()


# Box plots

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x=continent, y=gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("Comparing GDP per capita across continents")




