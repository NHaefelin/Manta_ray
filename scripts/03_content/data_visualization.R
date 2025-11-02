################################################################################
# Manta Movement Visualization
################################################################################
#
# Norina Haefelin
# nxh544@miami.edu
# 11/2/2025
#
# Visualizing manta ray movement/tracking data with two different visualizations
#
################################################################################
# SET UP #######################################################################

## Load packages ---------------------------------------------------------------

library(EVR628tools)
library(tidyverse)
library(mapview)
library(sf)
library(cowplot)

## Load data -------------------------------------------------------------------

manta_obs_per_site <- read_rds("data/processed/obs_per_manta_site.rds")

# VISUALIZE ####################################################################
#first graph showing number of manta observations for each 25 manta at each 4 sites
p1 <- ggplot(data = manta_obs_per_site,
       mapping = aes (x = locality, y= n_observations)) +
         geom_point() +
  labs(x = "Location",
       y = "Manta Observations",
       subtitle = "Number of Times Twenty-Five Mantas were Observed at Four Locations in Indonesia") +
  theme_minimal(base_size = 12)

#second graph showing total observations of manta at each 4 sites
p2 <- ggplot(data = manta_obs_per_site,
      mapping = aes(x = locality, y = n_observations)) +
  geom_col(fill = "blue") +
  labs(x = "Location",
       y = "Total Observed",
       subtitle = "Total Number of Manta Observed by Location",
       caption = "Data from DataBank Tracking") +
theme_minimal(base_size = 12)

#combining above two plots
my_plot <- plot_grid(p1, p2,
                     ncol = 1,
                     labels = c("A.", "B."),
                     label_size = 10,
                     rel_widths = c(.5, 1))

my_plot

#bonus interactive plot
plot(manta_obs_per_site, max.plot = 1)

mapview(manta_obs_per_site)

# EXPORT #######################################################################
ggsave(plot = my_plot, filename = "results/img/my_plot.png")
