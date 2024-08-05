# ECOL 596 W
# Week 2 Exercises
# Levels: Medium-Spicy


# Medium ------------------------------------------------------------------

# Let's start by using the diamonds dataset in ggplot. This lists information
# on nearly 60,000 diamonds More info here: https://rpubs.com/Davo2812/1102821

diamonds <- diamonds
head(diamonds)

#1.  Create a scatterplot showing the relationship between carat (x) and price (y)

#2.  Interesting, there's some strange structure to the data.
# Add a color aesthetic to visualize other columns and identify one that also
# seems to have a strong relationship with carat x price

# 3. The majority (~75%) of diamonds are smaller than what size? Create a df
# called most_diamonds filtered just to include diamonds smaller than this size.

# 4. Using your subsetted dataframe, create three or four ways of displaying the
# price per diamond across different cut categories. Use your preferred method to display them as
# a single, multi-panel figure. Explain which method best displays the data
# and why.

# 5. Explain the difference between geom_bar and geom_col. Show an example
# of when you'd use each.

# 6. In data visualization it's pretty easy to display the relationship
# between two variables (i.e., we put one on the x axis and one on the y). Usually,
# we can visualize a third variable by adding a color aesthestic. However, beyond
# that it gets tricky. What is the best method you can come up with for showing
# the relationship between carat, color, clarity, and price for ideal diamonds?

# Let's assume you're trying to figure out how to shop for the biggest diamond
# at the lowest price.


# 7. Plot the relationship between carat and price for included (clarity == "I1") diamonds.
# Add a regression line.


# Spicy -------------------------------------------------------------------

# Are you a plotting master?
# Challenge yourself with a Tidy Tuesday Challenge
# https://github.com/rfordatascience/tidytuesday
# more examples/reading here
# https://towardsdatascience.com/explaining-my-favourite-tidytuesday-projects-e44bfe988813