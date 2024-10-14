###Create a branch in your forked-and-cloned class repo.
###Add the html file to the student_contributions/ folder. Submit a pull request to Sabrina (extra credit).

# load packages and data
library(dslabs)
library(dplyr)
library(ggplot2)
library(readr)
swallows <- read_csv("quiz/swallows.csv")
View(swallows)
brightness <- read_csv("quiz/brightness.csv")
View(brightness)


updated_swallows <- merge(swallows, brightness, by="nestbox")
View(updated_swallows)


#Each row is a nest.
#Nests were put into one of two treatments: simulated predation (predator), or control (control).
##Along with treatment you have the following columns:nest_fate = whether the nest fledged any young or whether they all died,
#brood = number of nestlings, n_fledged = number of nestlings that fledged
#Create a new column called prop_fledged that contains the proportion of nestlings that fledged from each nest.
###so i need n_fledged/brood ?? because I do not see a nest_fate column that is data from swallow_nestlings.csv

updated_swallows$prop_fledged <- updated_swallows$n_fledged / updated_swallows$brood
View (updated_swallows)
###The %>% is called piping. The pipe operator takes the output of one function and passes it as the first argument to the next function. This allows you to string together multiple operations in a clear, linear fashion.
mean_prop <- updated_swallows %>%
  group_by(treatment) %>%
  summarise(mean_prop_fledged = mean(prop_fledged, na.rm = TRUE))
print(mean_prop)

#Can also use nesting
mean_prop <- summarise(group_by(updated_swallows, treatment), mean_prop_fledged = mean(prop_fledged, na.rm = TRUE))
print(mean_prop)

# Create the mean_prop data frame ###NO STUPID CHATGPT THOUGHT THAT BUT REALLY THE NAMES OF THE VALUES WERE WRONG!!
mean_prop <- data.frame(
  treatment = c("control", "predator"),###WRONG
)

#Bar plot
ggplot(mean_prop, aes(x = treatment, y = mean_prop_fledged, fill = treatment)) +
  geom_bar(stat = "identity") +
  labs(title = "Fledging Success by Treatment",
       x = "Treatment",
       y = "Mean Proportion of Fledged Nestlings") +
  theme_minimal() +
  scale_fill_manual(values = c("Control" = "blue", "Predation" = "red")) +
  geom_text(aes(label = round(mean_prop_fledged, 2)), vjust = -0.5)

# Replace NA in brightness with the mean
mean_brightness <- mean(updated_swallows$brightness, na.rm = TRUE)
updated_swallows$brightness[is.na(updated_swallows$brightness)] <- mean_brightness

# Replace NA in prop_fledged with the mean
mean_prop_fledged <- mean(updated_swallows$prop_fledged, na.rm = TRUE)
updated_swallows$prop_fledged[is.na(updated_swallows$prop_fledged)] <- mean_prop_fledged

# Scatter plot with regression line
ggplot(updated_swallows, aes(x = brightness, y = prop_fledged, color = treatment)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Influence of Female Brightness on Fledging Success",
       x = "Female Brightness",
       y = "Proportion of Nestlings Fledged") +
  theme_minimal() +
  scale_color_manual(values = c("Control" = "blue", "Predation" = "red")) +
  theme(legend.title = element_blank())  # Remove legend title

#scale_color_manual(values = c("control" = "lightblue", "predator" = "orange")) +


unique(updated_swallows$treatment)
updated_swallows$treatment <- as.factor(updated_swallows$treatment)
updated_swallows <- updated_swallows %>% filter(!is.na(treatment))
scale_color_manual(values = c("control" = "lightblue", "predator" = "orange"))
# Check unique levels in treatment
unique(updated_swallows$treatment)

# Convert treatment to a factor if it’s not already
updated_swallows$treatment <- as.factor(updated_swallows$treatment)

# Optional: Filter out rows with NA in treatment
updated_swallows <- updated_swallows %>% filter(!is.na(treatment))

# Scatter plot with regression line
ggplot(updated_swallows, aes(x = brightness, y = prop_fledged, color = treatment)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(title = "Influence of Female Brightness on Fledging Success",
       x = "Female Brightness",
       y = "Proportion of Nestlings Fledged") +
  theme_minimal() +
  scale_color_manual(values = c("control" = "lightblue", "predator" = "orange")) +
  theme(legend.title = element_blank())
