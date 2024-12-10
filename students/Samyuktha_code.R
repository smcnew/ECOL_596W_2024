# Code for Samyuktha
#
library(stringr)
library(dplyr)

got <- read.csv("datasets/gameOfThrones.csv")


# the grepl() function will tell us if a certain string contains a word, e.g. killed
# example, the first row includes "killed", but the subsequent 5 don't.
got$death_description %>% head
grepl("Killed", got$death_description, ignore.case = T) %>% head

# Then, I'd wrap it in a case_when function to add another column.
# The syntax of case_when is kind of confusing but it's a really handy
# function for adding columns based on the values of another column

got <- got %>%
  mutate(death_category = case_when(grepl("killed", death_description, ignore.case = T) ~ "murdered",
                                    grepl("decapit", death_description, ignore.case = T) ~ "murdered",
                                    grepl("strangle", death_description, ignore.case = T) ~ "murdered",
                                    grepl("stabbed", death_description, ignore.case = T) ~ "murdered",
                                    grepl("burn", death_description, ignore.case = T) ~ "murdered",
                                    grepl("hanged", death_description, ignore.case = T) ~ "murdered",
                                    grepl("poisoned", death_description, ignore.case = T) ~ "murdered",
                                    is.na(death_description) ~ "lived",
                                    .default = "other"))
head(got)



