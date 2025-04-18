
word_list <- read.csv("your_words.csv", sep="")

library(tidyverse)
library(dplyr)

words <- word_list$word

# Define a target substring to remove
target_string <- "EAST"

# Define a position constraint: 'beginning', 'middle', or 'end'
position <- "middle"

# Define a function that looks for words that meet the following criteria:
  # if you add your substring at the defined position to a string, you can find that new string somewhere else in the list

find_valid_words <- function(words, target_string, position) {
  results <- data.frame(
    Original_Word = character(),
    Word_Removed = character(),
    Length = integer(),
    New_Length = integer(),
    stringsAsFactors = FALSE
  )
  
  for (word in words) {
    if (grepl(target_string, word, fixed = TRUE)) {
      modified_word <- gsub(target_string, "", word, fixed = TRUE)
      
      if (position == "beginning" && !grepl(paste0("^", target_string), word)) {
        next
      }
      if (position == "middle" && (!grepl(paste0(".+", target_string, ".+"), word))) {
        next
      }
      if (position == "end" && !grepl(paste0(target_string, "$"), word)) {
        next
      }
      
      if (modified_word %in% words) {
        results <- rbind(results, data.frame(
          Original_Word = word,
          Word_Removed = modified_word,
          Length = nchar(word),
          New_Length = nchar(modified_word),
          stringsAsFactors = FALSE
        ))
      }
    }
  }
  
  return(results)
}

valid_words <- find_valid_words(words, target_string, position)
View(valid_words)
