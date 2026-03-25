library(tidyverse)
library(ggrepel)


# Load the market data
market_data <- read_csv("data/analysis_results.csv") %>%
  mutate(date = as.Date(date))

# Load your Gemini explanations 
llm_data <- read_csv("data/llm_Successfull_explanation.csv") %>%
  mutate(date = as.Date(date))

# Combine numbers with AI text
final_analysis <- llm_data %>%
  left_join(market_data, by = "date")

# 3. ANALYSIS: Categorize the Decoupling
final_analysis <- final_analysis %>%
  mutate(status = case_when(
    nas_ret < 0 & gold_ret > 0 ~ "Safe Haven Decoupling",
    nas_ret < 0 & gold_ret < 0 ~ "Liquidity Crisis (Coupled)",
    TRUE ~ "Other"
  ))

# VISUALIZATION: The "Decoupling Dashboard"
ggplot(final_analysis, aes(x = date)) +
  geom_col(aes(y = nas_ret * 100, fill = "Nasdaq 100"), alpha = 0.7) +
  geom_col(aes(y = gold_ret * 100, fill = "Gold Futures"), alpha = 0.7) +
  
  geom_label_repel(aes(y = 0, label = str_wrap(ai_summary, 30)), 
                   size = 3, box.padding = 1) +
  scale_fill_manual(values = c("Nasdaq 100" = "#E41A1C", "Gold Futures" = "#FFD700")) +
  theme_minimal() +
  labs(title = "Financial Analysis: Decoupling during Institutional Uncertainty",
       subtitle = "Comparing Nasdaq vs. Gold Returns on Top Crash Dates",
       y = "Daily Return (%)",
       x = "Date",
       fill = "Asset")

# 5. SAVE FINAL REPORT
write_csv(final_analysis, "data/final_synthesis_report.csv")
