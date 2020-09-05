# Title     : Data Wrangling
# Objective : Introduction to Data Wrangling with dplyr
# Created by: ruben
# Created on: 30/08/2020

# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr)

# Look at the gapminder dataset
gapminder

# Filter the gapminder dataset for the year 1957
gapminder %>%
  filter(year == "1957")

# Filter for China in 2002
gapminder %>%
  filter(country == "China" & year == "2002")

# Sort in ascending order of lifeExp
gapminder %>%
  arrange(lifeExp)


# Sort in descending order of lifeExp
gapminder %>%
  arrange(desc(lifeExp))

# Use mutate to change lifeExp to be in months
gapminder %>%
  mutate(lifeExp = 12 * lifeExp)

# Use mutate to create a new column called lifeExpMonths
gapminder %>%
  mutate(lifeExpMonths = 12 * lifeExp)

# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year == "2007") %>%
    mutate(lifeExpMonths = lifeExp * 12) %>%
      arrange(desc(lifeExpMonths))
