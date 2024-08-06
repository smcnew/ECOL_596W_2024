# Sabrina's notes and examples for ECOL 596


# Libraries ---------------------------------------------------------------
library(ggplot2)
library(dplyr)

# Week 2 ------------------------------------------------------------------

# Let's load some data
finches <- read.csv("datasets/finch.csv")
table(finches$sex)

cat <- read.csv("~/Downloads/cjcarlson helminths master Data/pantheria.csv")
head(cat)
hist(cat$X8.1_AdultForearmLen_mm)

cat %>% ggplot(aes(x = X8.1_AdultForearmLen_mm)) + geom_histogram()
