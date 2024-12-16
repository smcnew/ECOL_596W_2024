
### R script for analyzing location specific species diversity

#If you do not already have these packages downloaded, please do so before proceeding.
library(readr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(leaflet)
library(vegan)


#If you are having trouble with your packages not downloading properly (like I did) try the following:
#First try running each command separately rather than in chunks.

library(readr)

library(ggplot2)

library(tidyverse)

library(dplyr)

library(leaflet)

#Then depending on what error you are recieving you may need to update your R or download a package's dependencies. The following commands helped make sure the packages were downloaded and would run.

install.packages("devtools")
devtools::install_github("r-lib/conflicted")

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

library(dplyr)

install.packages('leaflet')

if (!requireNamespace("leaflet", quietly = TRUE)) {
  install.packages("leaflet")
}

library(leaflet)

install.packages("vegan")

library(vegan)


#Open and check data file
bat_data <- read.csv("raw_bat_collection_data_2024.csv", header = TRUE)
View(raw_bat_collection_data_2024)


#These are optional commands to check the structure, column names, and sample rows of the data. </summary>
str(bat_data_simple)
names(bat_data_simple)
head(bat_data_simple)

#View terms key
terms_key <- read_csv("terms_key.csv")
View(terms_key)

#View site information
site_info <- read_csv("site_info.csv")
View(site_info)

#Simplify raw metadata file
bat_data_simple = subset(bat_data, select = -c(county, team, permit, mass_g, forearm_mm, ear_mm, tragus_mm, Notes))
View(bat_data_simple)

### Species Richness Graph
#Summarize species counts by site
species_summary <- bat_data_simple %>%
  group_by(site, species) %>%
  summarise(count = n(), .groups = 'drop')
View(species_summary)

#Summarize total species richness by site
richness_by_site <- species_summary %>%
  group_by(site) %>%
  summarise(richness = n_distinct(species))
View(richness_by_site)

#Create bar plot for site richness
ggplot(richness_by_site, aes(x = site, y = richness)) +
  geom_col(fill = "darkgreen") +
  theme_minimal() +
  labs(title = "Species Richness by Site", x = "Site", y = "Number of Species")


### Species Density Map

#Split the GPS column into two seperate columns for latitude and longitude
bat_data_simple <- bat_data_simple %>%
  separate(GPS, into = c("latitude", "longitude"), sep = ", ", convert = TRUE)
View(bat_data_simple)

#Extract the coordinates for each site
site_coordinates <- bat_data_simple %>%
  select(site, latitude, longitude) %>%
  distinct()
View(site_coordinates)

#If you have issues involving duplicates of sites (like I did) try the following:
#Find which sites has multiple coordinates
duplicate_sites <- bat_data_simple %>%
  select(site, latitude, longitude) %>%
  distinct() %>%
  group_by(site) %>%
  summarise(coord_count = n()) %>%
  filter(coord_count > 1)
print(duplicate_sites)

#Average the latitude and longitude for sites with multiple coordinates (only doing this because I am sure the coordinates are the same for the duplicates)
site_coordinates <- bat_data_simple %>%
  select(site, latitude, longitude) %>%
  group_by(site) %>%
  summarise(
    latitude = mean(latitude, na.rm = TRUE),
    longitude = mean(longitude, na.rm = TRUE)
  )
View(site_coordinates)

#Add site coordinates to species summary data
  species_summary <- species_summary %>%
  left_join(site_coordinates, by = "site")
View(species_summary)

#Use the species summary count data to obtain total number of species per site
site_coordinates <- site_coordinates %>%
  left_join(species_summary %>%
              group_by(site) %>%
              summarise(total_species = n_distinct(species)),
            by = "site")
View(site_coordinates)

#### Create an Interactive Map with leaflet
#This R package is really cool as it allows you to make an interactive map of your data. Documentation Link: https://rstudio.github.io/leaflet/

leaflet(site_coordinates) %>%
  addTiles() %>%
  addCircleMarkers(
    ~longitude, ~latitude,
    radius = ~total_species * 2,
    popup = ~paste("Site:", site, "<br>", "Species Richness:", total_species),
    color = "blue",
    fillOpacity = 0.7
  ) %>%
  addLegend("bottomright", colors = "blue", labels = "Species Richness", title = "Legend")

###  Analysis of Variance (ANOVA) Test
#Test if species count varies by site
species_anova <- aov(count ~ site, data = species_summary)
summary(species_anova)

### Linear Model
#Fit a linear model for a specific species
#We work with Myotis bats so being able to estimate best locations to capture specific species would be ideal.
lm_result <- lm(count ~ latitude + longitude,
                data = subset(species_summary, species == "MYVE"))
summary(lm_result)

#Join species data with environmental data
species_env_data <- species_summary %>%
  left_join(site_info, by = "site")

#Fit a linear model for one species
lm_result <- lm(count ~ habitat + disturbance_level,
                data = subset(species_env_data, species == "MYVE"))
summary(lm_result)

### Canonical Correspondence Analysis (CCA)
#Create species matrix
species_matrix <- species_summary %>%
  pivot_wider(names_from = species, values_from = count, values_fill = 0) %>%
  column_to_rownames(var = "site")
View(species_matrix)

#Create environment matrix
env_matrix <- site_info %>%
  filter(site %in% rownames(species_matrix)) %>%
  column_to_rownames(var = "site")
View(env_matrix)

#Filter the data to ensure alignment between species and environmental data
species_matrix_filtered <- species_matrix[row.names(species_matrix) %in% row.names(env_matrix), ]
View(species_matrix_filtered)

env_data_filtered <- env_matrix[row.names(env_matrix) %in% row.names(species_matrix), ]
View(env_data_filtered)

#Perform Canonical Correspondence Analysis (CCA) on filtered data
cca_model_single_variable <- cca(species_matrix_filtered[1:3, -c(1, 2)] ~ disturbance_level, data = env_data_filtered[1:3, ])
summary(cca_model_single_variable)
plot(cca_model_single_variable, display = c("species", "sites"))

### Principle Component Aanalysis (PCA) Plot
#Run PCA on the species matrix (excluding non-species columns)
pca_result <- prcomp(species_matrix_filtered[, -c(1, 2)], scale. = TRUE)
summary(pca_result)
biplot(pca_result)


### BONUS FIGURES
#These were just for fun because I was curious.

#Do more male or females bats get caught?
#Group bat counts by sex
sex_summary <- bat_data_simple %>%
  group_by(sex) %>%
  summarise(count = n(), .groups = 'drop')
View(sex_summary)

#Create a bar plot for sex ratio
ggplot(sex_summary, aes(x = sex, y = count, fill = sex)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Female vs. Male Bat Captures", x = "Sex", y = "Number of Bats") +
  theme_minimal() +
  scale_fill_manual(values = c("pink", "blue"))

#What time do we tend to catch the most bats?
#Convert capture_time to POSIXct format
bat_data_simple$time <- as.POSIXct(bat_data_simple$time, format="%H:%M")
str(bat_data_simple$capture_time)

#Extract the hour of capture
bat_data_simple$capture_hour <- as.numeric(format(bat_data_simple$time, "%H"))
head(bat_data_simple$capture_hour)

#Summarise the counts of bat captures by hour
capture_counts_by_hour <- bat_data_simple %>%
  group_by(capture_hour) %>%
  summarise(capture_count = n(), .groups = 'drop')

#Create line plot
ggplot(capture_counts_by_hour, aes(x = capture_hour, y = capture_count)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  theme_minimal() +
  labs(title = "Bat Captures by Hour", x = "Hour of Capture", y = "Number of Captures")

#Which locations had the most Myotis species?
#Filter for Myotis
myotis_data <- bat_data_simple %>%
  filter(str_detect(species, "^MY"))

#Summarize the counts of Myotis by site
myotis_count_by_site <- myotis_data %>%
  group_by(site) %>%
  summarise(count = n(), .groups = 'drop')

#Sort the data to identify the sites with the most individuals
myotis_count_by_site_sorted <- myotis_count_by_site %>%
  arrange(desc(count))
View(myotis_count_by_site_sorted)

#Create a bar plot
ggplot(myotis_count_by_site_sorted, aes(x = reorder(site, count), y = count)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  coord_flip() +
  theme_minimal() +
  labs(
    title = "Number of Myotis Bats Captured by Site",
    x = "Site",
    y = "Number of Captures"
  )
