library(tidyverse)
install.packages("fredr")
library(fredr)

# set API key
fredr_set_key("335382631418e6c020d7511e7b9e27dc")

# downloading Economic Policy Uncertainty index
epu_test <- fredr(
  series_id = "USEPUINDXD",
  observation_start = as.Date("2020-01-01")
)

# show first rows
head(epu_test)
