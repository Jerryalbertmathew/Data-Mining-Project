final_df <- read_csv("data/final_df.csv")
library(tidyverse)

#Calculate Daily Returnsusing Log
analysis_df <- final_df %>%
  
  mutate(
    `GC=F` = as.numeric(`GC=F`),
    `^NDX` = as.numeric(`^NDX`),
    epu_index = as.numeric(epu_index)
  ) %>%
  
  mutate(
    gold_ret = log(`GC=F` / lag(`GC=F`)),
    nas_ret  = log(`^NDX` / lag(`^NDX`)),
    epu_diff = epu_index - lag(epu_index)
  ) %>%
  drop_na()

#Rolling Correlation with 30-day Window
install.packages("roll")
library(roll)
analysis_df$rolling_corr <- roll_cor(analysis_df$gold_ret, 
                                     analysis_df$nas_ret, 
                                     width = 30)

# Plot Analysis to see the relationship between rolling correlation and EPU index
ggplot(analysis_df, aes(x = date)) +
  geom_line(aes(y = rolling_corr, color = "Gold-NAS Correlation")) +
  geom_line(aes(y = epu_index/500, color = "Friction (Scaled)"), linetype = "dashed") +
  theme_minimal() +
  labs(title = "The Friction Effect: Correlation vs. EPU Index",
       subtitle = "Does high uncertainty decouple these assets?",
       y = "Value", color = "Metric")

write_csv(analysis_df, "data/analysis_results.csv")

ggsave("plot/friction_correlation_plot.png", width = 8, height = 5)
