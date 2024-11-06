# Put at the top of your script
library(tidyverse)
library(here)
library(dplyr)
library(janitor)
# --- We need this for the boxplot --- 
library(ggplot2)

source(here("functions", "cleaning.R")) 


# ---- The rest of your script ----
# ---- Save the clean data ----

penguins_raw <- read_csv(here("data", "penguins_raw.csv"))
                              
penguins_clean <- penguins_raw %>% 
                                clean_column_names() %>% 
                                remove_columns(c("comments", "delta")) %>%
                                shorten_species() %>% 
                                remove_empty_columns_rows() 

penguins_clean <- read_csv(here("data", "penguins_clean")) #this causes later code to not work for some reason

penguins_flippers <- select(penguins_clean, species, flipper_length_mm)
#saying find the columns with these names, and only select them

#getting rid of NAs
penguins_flippers <- penguins_clean %>%
  select(species, flipper_length_mm) %>%
  drop_na

#now running the code again

#allows species to be attached to a colour:
#added this below
species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

flipper_boxplot <- ggplot(
  data = penguins_flippers,
  aes(x = species,
      y = flipper_length_mm)) +
  geom_boxplot(
    aes(color = species),
    width = 0.3,
        show.legend = FALSE) +
      geom_jitter(aes(color = species),
                  alpha = 0.3,
                  show.legend = FALSE, position = position_jitter(width = 0.2, seed = 0)) +#width and seed makes the randomness reproducible
  scale_color_manual(values = species_colours) +
                    labs(x = "Penguin species",
                         y = "Flipper length (mm)")
                  
flipper_boxplot

#giving the function 2 things
plot_boxplot <- function(data, species_colours) {
  data <- data %>%
    drop_na(flipper_length_mm)
  
  
}  
  
  
  
                            