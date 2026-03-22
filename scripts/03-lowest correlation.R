analysis_results <- read_csv("data/analysis_results.csv")

#5 dates with the lowest correlation/ highest crash
crash_dates <- analysis_df %>%
  arrange(rolling_corr) %>%
  head(5) %>%
  select(date, rolling_corr, epu_index)

print(crash_dates)
