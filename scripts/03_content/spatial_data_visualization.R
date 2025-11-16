################################################################################
# Manta Ray Spatial Data Visualization
################################################################################
#
# Norina Haefelin
# nxh544@miami.edu
# 11/14/2025
#
# Visualizing spatial data of manta ray tracking in Indonesia
#
################################################################################
# SET UP #######################################################################

## Load packages ---------------------------------------------------------------
library(EVR628tools)
library(tidyverse)
library(mapview)
library(sf)
library(rnaturalearth)
library(terra)
library(ggspatial)
library(tidyterra)

## Load data -------------------------------------------------------------------
manta_obs_per_site <- read_rds("data/processed/obs_per_manta_site.rds")

reefs <- ne_download(scale = 10L, type = "reefs", category = "physical")

depth <- rast("data/raw/depth_raster.tif")

coast <- ne_countries(country = "Indonesia")

# Wrangling data

indonesia_depth <- crop(depth, manta_obs_per_site)
indonesia_coast <- st_crop(coast, manta_obs_per_site)

# VISUALIZE ####################################################################

plot(manta_obs_per_site, max.plot = 1)

plot(reefs, max.plot = 1)

plot(depth)

plot(coast, max.plot = 1)

mapview(list(manta_obs_per_site, coast, reefs))

# Final Plot
p1 <- ggplot() +
  geom_spatraster_contour(data = indonesia_depth,
                          aes(colour = after_stat(level)),
                          linewidth = 0.5) +
  geom_sf(data = manta_obs_per_site, color = "red") +
  geom_sf(data = indonesia_coast, fill = "darkgrey", color = "purple") +
  scale_color_viridis_c(option = "mako") +
  annotation_north_arrow(location = "tr", pad_x = unit(.0001, "in"),
        pad_y = unit(.0001, "in")) +
  annotation_scale(location = "br") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(1, 1, 1, 1), "in")) +
  coord_sf(clip = "off") +
  theme_classic() +
  labs(title = "Manta Ray Tracking data in Indonesia",
       subtitle = "Analysis of Manta Ray Abundance to Depth",
       x = "Longitutde",
       y = "Latitude",
       color = "Depth (m)",
       caption = "Data: MoveBank Tracking Data")

# Export

ggsave(plot = p1,
       filename = "results/img/my_map.png")
