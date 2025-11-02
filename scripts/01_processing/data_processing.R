################################################################################
# Manta Ray Analysis
################################################################################
#
# Norina Haefelin
# nxh544@miami.edu
# 10/09/2025
#
# Analyzing manta ray movements in Indonesia across time
#
################################################################################

# SET UP #######################################################################

## Load packages ---------------------------------------------------------------

library(EVR628tools)
library(tidyverse)
library(janitor)
library(sf)
library(mapview)


## Load data -------------------------------------------------------------------
manta_data <- read_csv(file = "data/raw/Reef manta ray (Mobula alfredi) home range in Indonesia-gps.csv")

# PROCESSING ###################################################################

# how many individual organism manta rays per site and how many observations per manta ray
# using group by and summarize by

# Understanding and cleaning the data

dim (manta_data)
colnames(manta_data)

#individuals per site
individuals_per_site <- manta_data |>
  select(- `sensor-type`) |>
  group_by(`individual-local-identifier`, locality) |>
  summarize()

#how many individual manta rays per site with distinct n
manta_per_site <- manta_data |>
  group_by(locality) |>
  summarize(n_individuals = n_distinct(`individual-local-identifier`))

#Observations per manta not including site
obs_per_manta <- manta_data |>
  group_by(`individual-local-identifier`) |>
  summarize(n_observations = n())

#Observations per manta per site
obs_per_manta_site <- manta_data |>
  st_as_sf(coords = c("location-long" , "location-lat") , crs = "EPSG:4326") |>
  group_by(locality, `individual-local-identifier`) |>
  summarize(n_observations = n(), do_union = FALSE,
            .groups = "drop") |>
  st_cast("LINESTRING")

plot(obs_per_manta_site, max.plot = 1)

mapview(obs_per_manta_site)

#summary - there is 25 distinct manta data at 3 distinct sites


# EXPORT #######################################################################

## The final step --------------------------------------------------------------
write_rds(obs_per_manta_site, "data/processed/obs_per_manta_site.rds")



