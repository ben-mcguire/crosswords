word_list <- read.csv("your_words", sep="")

library(tidyverse)
library(dplyr)

words <- word_list$word

find_inner_substring <- function(words_vector, substring) {
  pattern <- paste0("(?<!^)", substring, "(?!$)")
  result <- grep(pattern, words_vector, perl = TRUE, value = TRUE)
  return(result)
}

matches <- find_inner_substring(words$word, "POLLAG")
print(matches)
