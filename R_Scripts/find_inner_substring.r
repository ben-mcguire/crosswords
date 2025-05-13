word_list <- read.csv("your_words", sep="")

library(tidyverse)
library(dplyr)

words <- word_list$word

find_inner_substring <- function(words_vector, substring) {
  pattern <- paste0("(?<!^)", substring, "(?!$)")
  matched_words <- grep(pattern, words_vector, perl = TRUE, value = TRUE)
  result_df <- data.frame(
    word = matched_words,
    length = nchar(matched_words),
    stringsAsFactors = FALSE
  )
}

found_patterns <- find_inner_substring(words, "EMID")
View(found_patterns)
