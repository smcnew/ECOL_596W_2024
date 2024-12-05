# ECOL 596W
# Week 2 datasets
# Medium-Spicy



# libraries ---------------------------------------------------------------
library(dslabs)
library(dplyr)


# data --------------------------------------------------------------------

murders <- murders

# problems ----------------------------------------------------------------

# 1. Calculate the mean and sd murder rates per 100k people
# for each region using only base R

# 2. Calculate the mean and sd murder rates for each region using tidy/dplyr syntax

# 3. BASE R: filter the murders dataset to only include states with murder
# rates in the top 25% percentile (high murder states). Produce a data frame with
# just the state, population, and rate, sorted from largest to smallest pop.

# 4. Dplyr: filter the murders dataset to only include states with murder
# rates in the top 25% percentile (high murder states). Produce a data frame with
# just the state, population, and rate, sorted from largest to smallest pop.

# 5. Add a column in the murders dataset that creates categories of
# low, medium, high, and very high murders. Describe how you came up
# with reasonable categorization.

# 6. Simulate some data. Create a data frame with some data from a hypothetical
# experiment. Your data should include three treatments, A, B, and C, each with
# 50 individuals per treatment. The mean height of plants in group C is 50 cm,
# the plants in Group B are on average 5 cm taller than those in group C, and the plants
# in group A are on average 3 cm taller than group B, but have a higher variance.

# 7. Calculate the mean and standard variation of heights for each of your three groups
# and verify they match the simulated estimates.
# Base R

# 8. Add a column to your data called "combined group" where all individuals in
# treatment "C" are called "control" and all individuals in treatments A and B
# are lumped into a "fertilizer" category. Use case_when()

# 9. Find a way to verify that your treatment and combined group columns coincide correctly

# 10. Add a column called abbreviated "lll" that stands for "longest leaf length."
# The values in this column should be drawn from a normal distribution with mean of 5
# and sd of .6 and the values do not depend on treatment

# 11. Use across () to scale the height and lll columns. What does scale() do?
# Read the documentation.

# 12. You realized that the undergrad who entered the second half of this
# experiment's data into excel used a combination of upper and lower case
# for treatment ("As" and "as" and "fertilizer" and "Fertilizer"). Use
# across() and tolower() to mutate all the character columns to lowercase.

# 13. You have a list of sample names stored as a character vector.
# Split them up based on the "_" delimiter and store the results in a data
# frame that has a sample column (numeric) and a date column (character)
# Use the package stringr, the function str_split(), and the function sapply().
# Need a hint? Scroll to the bottom.

library(stringr)
sample_names <- c("254_july-12", "4850_july-12", "128_july-14", "472_july-15")

# 14. Still at it? Learn to use purrr. Read/do Irizarry 4.9

# 15. Still want more? Find someone in class who's new to R and lend your
# R wizardry skills to help them through the exercises.
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# Hints for problem 13:
# 1. Start by using stringr::str_split()
# 2. Save the output and check the structure. Weird, it's a list!
# 3. Figure out how to use the [] and [[]] to access items in a list
# 4. Read up on sapply/lapply() and figure out how they work

# 4