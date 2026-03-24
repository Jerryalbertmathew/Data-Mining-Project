library(tidyverse)
library(httr2)

# 1. FUNCTION: Updated with Gemini 3 Flash
get_gemini_context <- function(target_date) {
  message(paste("Processing date:", target_date, "..."))
  
  prompt_text <- paste(
    "Act as a financial historian. Identify the major US political or institutional",
    "events on", target_date, "that caused economic policy uncertainty.",
    "Explain why Gold and the Nasdaq 100 might have decoupled on this day."
  )
  
  # Current 2026 Stable Endpoint
  url <- "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash:generateContent"
  
  # Try/Catch to prevent the whole loop from crashing on one error
  result <- tryCatch({
    req <- request(url) %>%
      req_url_query(key = Sys.getenv("GEMINI_API_KEY")) %>%
      req_body_json(list(
        contents = list(list(parts = list(list(text = prompt_text))))
      )) %>%
      req_perform() %>%
      resp_body_json()
    
    return(req$candidates[[1]]$content$parts[[1]]$text)
    
  }, error = function(e) {
    return(paste("Error:", e$message))
  })
  
  return(result)
}

# 2. EXECUTION: Run with a small delay to avoid rate limits
analysis_results <- tibble(date = crash_dates) %>%
  mutate(ai_summary = map_chr(date, function(d) {
    Sys.sleep(1) # Wait 1 second between calls
    get_gemini_context(d)
  }))

# 3. VIEW RESULTS
print(analysis_results)
