#Adapted from data.carpentry

# Script Lesson 4
# Patrick Seed
# June 16, 2020


# First we're going to obtain some data
# We'll use another script to get the data that is called
# from here using 'source'
# 
# Why not just put all the code from the source in this script?
# 1) It is messy.  It will add a lot of additional code to 
# the top of this script and just be harded to follow the main 
# scripting that is the focus here
# 2) It is reusable. By creating scripts with functions and 
# code we want to use elsewhere, we can just refer to that script
# rather than copying and pasting it into every place we can it.
# 

source("./R/setup.R") # Note that this is a relative path for the R script referenced

surveys_complete <- read_csv(file = "Data/portal_data_joined.csv", col_types = cols()) %>% 
  drop_na(weight, hindfoot_length, sex) %>% 
  group_by(species_id) %>% 
  filter(n() >= 50) %>% 
  ungroup()

#Objectives

#> * Produce scatter plots, boxplots, and time series plots using ggplot.
#> * Set universal plot settings.
#> * Describe what faceting is and apply faceting in ggplot.
#> * Modify the aesthetics of an existing ggplot plot (including axis labels and color).
#> * Build complex and customized plots from data in a data frame.

library("tidyverse")

##### ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

ggplot(data = surveys_complete)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(size=3)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(size=3, color="red")

surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))

surveys_plot + 
    geom_point()

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, color = "blue")

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, aes(color = species_id))

surveys_plot+geom_point(alpha=0.1, aes(color=species_id))

surveys_more_plot<- surveys_plot + geom_point(alpha=0.1, aes(color=species_id))

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
    geom_point(alpha = 0.1)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
    geom_jitter(alpha = 0.1)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1, jitter=0.1)

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_point(aes(color = plot_type))

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_point(aes(color = plot_type))

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(aes(color = plot_type), alpha=0.1)

install.packages("hexbin")
library("hexbin")

surveys_plot +
  geom_hex()


ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_boxplot()

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
    geom_boxplot(alpha = 0) +
    geom_jitter(alpha = 0.3, color = "tomato")

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = .5) +
  geom_jitter(alpha = 0.3, color = "tomato")

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato")+
  geom_boxplot(alpha = .5) 

yearly_counts <- surveys_complete %>%
  count(year, genus)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
     geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = genus)) +
    geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = genus)) +
    geom_line()

ggplot(yearly_counts, aes(year, n, color=genus))+geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
    geom_line() +
    facet_wrap(facets = vars(genus))

yearly_sex_counts <- surveys_complete %>%
  count(year, genus, sex)

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line()

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets =  vars(genus))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~genus)

ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols =  vars(genus))

ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(sex~genus)

ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))

ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~genus, nrow = 1)

ggplot(data = yearly_sex_counts, 
        mapping = aes(x = year, y = n, color = sex)) +
     geom_line() +
     facet_wrap(~genus) +
     theme_bw()


ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~genus) +
  theme_classic()

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(vars(genus)) +
    labs(title = "Observed genera through time",
         x = "Year of observation",
         y = "Number of individuals") +
    theme_bw()

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(vars(genus)) +
    labs(title = "Observed genera through time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(text=element_text(size = 16))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(size=2, angle = 90))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(vars(genus)) +
    labs(title = "Observed genera through time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                        axis.text.y = element_text(colour = "grey20", size = 12),
          text = element_text(size = 16))

grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                          axis.text.y = element_text(colour = "grey20", size = 12),
                          text = element_text(size = 16))

ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
    geom_boxplot() +
    grey_theme

install.packages("patchwork")

library("patchwork")

spp_weight_boxplot <- ggplot(data = surveys_complete, 
                             mapping = aes(x = genus, y = weight)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(x = "Genus", y = "Weight (g)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

spp_count_plot <- ggplot(data = yearly_counts, 
                         mapping = aes(x = year, y = n, color = genus)) +
  geom_line() + 
  labs(x = "Year", y = "Abundance")

spp_weight_boxplot + spp_count_plot

spp_weight_boxplot / spp_count_plot

install.packages("cowplot")
library(cowplot)

plot_grid(spp_count_plot, spp_count_plot, nrow=1)

plot_grid(spp_count_plot, spp_count_plot, ncol=1)

plot_grid(spp_count_plot, spp_count_plot, nrow=1, labels = "auto")

plot_grid(spp_count_plot, spp_count_plot, nrow=1, labels = "AUTO")

plot_grid(spp_count_plot, spp_count_plot, nrow=1, labels = c(1,2))

plot_grid(spp_count_plot, spp_count_plot, nrow=1, labels = c("Fred", "George"))


my_plot <- ggplot(data = yearly_sex_counts, 
                  mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(vars(genus)) +
    labs(title = "Observed genera through time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                        axis.text.y = element_text(colour = "grey20", size = 12),
          text=element_text(size = 16))

ggsave("fig/yearly_sex_counts.png", my_plot, width = 15, height = 10)

my_plot
ggsave("fig/yearly_sex_counts.png", width = 15, height = 10)

install.packages("gridExtra")
library(gridExtra)

combo_plot <- grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))
combo_plot
ggsave("fig/combo_plot_abun_weight.png", combo_plot, width = 10, dpi = 300)
