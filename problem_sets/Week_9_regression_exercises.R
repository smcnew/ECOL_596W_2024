# ECOL 596W
# Week 7B: Regression practice
# Made by: Sabrina McNew
# Last modified: August 8, 2023

# Package installation, if you don't already have them
# install.packages("palmerpenguins", "ggplot2", "tidyr", "dplyr", "devtools", "emmeans")
# devtools::install_github('Mikata-Project/ggthemr')

library(ggplot2)
library(ggthemr)
library(tidyr)
library(palmerpenguins)
library(emmeans)
library(dplyr) #load last to avoid conflicts between packages

# Set graphing parameters (optional), see ggthemr website for options
# ggthemr(palette = "grape", layout = "clean", text_size = 22)

# Load data:
penguins <- penguins

# Data wrangling: Inspect your data frame, get to know the variables.
# One issue that pops out: there are two rows with no morphological info.
# Let's filter those rows out (hint: use the ! operator to negate a filter condition)
filter(penguins, is.na(flipper_length_mm))

# Problem 1: What is the relationship between flipper length and body size
# in penguins?
# 1a: Create a plot showing this relationship
#
# 1b: What is the correlation coefficient between these variables? Hint: use cor()
# and read the help page about arguments to deal with missing values
#
# 1c: Create a linear model and send it to an object (e.g. mod1 <- lm(...))

# 1d: Is body mass significantly associated with flipper length?
#
# 1e: Let's put this model to work. Say you catch a 4000 gram penguin. How long
# do you think it's flipper will be? Calculate the value using the model coeffs.
# what is the equation of the model line?
#
head(penguins)

lm1 <- lm(body_mass_g ~ flipper_length_mm, data = penguins)
lm1 <- lm(flipper_length_mm ~ body_mass_g, data = penguins)
lm1$coefficients

(0.01527592  * 4000 ) + 136
summary(lm1)
#1f: R will also calculated predicted values of Y for us, using the predict()
# function. Read the documentation of this function and try to figure out how it works.
# Use predict() to predict the ys for a set of four penguins with mass (2120,
# 5780, 4700, and 8001)
#
# 1g: What is the r squared value of your model? How do you interpret this value?
# How is this value related to the correlation coefficient?
#
# 1h: Inspect your residuals. What do you see in the model output?
# What do you see if you look at the qqplot of residuals? (e.g. plot(mod1))
#
# 1i: Let's compare our predicted y values (from the model) to our real y values
# First, create a vector of predicted ys called "predicted_flipper" and add
# it to your data frame (use the predict() function). Then, create a scatter plot
# where the x is the true flipper length and y is the predicted flipper length.
# Finally, add a 1:1 line using geom_abline(intercept = 0, slope = 1).
# How do you interpret this graph?
#
# 1h: What happens if you scale the x variable in your plot and lm? (e.g. use scale())
# How does this change your plot? How does this change your model output?
# Why would scaling help interpretation in this case?
#
# Problem 2: Body size of penguins may also vary between sexes. Create a boxplot
# to look at mass of males and females of the three species.
#
# 2a: Annoying! there are NAs here too. Potentially juveniles? Find a way to
# filter them out.
#
# 2b: Create a linear model testing for differences in mass between males and females
# (without separating species). Create a separate linear model testing for differences
# in mass between species. What are the results of these models? How do you interpret their outputs?
#
# 2c: Create a multiple regression model that includes both the effects of sex
# and species on body mass. What is the R squared value of this model compared to the
# single variable regression models? How do you interpret these coefficients?
#
# 2d: Use the emmeans::emmeans() and emmeans::pairs() functions to do post-hoc
# comparisons between groups. Emmeans is a big package with a lot of options,
# consult a couple of help pages to orient yourself to things you can do with it.
#
# e.g. https://aosmith.rbind.io/2019/03/25/getting-started-with-emmeans/
# https://cran.r-project.org/web/packages/emmeans/vignettes/comparisons.html

# Problem 3: Adelie penguins were sampled on three different islands. Does the
# size of Adelies differ significantly among islands? Create plots and lm
# to answer this question. Interpret the coefficients in your lm output
#
#
#
# Problem 4: Create a new dataset called penguins2 that does not have Adelie penguins.
# Say you want to test whether the mass of gentoo penguins is significantly
# different from that of chinstrap penguins. Use a t.test and a lm to answer
# this question. Compare the output. Where is the output of the tests similar?
# Where is it different?
#
#
# Hot tip: Download sjPlot and use tab_model() for easier formatting of model outputs
# install.packages("sjPlot")
# library(sjPlot)
# lm(body_mass_g ~ sex, penguins) %>% tab_model()
#
# Additional problems:
# Suave: https://whitlockschluter3e.zoology.ubc.ca/RLabs/R_tutorial_Correlation_Regression.html
# Picante: http://rafalab.dfci.harvard.edu/dsbook/linear-models.html Ch. 18
