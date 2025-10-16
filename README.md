## Manta_ray
# Manta ray tracking analysis

The purpose of the present data set is to analyze Manta ray movements across various 
areas in Indonesia to analyze difference in movements. Originally wanted to view 
movement across time, but right now unsure how to incorporate long/lat and timestamp.

All data collected by MoveBank.

File includes: Event ID, Visible, Timestamp, location-longitude, lcoation-latitude
locality, sensory-type, individual taxon name, tag local identififer, individual local
identifier, and study name.This all saved as raw data as manta_data. 

25 Individual manta rays tracked with 2,960 total observations across 3 different sites.

Clean data used includes:
individuals_per_site - 25 observations with 2 variables - describes which individual
was seen at which site grouped by their ID and 1 of 3 sites.
Column names: individual-local-identifier, locality

manta_per_site - 4 observations with 2 variables - describes number of individuals at 
each of 3 separate sites for total of 25 individuals tagged.
 Column names: locality, n_individuals

obs_per_manta - 25 observations with 2 variables - describes number of observations
(or pings on tracker) for each individual manta (excludes location). 
Column names: individual-local-identifier, n_observations

obs_per_manta_site - 25 observations with 3 variables - describes number of
observations of each individual manta for each of 3 study sites. This will most likely
be most helpful for data visualization. 
Column names: locality, individual-local-identifier, n_observations

Next steps will be learning how to incorporate longitude and latitude into data
and then visualizing data 

Norina Haefelin
nxh544@miami.edu


