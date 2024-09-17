# Plot for Homework


library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
Small_sample_size <- read_csv("AP_fork_suggestion/Small_sample_size.csv")

Small_sample_size%>%
  filter(!is.na(scale)) %>%
  ggplot(aes(x = Species, y = Mass)) +
  geom_boxplot()

#fin