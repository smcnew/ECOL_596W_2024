# ECOL 596W
# Week 8B: Practicing GLMs and LMMs and GLMMs
# Sabrina McNew
# Last modified: August 10, 2023

# Packages used (install as needed)
library(ggplot2)
library(ggthemr)
library(lmerTest) # for extracting p vals from mixed models
library(lme4) # mixed models
library(dplyr)

# datasets used
nestlings <- read.csv("datasets/nestlings.csv")
swallows <- read.csv("datasets/swallows.csv")

# optional set theme
ggthemr(palette = "flat dark", layout = "clean", text_size = 18)

# Question 1: In the swallows dataset, each row is a breeding female tree swallow
# and the columns tell you her brightness, which treatment she was in, her brood size,
# and her breeding success. There are two ways to consider breeding success:
# either as a binary "did she fledge any young or not?" encoded in the "success"
# column, or by considering the number of nestlings that lived and died per female
# ("nestlings_lived" and "nestlings_died" columns).
#
# 1a. Create a plot of the proportion of successful breeders in the predation
# group and in the control group.

swallows %>% group_by(treatment) %>%
  summarize(proportion = mean(success)) %>% ggplot(aes(x= treatment, y = proportion)) + geom_col()
head(swallows)
swallows %>% mutate(percent_fledge = nestlings_lived/brood_size) %>%
  group_by(treatment) %>% summarize(mean_fledge = mean(percent_fledge, na.rm=T)) %>%
  ggplot(aes(x = treatment, y = mean_fledge)) +geom_col()
# 1b. Create a plot of the overall percentage of nestlings that fledged in
# the predator and control groups.
#
# 1c. Use a generalized linear model (aka logistic regression) to test whether
# breeding success differed between predator and control groups using "success"
# as a response variable.
#
# 1d. Use a generalized linear model (aka logistic regression) to test whether
# the proportion of nestlings that fledged from each nest differed between
# treatments. How do you interpret the output?
#
# 1e. Use a generalized linear model to test whether the total number of
# offspring that females succesfully produced differed between treatment and control groups.
# What glm family should you use?
#
# 1f: Considering your approaches in 1c - 1e: what is the "best" way to answer
# the question: "Did predation affect breeding success of swallows?" Why?
#
#
# Question 2: You also have data from each nestling in this experiment in the
# "nestlings" dataframe, which includes measurements at 12 days of age of their
# mass and their wing length. You want to determine whether being in a "predation" or "control"
# treatment had an effect on individual nestling mass. So you set out
# to model the effect of treatment on nestling mass using lm(). "HOLD UP" your advisor says,
# that's pseudoreplication, because each nestling is not independent. "What you need
# to do is take the average mass for each nest and then model average mass based on treatment"
#"But," you say, "that will sacrifice a lot of power! Maybe there's another way..."
#
# 2a. Make a plot of mean mass for the predator and control treatments
#
# 2b. Make a lm that tests the effect of treatment on nestling size. How do you
# interpret the coefficients and p vals?

# 2c. Make a lmm that tests the effects of treatment on nestling size, properly
# accounting for the interdependence of nestlings within the same nest. (hint: lmer()).
# Compare and contrast the results of your lm and lmm. How do the coefficients and
# p values differ?

# Question 3: test for effects of treatment on individual nestling fledging success
# 3a: Make a plot showing the differences in percent fledging success for nestlings
# in the control vs. predator treatment
#
# 3b: Use a normal lm to model the effects of treatment on fledging success (yes this isn't the best approach).
# You'll first want to create a new vector that codes nestling fate as a numeric
# value. How do you interpret these coefficients? Do they make sense?
#
# 3c: Use a generalized linear model aka logistic regression (glm(family = "binomial)) to model the effect of
# treatment on nestling fledging success. How do you interpret the coefficients?
# Tip: R will not allow a character vector as a response in a logistic regression.
# however, it will take a 0 or 1 number, and it will take a vector encoded as a two-level factor
#
# 3d: Use a generalized linear mixed effects model to model the effect of
# treatment on nestling fledging success, accounting for the interdependence of nestlings.
# interpret these results. Compare the results of the lm, glm, and glmm.
#
# Question 4: The swallow nestlings were studied at 5 different sites, which
# varied in temperature, proximity to food sources, and overall quality. Site
# therefore may be an important random effect to consider in our analysis.
#
# 4a: Inspect nestlings$site. How many sites are there? How many nests were in
# each site? Make a plot of average nestling mass at each site. How does it vary?
#
# 4b: Create a plot of the relationship between wing length and mass, coloring
# points by site. Add a simple regression line for the points of each site on top
# of your graph.
#
# 4c: Model the relationship between wing length and mass using a simple lm
#
# 4d: Model the relationship between wing length and mass using the random effect
# of site.
#
# 4e: What other random effects should you consider? Experiment with adding the random
# effect of nest. How should you add it? For a nice explanation of nested vs.
# crossed random effects read here:
# https://stats.stackexchange.com/questions/228800/crossed-vs-nested-random-effects-how-do-they-differ-and-how-are-they-specified
#
#
# Bonus Challenges: repeatability
# Often you'll want to know what the variation is among samples taken from a
# particular blocking group. E.g. How much variation is there among your 3
# undergraduate observers in the way they quantify behavior? Or, how much variation
# was there between greenhouse replicates of a particular growth treatment?
# These analyses often fall under an umbrella of "repeatability" analyses
# and the logic behind them is very similar to running a mixed-effect model.
#
# A common package for repeatability is called rptR. Run through the vignette here
# and see what you think:
#
# https://cran.r-project.org/web/packages/rptR/vignettes/rptR.html