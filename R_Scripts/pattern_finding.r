library(dplyr)
library(readr)

# pattern definition
pattern_to_regex <- function(pattern) {
  pattern <- gsub("\\*", ".", pattern)
  paste0("^", pattern, "$")
}

# function
search_words <- function(file_path, pattern) {
  words_df <- read_csv(file_path, col_types = cols(word = col_character()))
  regex_pattern <- pattern_to_regex(pattern)
  target_length <- nchar(pattern)
  
  result <- words_df %>%
    filter(nchar(word) == target_length,
           grepl(regex_pattern, word, ignore.case = FALSE))
  
  return(result)
}

file_path <- "~/your_filepath.csv"
pattern <- "B*N"

results <- search_words(file_path, pattern)
View(results)
