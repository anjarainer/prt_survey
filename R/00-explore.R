library(tidyverse)
library(visdat)

incomplete_df <- read_csv("data/raw/incomplete_responses.csv")


# explore missings ----
vis_dat(incomplete_df)

visdat::vis_miss(incomplete_df)

# do something else ----
