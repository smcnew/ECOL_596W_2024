# ECOL 596
# Week 3
# Advanced Data Wrangling

# Goals: understanding joins and reshaping of data.

# Packages ----------------------------------------------------------------
library(dslabs)
library(dplyr)

# Reshaping data ----------------------------------------------------------
# Refer to Irizarry ch. 11 for more info
# These exercises are modified from Irizarry 11.6

# 1. Create a test "wide" dataset.
# This is "wide" because months are spread out over 12 different columns.
co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) |>
  setNames(1:12) |>
  mutate(year = as.character(1959:1997))
head(co2_wide)

# What are the dimensions of your data frame?

#2. Reshape this dataset using pivot_longer() to wrangle this into "long" format.
# Name the new object "co2_tidy". Your new data frame should have three columns:
# year, month, and co2. What are the new dimensions of this data frame?

#3. Load the admissions data set which contains admissions information
#for men and women across six majors, keeping only the admitted number column.

dat <- admissions %>% select(-applicants)
head(dat)

# (Irizarry says this is "not tidy" because we want a row for each major. SMM note:
# I think whether or not a data set is "tidy" depends on your goals. So let's not get
# too hung up on that.)
# Pivot this wider so that we have columns "major," "admitted_men" and "admitted_women"


# Spicy reshaping (optional)
# 4. We want to wrangle the admissions data so that for each major we have 4 observations:
# admitted_men, admitted_women, applicants_men and applicants_women.
# The trick we perform here is actually quite common:
# first use pivot_longer to generate an intermediate data frame and then pivot_wider
# to obtain the tidy data we want.
#
# Note: now let's work with the admissions data directly
head(admissions)


# Joins -------------------------------------------------------------------
# Refer to Irizarry ch. 12 for more info
# https://rafalab.dfci.harvard.edu/dsbook-part-1/wrangling/joining-tables.html

# 5. Imagine you have another data frame of information about majors and
# their graduation rates. It looks like this

majors <- data.frame (major_code = c("A","B","C","D","E","F"),
                      major_name = c("Anthro", "Bio", "Chem", "Dentistry", "Econ", "French"),
                      grad_rate = c(79, 83, 40, 48, 55, 90))

head(majors)

# Now, we would like to add the information from "majors" onto the admissions
# df. We want the resulting data frame to have the same information as admissions
# but with the additional columns of the major name and graduation rate.
# Let's try just using left_join(). Note the data frame that we want to add stuff
# to comes first.

left_join(admissions, majors)

# Why did you get an error? Parse the error message.

# 6. Rename the column "major_code" in the df majors to be "major" instead

# 7. Now we have a *key* column that is common to both dfs that we can use
#to add the info from majors onto admissions. Find a way to verify that all
# the values in admissions$major are indeed found in major$major.

# 8. Try to join your dfs again. Before you assign the output, verify that
# the dimensions of the resulting data frame are the size that you expected.

# 9. Trouble shooting joins. Potential Problem #1: the values in your key
# column don't exactly match. Let's modify the majors df:

majors <- data.frame (major_code = c("A","B","C","D","E","G"),
                      major_name = c("Anthro", "Bio", "Chem", "Dentistry", "Econ", "Geol"),
                      grad_rate = c(79, 83, 40, 48, 55, 30)) %>%
                      rename(major = major_code)

# Which values overlap in the key columns and which do not?

# 10. If you add majors to admissions now, what will happen with the F major? Explain the result.

# 11.  Trouble shooting joins. Potential Problem #12: there are duplicate
# values in your key column. Let's modify the majors df:

majors <- data.frame (major_code = c("A","B","B","C","D","E","F"),
                      major_name = c("Anthro", "Bio", "Botany", "Chem", "Dentistry", "Econ", "French"),
                      grad_rate = c(79, 83, 46, 40, 48, 55, 80)) %>%
  rename(major = major_code)

# left join major and admissions again. What happened? What do you notice
# about the length of the resulting df?

