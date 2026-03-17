library(tidyverse)
install.packages("fredr")
library(fredr)
install.packages("tidyquant")
library(tidyquant)

# set API key
fredr_set_key(Sys.getenv("FRED_API_KEY"))

# downloading Economic Policy Uncertainty index
epu_data <- fredr(
  series_id = "USEPUINDXD",
  observation_start = as.Date("2020-01-01")
)%>% 
  select(date, epu_index = value)

# Gold and Nas100 price data
symbols <- c("GC=F", "^NDX")
market_data <- tq_get(symbols, from = "2020-01-01", get = "stock.prices") %>%
  select(date, symbol, adjusted)%>%
  pivot_wider(names_from = symbol, values_from = adjusted)

# Merging datasets
final_df <- inner_join(epu_data, market_data, by = "date") %>%
  drop_na()

print(head(final_df))
